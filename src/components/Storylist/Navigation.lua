local Flipbook = script:FindFirstAncestor("Flipbook")
local Components = Flipbook.components
local Vendor = Flipbook.vendor

local Roact = require(Vendor.Roact)

local RoundedFrame = require(Components.Generic.RoundedFrame)
local Searchbar = require(Components.Generic.Searchbar)
local Icon = require(Components.Generic.Icon)

local e = Roact.createElement

local function Navigation(props)
	local theme = props.Theme

	return e("Frame", {
		Size = UDim2.new(1, 0, 0, 75),
		BackgroundTransparency = 1
	}, {
		List = e("UIListLayout", {
			Padding = UDim.new(0, 10),
			SortOrder = Enum.SortOrder.LayoutOrder
		}),

		Padding = e("UIPadding", {
			PaddingTop = UDim.new(0, 10),
			PaddingLeft = UDim.new(0, 10),
		}),

		Topbar = e("Frame", {
			Size = UDim2.new(1, 0, 0, 30),
			LayoutOrder = 0,
			BackgroundTransparency = 1
		}, {
			List = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				Padding = UDim.new(0, 10),
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center
			}),

			Logo = e("Frame", {
				Size = UDim2.new(1, -35, 0, 30),
				LayoutOrder = 0,
				BackgroundTransparency = 1,
			}, {
				List = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					Padding = UDim.new(0, 2),
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalAlignment = Enum.VerticalAlignment.Center
				}),

				Header = e("TextLabel", {
					Size = UDim2.new(1, 0, 0, 30),
					Position = UDim2.fromOffset(30, 0),
					TextXAlignment = Enum.TextXAlignment.Left,
					LayoutOrder = 1,
					BackgroundTransparency = 1,
					TextSize = 20,
					Font = Enum.Font.GothamBlack,
					Text = "flipbook",
					TextColor3 = theme.BrandIcon
				}),
			}),


			Options = e(RoundedFrame, {
				Size = UDim2.fromOffset(25, 25),
				LayoutOrder = 2,
				BackgroundTransparency = 1,
				Border = 1,
				BorderColor = theme.Border,
				CornerRadius = UDim.new(0.5, 0)
			}, {
				Icon = e(Icon, {
					Size = UDim2.fromOffset(18, 18),
					Position = UDim2.fromScale(0.5, 0.5),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Image = "rbxassetid://6991874602",
					ImageColor3 = theme.Text
				})
			}),
		}),

		Searchbar = e(Searchbar, { Theme = theme })
	})
end

return Navigation