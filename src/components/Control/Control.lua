local Flipbook = script:FindFirstAncestor("Flipbook")
local Components = Flipbook.components
local Vendor = Flipbook.vendor

local Roact = require(Vendor.Roact)
local Hooks = require(Vendor.Hooks)

local RoundedFrame = require(Components.Generic.RoundedFrame)
local Dropshadow = require(Components.Generic.Dropshadow)
local Topbar = require(script.Parent.Topbar)
local CodePreview = require(script.Parent.CodePreview.CodePreview)

local e = Roact.createElement
local hook = Hooks.new(Roact)

local function Control(props, hooks)
	local theme = props.Theme
	local object = props.Selected and props.Selected.Object

	local currentPage, setCurrentPage = hooks.useState("Controls")

	return e("Frame", {
		Size = UDim2.new(1, 0, 0, 800),
		Position = UDim2.new(0, 0, 1, 0),
		AnchorPoint = Vector2.new(0, 1),
		BackgroundTransparency = 1,
		Visible = props.Visible
	}, {
		Dropshadow = e(Dropshadow, {
			Size = UDim2.fromScale(1, 1)
		}),

		Container = e(RoundedFrame, {
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = theme.Background,
			CornerRadius = UDim.new(0, 5)
		}, {
			Topbar = e(Topbar, { SetPage = setCurrentPage, Theme = theme }),
			SourceCode = e(CodePreview, {
				Visible = currentPage == "Source",
				Object = object,
			})
		})
	})
end

Control = hook(Control)

return Control