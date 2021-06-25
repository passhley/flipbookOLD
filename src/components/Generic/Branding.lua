local TextService = game:GetService("TextService")

local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local Theme = require(Utility.Theme)

local TextLabel = require(script.Parent.TextLabel)

local e = Roact.createElement

local function Branding(props)
	local textSize = props.TextSize or 15
	local size = props.Size or nil
	local align = props.TextXAlignment or nil

	local containerSize = TextService:GetTextSize(
		"flipbook",
		textSize,
		Enum.Font.GothamBlack,
		Vector2.new(math.huge, math.huge)
	)

	return e(TextLabel, {
		Size = size or UDim2.fromOffset(containerSize.X, containerSize.Y),
		Text = "flipbook",
		Font = Enum.Font.GothamBlack,
		TextColor3 = Theme.Brand,
		Position = props.Position or UDim2.fromOffset(0, 0),
		AnchorPoint = props.AnchorPoint or Vector2.new(0, 0),
		ZIndex = props.ZIndex or 1,
		TextSize = textSize,
		LayoutOrder = props.LayoutOrder or 0,
		TextXAlignment = align or Enum.TextXAlignment.Center
	})
end

return Branding