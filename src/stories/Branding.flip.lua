local Flipbook = script:FindFirstAncestor("Flipbook")
local Components = Flipbook.components
local Vendor = Flipbook.vendor

local Roact = require(Vendor.Roact)

local Branding = require(Components.Generic.Branding)

local e = Roact.createElement

return {
	Location = "flipbook Components",
	Mount = function(t)
		local handle = Roact.mount(e(Branding, {
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			TextSize = 100
		}), t)

		return function()
			Roact.unmount(handle)
		end
	end
}