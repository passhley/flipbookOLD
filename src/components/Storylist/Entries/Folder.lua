local Flipbook = script:FindFirstAncestor("Flipbook")
local Components = Flipbook.components
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local Hooks = require(Vendor.Hooks)
local MergeTables = require(Utility.MergeTables)

local Arrow = require(Components.Generic.Arrow)
local Icon = require(Components.Generic.Icon)
local Component = require(script.Parent.Component)

local e = Roact.createElement
local hook = Hooks.new(Roact)

local function Folder(props, hooks)
	local theme = props.Theme
	local folderName = props.FolderName or "AA"
	local components = props.Components or {}

	local expandedSize = (#components*26)+10
	local open, setOpen = hooks.useState(false)

	local componentObjects = {}
	for _, component in ipairs(components) do
		local isSelected = false
		if props.SelectedComponent then
			if props.SelectedComponent.Name == component.Name then
				isSelected = true
			end
		end

		componentObjects[component] = e(Component, {
			Theme = theme,
			ComponentName = component.Name,
			Selected = isSelected,
			OnClick = props.SelectComponent,
			Object = component.Object
		})
	end

	local currentSize = UDim2.new(1, 0, 0, 26)
	local activeSize = UDim2.new(1, 0, 0, expandedSize+26)

	return e("Frame", {
		Size = open and activeSize or currentSize,
		BorderSizePixel = 0,
		BackgroundTransparency = 1
	}, {
		FolderHeader = e("Frame", {
			Size = UDim2.new(1, 0, 0, 26),
			BorderSizePixel = 0,
			BackgroundTransparency = 1
		}, {
			Arrow = e(Arrow, {
				Size = UDim2.fromOffset(20, 20),
				Position = UDim2.new(0, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				Direction = open and "Down" or "Right",
				Theme = theme
			}),

			Icon = e(Icon, {
				Size = UDim2.fromOffset(16, 16),
				Image = "rbxassetid://6991866090",
				Position = UDim2.new(0, 20, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				ImageColor3 = theme.Storylist.Folder
			}),

			Header = e("TextLabel", {
				Size = UDim2.new(1, -(16+20), 1, 0),
				Position = UDim2.fromOffset(16+20+10, 0),
				TextSize = 14,
				Font = Enum.Font.Gotham,
				TextXAlignment = Enum.TextXAlignment.Left,
				BackgroundTransparency = 1,
				TextColor3 = theme.Text,
				Text = folderName
			}),

			Hitbox = e("TextButton", {
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				Text = "",

				[Roact.Event.Activated] = function()
					setOpen(not open)
				end
			})
		}),

		Children = e("Frame", {
			Size = UDim2.new(1, 0, 0, (expandedSize-5)),
			Position = UDim2.fromOffset(0, 26),
			Visible = open == true,
			BackgroundTransparency = 1
		}, MergeTables(componentObjects, {
			List = e("UIListLayout")
		}))

	})
end

return hook(Folder)