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
					FillDirection = Enum.FillDirection.Horizontal
				}),

				Canvas = e("TextButton", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(0.5, 1),
					Text = "Canvas",
					Font = Enum.Font.Gotham,
					TextSize = 16,
					TextColor3 = selected == "Canvas" and theme.Storylist.Selected or theme.Text,
					[Roact.Event.Activated] = function()
						setSelected("Canvas")
						props.SetCurrentPage("Canvas")
					end
				}),

				Docs = e("TextButton", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(0.5, 1),
					Position = UDim2.fromScale(0.5, 0),
					Text = "Docs",
					Font = Enum.Font.Gotham,
					TextSize = 16,
					TextColor3 = selected == "Docs" and theme.Storylist.Selected or theme.Text,
					[Roact.Event.Activated] = function()
						setSelected("Docs")
						props.SetCurrentPage("Docs")
					end
				})

			}),

			Border1 = e("Frame", {
				Size = UDim2.new(0, 1, 1, -15),
				BorderSizePixel = 0,
				BackgroundColor3 = theme.Border,
				LayoutOrder = 2
			})

		}),

		SelectedBorder = e("Frame", {
			Size = selected == "Canvas" and UDim2.new(0, 70, 0, 4) or UDim2.new(0, 55, 0, 4),
			BorderSizePixel = 0,
			BackgroundColor3 = theme.Storylist.Selected,
			Position = selected == "Canvas" and UDim2.new(0, 12, 1, -4) or UDim2.new(0, 95, 1, -4)
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