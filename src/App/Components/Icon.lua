local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local MergeTables = require(Utility.MergeTables)

local e = Roact.createElement

local function Icon(props)
	return e("ImageLabel", MergeTables(props, {
		BackgroundTransparency = 1,
	}))
end

return Icon