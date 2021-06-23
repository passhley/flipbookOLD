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
	local theme = props.Theme
	local direction = props.Direction or "Right"

	props.Theme = nil
	props.Direction = nil

	return e("ImageLabel", MergeTables(props, {
		BackgroundTransparency = 1,
		Image = DIRECTION_MAP[direction],
		ImageColor3 = theme.Border
	}))
end

return Arrow