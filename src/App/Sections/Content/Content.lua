local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local Hooks = require(Vendor.Hooks)

local Components = script.Parent.Parent.Parent.Components
local RoundedFrame = require(Components.RoundedFrame)
local ScrollingFrame = require(Components.ScrollingFrame)
local Dropshadow = require(Components.Dropshadow)
local ContentNavbar = require(script.Parent.ContentNavbar)
local Preview = require(script.Parent.Preview)

local e = Roact.createElement
local hook = Hooks.new(Roact)

local function Content(props)
	local theme = props.Theme

	return e("Frame", {
		Size = UDim2.new(1, -280, 1, -20),
		Position = UDim2.fromOffset(270, 10),
		BackgroundTransparency = 1
	}, {
		Dropshadow = e(Dropshadow),
		Container = e(RoundedFrame, {
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = theme.CanvasBackground
		}, {
			Navbar = e(ContentNavbar, { Theme = theme }),
			Content = e(ScrollingFrame, {
				Size = UDim2.new(1, -20, 1, -70),
				Position = UDim2.fromOffset(10, 60),
				ScrollBarImageColor3 = theme.TextSecondary
			}, {
				Preview = e(Preview)
			})
		})
	})
end

return Content