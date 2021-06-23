local Flipbook = script:FindFirstAncestor("Flipbook")
local Components = Flipbook.components
local Vendor = Flipbook.vendor

local Roact = require(Vendor.Roact)

local RoundedFrame = require(Components.Generic.RoundedFrame)
local Dropshadow = require(Components.Generic.Dropshadow)
local Topbar = require(script.Parent.Topbar)
local CodePreview = require(script.Parent.CodePreview.CodePreview)

local e = Roact.createElement

local function Control(props)
	local theme = props.Theme
	local object = props.Selected and props.Selected.Object

	return e("Frame", {
		Size = UDim2.new(1, 0, 0, 800),
		Position = UDim2.new(0, 0, 1, 0),
		AnchorPoint = Vector2.new(0, 1),
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
			e(Topbar, { Theme = theme }),
			e(CodePreview, {
				Object = object,
			})
		})
	})
end

return Control