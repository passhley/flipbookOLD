local Flipbook = script:FindFirstAncestor("Flipbook")
local Components = Flipbook.components
local Vendor = Flipbook.vendor

local Roact = require(Vendor.Roact)
local Hooks = require(Vendor.Hooks)

local RoundedFrame = require(Components.Generic.RoundedFrame)
local Dropshadow = require(Components.Generic.Dropshadow)
local Topbar = require(script.Parent.Topbar)
local Preview = require(script.Parent.Preview)
local Control = require(Components.Control.Control)

local e = Roact.createElement
local hook = Hooks.new(Roact)

local function PreviewZone(props, hooks)
	local theme = props.Theme
	local selected = props.Selected

	local currentPage, setCurrentPage = hooks.useState("Canvas")

	return e("Frame", {
		Size = UDim2.new(1, -270, 1, -20),
		Position = UDim2.fromOffset(260, 10),
		BackgroundTransparency = 1,
	}, {
		Dropshadow = e(Dropshadow, {
			Size = UDim2.fromScale(1, 1)
		}),

		Container = e(RoundedFrame, {
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = theme.Background,
			CornerRadius = UDim.new(0, 5)
		}, {
			Topbar = e(Topbar, { SetCurrentPage = setCurrentPage,  Theme = theme }),

			Content = e("ScrollingFrame", {
				Size = UDim2.new(1, 0, 1, -70),
				CanvasSize = UDim2.fromOffset(0, 800+350+10),
				Position = UDim2.fromOffset(0, 60),
				LayoutOrder = 1,
				ScrollBarThickness = 8,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ScrollBarImageColor3 = theme.Border,
				TopImage = "rbxassetid://6017290134",
				BottomImage = "rbxassetid://6017289712",
				MidImage = "rbxassetid://6017289904"
			}, {
				Preview = e(Preview, { Selected = selected }),
				Control = e(Control, { Visible = currentPage == "Canvas", Theme = theme, Selected = selected })
			})
		})
	})
end

PreviewZone = hook(PreviewZone)

return PreviewZone