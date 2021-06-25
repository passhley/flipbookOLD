local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local MergeTables = require(Utility.MergeTables)

local e = Roact.createElement

local DIRECTION_MAP = {
	Left = "rbxassetid://6031091002",
	Right = "rbxassetid://6031090994",
	Up = "rbxassetid://6031090990",
	Down = "rbxassetid://6031091004"
}

local function Arrow(props)
	local direction = props.Direction or "Right"
	props.Direction = nil

	return e("ImageLabel", MergeTables(props, {
		BackgroundTransparency = 1,
		Image = DIRECTION_MAP[direction],
		ImageColor3 = props.ImageColor3 or Color3.new(0, 0, 0)
	}))
end

return Arrow