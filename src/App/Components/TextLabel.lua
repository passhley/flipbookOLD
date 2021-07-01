local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local MergeTables = require(Utility.MergeTables)

local e = Roact.createElement

local function TextLabel(props)
	return e("TextLabel", MergeTables(props, {
		BackgroundTransparency = 1,
	}))
end

return TextLabel