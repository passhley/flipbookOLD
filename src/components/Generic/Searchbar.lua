local Flipbook = script:FindFirstAncestor("Flipbook")
local Components = Flipbook.components
local Vendor = Flipbook.vendor

local Roact = require(Vendor.Roact)

local RoundedFrame = require(Components.Generic.RoundedFrame)

local e = Roact.createElement

local function Searchbar(props)
	local theme = props.Theme

	return e(RoundedFrame, {
		LayoutOrder = 1,
		Size = UDim2.new(1, 0, 0, 25),
		BackgroundTransparency = 1,
		Border = 1,
		BorderColor = theme.Border,
		CornerRadius = UDim.new(0.5, 0)
	}, {

		Icon = e("ImageLabel", {
			Size = UDim2.fromOffset(16, 16),
			Position = UDim2.fromScale(0, 0.5),
			AnchorPoint = Vector2.new(0, 0.5),
			BorderSizePixel = 0,
			Image = "rbxassetid://6991866447",
			ImageColor3 = theme.TextSecondary,
			BackgroundTransparency = 1
		}),

		Header = e("TextLabel", {
			Position = UDim2.fromOffset(30, 0),
			Size = UDim2.new(0, 100, 1, 0),
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = "Find component",
			BackgroundTransparency = 1,
			Font = Enum.Font.Gotham,
			TextSize = 13,
			TextColor3 = theme.TextSecondary
		}),

		InputKey = e(RoundedFrame, {
			Size = UDim2.fromOffset(17, 17),
			Position = UDim2.new(1, 0, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundColor3 = theme.Border
		}, {
			Header = e("TextLabel", {
				Size = UDim2.fromScale(1, 1),
				Text = "/",
				BackgroundTransparency = 1,
				Font = Enum.Font.Gotham,
				TextSize = 10,
				TextColor3 = theme.TextSecondary
			}),
		}),

		Padding = e("UIPadding", {
			PaddingLeft = UDim.new(0, 10),
			PaddingRight = UDim.new(0, 10),
		})

	})
end

return Searchbar