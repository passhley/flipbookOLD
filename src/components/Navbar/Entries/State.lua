local Flipbook = script:FindFirstAncestor("Flipbook")
local Components = Flipbook.components
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local Theme = require(Utility.Theme)

local Icon = require(Components.Generic.Icon)
local TextLabel = require(Components.Generic.TextLabel)

local e = Roact.createElement

local function State(props)
	local theme = props.Theme or Theme.Light

	local stateName = props.Name or "State"

	return e("Frame", {
		Size = UDim2.new(1, 0, 0, 26),
		BackgroundTransparency = 1
	}, {
		Padding = e("UIPadding", { PaddingLeft = UDim.new(0, 30) }),
		Icon = e(Icon, {
			Size = UDim2.fromOffset(16, 16),
			Position = UDim2.new(0, 20, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			Image = "rbxassetid://6994866787",
			ImageColor3 = theme.Icons.State
		}),
		Header = e(TextLabel, {
			Size = UDim2.new(1, -45, 0, 20),
			Position = UDim2.new(0, 45, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			Text = stateName,
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
			end
		})
	})
end

return State