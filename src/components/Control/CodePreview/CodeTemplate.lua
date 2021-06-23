local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor

local Roact = require(Vendor.Roact)

local e = Roact.createElement

local function CodeTemplate(props)
	local text = props.Text or ""
	local textColor = props.TextColor3 or Color3.new(1, 1, 1)
	local size = props.Size or UDim2.fromOffset(0, 0)
	local position = props.Position or UDim2.fromOffset(0, 0)

	return e("TextLabel", {
		BackgroundTransparency = 1,
		Font = Enum.Font.Code,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		AutoLocalize = false,
		Size = size,
		Position = position,
		Text = text,
		TextColor3 = textColor
	})
end

return CodeTemplate