local Flipbook = script:FindFirstAncestor("Flipbook")
local Components = Flipbook.components
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local Hooks = require(Vendor.Hooks)
local Theme = require(Utility.Theme)

local TextLabel = require(Components.Generic.TextLabel)
local RoundedFrame = require(Components.Generic.RoundedFrame)
local Icon = require(Components.Generic.Icon)
local WrappingTextbox = require(Components.Generic.WrappingTextbox)

local e = Roact.createElement
local hook = Hooks.new(Roact)

local function Searchbar(props, hooks)
	local useState = hooks.useState

	local theme = props.Theme or Theme.Dark
	local size = props.Size or UDim2.fromOffset(200, 24)
	local position = props.Position or UDim2.fromScale(0.5, 0.5)
	local anchor = props.AnchorPoint or Vector2.new(0.5, 0.5)

	local textBoxActive, setTextBoxActive = useState(false)

	return e(RoundedFrame, {
		Size = size,
		Position = position,
		AnchorPoint = anchor,
		BackgroundTransparency = textBoxActive == false and 1 or 0,
		BackgroundColor3 = theme.InputField.Background,
		CornerRadius = UDim.new(1, 0)
	}, {

		Stroke = e("UIStroke", {
			Thickness = 1,
			Color = textBoxActive == false and theme.TextSecondary or theme.InputField.Selected
		}),

		SearchIcon = e(Icon, {
			Size = UDim2.fromOffset(16, 16),
			Position = UDim2.new(0, 7, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			Image = "rbxassetid://6994940034",
			ImageColor3 = theme.TextSecondary
		}),

		Find = e(TextLabel, {
			Size = UDim2.new(1, -60, 1, -8),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Text = "Find Component",
			TextSize = 10,
			TextColor3 = theme.TextSecondary,
			TextXAlignment = Enum.TextXAlignment.Left,
			Visible = textBoxActive == false
		}),

		InputField = e(WrappingTextbox, {
			Native = {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, -40, 1, -8),
				Position = UDim2.new(0, 30, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				Visible = textBoxActive == true,
			},

			Textbox = {
				Text = "a",
				PlaceholderText = "Type to find...",
				PlaceholderColor3 = theme.TextSecondary,
				TextSize = 13,
				Font = Enum.Font.Gotham,
				TextColor3 = theme.TextPrimary,
				TextXAlignment = Enum.TextXAlignment.Left,
			},

			FocusCaptured = textBoxActive,

			OnFocusLost = function()
				if textBoxActive == true then
					setTextBoxActive(false)
				end
			end,

			OnTextChanged = function(text)
				if textBoxActive == true then
					if props.OnTextUpdated then
						props.OnTextUpdated(text)
					end
				end
			end
		}),

		Hitbox = e("TextButton", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Text = "",

			[Roact.Event.Activated] = function()
				if textBoxActive == false then
					setTextBoxActive(true)
				end
			end
		})
	})
end

return hook(Searchbar)