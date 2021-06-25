local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor

local Roact = require(Vendor.Roact)

local e = Roact.createElement

local function EqualPadding(props)
	local padding = props.Padding or UDim.new(0, 5)

	return e("UIPadding", {
		PaddingLeft = padding,
		PaddingRight = padding,
		PaddingTop = padding,
		PaddingBottom = padding,
	}) 
end

return EqualPadding