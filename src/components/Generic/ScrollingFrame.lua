local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local MergeTables = require(Utility.MergeTables)

local e = Roact.createElement

local function ScrollingFrame(props)
	return e("ScrollingFrame", MergeTables(props, {
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		ScrollBarThickness = 8,
		TopImage = "rbxassetid://6017290134",
		MidImage = "rbxassetid://6017289904",
		BottomImage = "rbxassetid://6017289712"
	}))
end

return ScrollingFrame