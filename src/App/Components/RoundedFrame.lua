local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local MergeTables = require(Utility.MergeTables)

local e = Roact.createElement

local function RoundedFrame(props)
	local children = props[Roact.Children] or {}
	local cornerRadius = props.CornerRadius or UDim.new(0, 4)

	props[Roact.Children] = nil
	props.CornerRadius = nil

	return e("Frame", props, MergeTables(children, {
		UICorner = e("UICorner", {CornerRadius = cornerRadius}),
	}))
end

return RoundedFrame