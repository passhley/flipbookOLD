local Flipbook = script:FindFirstAncestor("Flipbook")
local Components = Flipbook.components
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local Hooks = require(Vendor.Hooks)
local CustomHooks = require(Utility.CustomHooks)

local TextLabel = require(Components.Generic.TextLabel)
local Icon = require(Components.Generic.Icon)

local e = Roact.createElement
local useTheme = CustomHooks.useTheme
local hook = Hooks.new(Roact)

local function IconPreview(props)
	local theme = props.Theme

	return e("Frame", {
		Size = UDim2.fromOffset(60, 40),
		Position = props.Position or UDim2.fromOffset(0, 0),
		BackgroundTransparency = 1
	}, {
		Header = e(TextLabel, {
			TextColor3 = theme.TextPrimary,
			TextSize = 10,
			Size = UDim2.new(1, 0, 0, 10),
			Text = props.Header
		}),

		Icon = e(Icon, {
			ImageColor3 = props.Color or theme.TextPrimary,
			Size = UDim2.fromOffset(16, 16),
			Position = UDim2.fromOffset(22, 20),
			Image = props.Icon
		})
	})
end

local function IconsApp(_, hooks)
	local theme = useTheme(hooks)

	return e("Frame", {
		Size = UDim2.new(1, -20, 1, -20),
		Position = UDim2.fromOffset(10, 10),
		BackgroundTransparency = 1
	}, {
		Grid = e("UIGridLayout", {
			CellSize = UDim2.fromOffset(60, 40),
			CellPadding = UDim2.fromOffset(10, 50)
		}),
		Folder = e(IconPreview, { Theme = theme, Header = "Folder", Color = theme.Icons.Folder, Icon = "rbxassetid://6991866090" }),
		Component = e(IconPreview, { Theme = theme, Header = "Component", Color = theme.Icons.Component, Icon = "rbxassetid://6991866319" }),
		State = e(IconPreview, { Theme = theme, Header = "State", Color = theme.Icons.State, Icon = "rbxassetid://6994866787" }),
		Search = e(IconPreview, { Theme = theme, Header = "Search", Icon = "rbxassetid://6994940034" }),
		Menu = e(IconPreview, { Theme = theme, Header = "Menu", Icon = "rbxassetid://6991874602" }),
		ZoomIn = e(IconPreview, { Theme = theme, Header = "Zoom In", Icon = "rbxassetid://6994866930" }),
		ZoomOut = e(IconPreview, { Theme = theme, Header = "Zoom Out", Icon = "rbxassetid://6994867103" }),
	})
end
IconsApp = hook(IconsApp)


return {
	Location = "flipbook Components",
	Mount = function(t)
		local handle = Roact.mount(e(IconsApp), t)
		return function()
			Roact.unmount(handle)
		end
	end
}