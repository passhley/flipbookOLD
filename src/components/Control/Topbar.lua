local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor

local Roact = require(Vendor.Roact)
local Hooks = require(Vendor.Hooks)

local e = Roact.createElement
local hook = Hooks.new(Roact)

local function Topbar(props, hooks)
	local theme = props.Theme
	local selected, setSelected = hooks.useState("Controls")

	return e("Frame", {
		Size = UDim2.new(1, 0, 0, 50),
		BackgroundTransparency = 1,
	}, {
		Container = e("Frame", {
			Size = UDim2.new(1, 0, 1, -2),
			BackgroundTransparency = 1
		}, {

			List = e("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				Padding = UDim.new(0, 5)
			}),

			Padding = e("UIPadding", {
				PaddingLeft = UDim.new(0, 10),
				PaddingRight = UDim.new(0, 10),
			}),

			MainNav = e("Frame", {
				Position = UDim2.fromOffset(10, 0),
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 150, 1, 0),
				LayoutOrder = 0
			}, {

				List = e("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					Padding = UDim.new(0, 50)
				}),

				Controls = e("TextButton", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(0.5, 1),
					Text = "Controls",
					Font = Enum.Font.Gotham,
					TextSize = 16,
					TextColor3 = selected == "Controls" and theme.Storylist.Selected or theme.Text,
					[Roact.Event.Activated] = function()
						setSelected("Controls")
						props.SetPage("Controls")
					end
				}),

				Source = e("TextButton", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(0.5, 1),
					Position = UDim2.fromScale(0.5, 0),
					Text = "Source",
					Font = Enum.Font.Gotham,
					TextSize = 16,
					TextColor3 = selected == "Source" and theme.Storylist.Selected or theme.Text,
					[Roact.Event.Activated] = function()
						setSelected("Source")
						props.SetPage("Source")
					end
				})

			}),

		}),

		SelectedBorder = e("Frame", {
			Size = selected == "Source" and UDim2.new(0, 65, 0, 4) or UDim2.new(0, 70, 0, 4),
			BorderSizePixel = 0,
			BackgroundColor3 = theme.Storylist.Selected,
			Position = selected == "Source" and UDim2.new(0, 140, 1, -4) or UDim2.new(0, 12, 1, -4)
		}),

		BottomBorder = e("Frame", {
			Size = UDim2.new(1, 0, 0, 2),
			BorderSizePixel = 0,
			BackgroundColor3 = theme.Border,
			Position = UDim2.new(0, 0, 1, -2)
		})
	})
end
Topbar = hook(Topbar)

return Topbar