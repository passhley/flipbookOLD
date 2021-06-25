local Flipbook = script:FindFirstAncestor("Flipbook")
local Components = Flipbook.components
local Vendor = Flipbook.vendor

local Roact = require(Vendor.Roact)

local Searchbar = require(Components.Searchbar.Searchbar)

local e = Roact.createElement

return {
	Location = "flipbook Components",
	Mount = function(t)
		local handle = Roact.mount(
			e("Frame", {
				Size = UDim2.fromOffset(500, 200),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.fromRGB(19, 19, 19),
				BorderSizePixel = 0
			}, {
				e(Searchbar, {
					OnTextUpdated = print
				})
			}),
			t
		)
		return function()
			Roact.unmount(handle)
		end
	end
}