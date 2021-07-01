local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local Hooks = require(Vendor.Hooks)

local Components = script.Parent.Parent.Parent.Components
local Icon = require(Components.Icon)
local PageNavigation = require(script.Parent.PageNavigation)

local e = Roact.createElement
local hook = Hooks.new(Roact)

local function ContentNavbar(props, hooks)
	local theme = props.Theme

	return e("Frame", {
		Size = UDim2.new(1, 0, 0, 50),
		BackgroundTransparency = 1
	}, {

		PageNavigation = e(PageNavigation, { Theme = theme }),

		Divider = e("Frame", {
			Size = UDim2.new(0, 1, 1, -20),
			Position = UDim2.fromOffset(165, 10),
			BorderSizePixel = 0,
			BackgroundColor3 = theme.TextSecondary
		}),

		BottomBorder = e("Frame", {
			Size = UDim2.new(1, 0, 0, 1),
			Position = UDim2.new(0, 0, 1, -1),
			BackgroundColor3 = theme.TextSecondary,
			BorderSizePixel = 0
		})

	})
end

return hook(ContentNavbar)