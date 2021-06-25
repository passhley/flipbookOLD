local Flipbook = script:FindFirstAncestor("Flipbook")
local Components = Flipbook.components
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local Hooks = require(Vendor.Hooks)
local Theme = require(Utility.Theme)
local MergeTables = require(Utility.MergeTables)

local Icon = require(Components.Generic.Icon)
local Arrow = require(Components.Generic.Arrow)
local TextLabel = require(Components.Generic.TextLabel)
local Component = require(script.Parent.Component)

local e = Roact.createElement
local hook = Hooks.new(Roact)

local function Folder(props, hooks)
	local theme = props.Theme or Theme.Light
	local open, setOpen = hooks.useState(false)

	local folderName = props.FolderName or "Folder"
	local stories = props.Stories or {}

	return e("Frame", {
		Size = UDim2.new(1, 0, 0, open and 525 or 25),
		BackgroundTransparency = 1
	}, {

		Header = e("Frame", {
			Size = UDim2.new(1, 0, 0, 25),
			BackgroundTransparency = 1
		}, {
			Arrow = e(Arrow, { Direction = open and "Down" or "Right", Size = UDim2.fromOffset(16, 16), Position = UDim2.fromOffset(0, 2), ImageColor3 = theme.TextSecondary }),
			Icon = e(Icon, { Image = "rbxassetid://6991866090", ImageColor3 = theme.Icons.Folder, Size = UDim2.fromOffset(16, 16), Position = UDim2.fromOffset(20, 2) }),
			Header = e(TextLabel, {
				Text = folderName,
				Size = UDim2.new(1, -45, 0, 20),
				Position = UDim2.fromOffset(45, 0),
				TextXAlignment = Enum.TextXAlignment.Left,
				Font = Enum.Font.Gotham,
				TextColor3 = theme.TextPrimary,
				TextSize = 14
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

		Components = e("Frame", {
			Size = UDim2.new(1, 0, 0, 500),
			Visible = open == true,
			Position = UDim2.fromOffset(0, 25),
			BackgroundTransparency = 1
		}, MergeTables({}, {
			List = e("UIListLayout")
		}))

	})
end

return hook(Folder)