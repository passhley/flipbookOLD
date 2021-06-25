local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local Hooks = require(Vendor.Hooks)
local MergeTables = require(Utility.MergeTables)

local e = Roact.createElement
local createRef = Roact.createRef
local hook = Hooks.new(Roact)

local function WrappingTextbox(props, hooks)
	local textboxSize, setTextboxSize = hooks.useState(0)
	local textbox = hooks.useValue(createRef())
	local container = hooks.useValue(createRef())
	local position, setPosition = hooks.useState(0)

	hooks.useEffect(function()
		setPosition(math.clamp(container.value:getValue().AbsoluteSize.X - textboxSize, -math.huge, 0))
	end, {textboxSize, position})

	hooks.useEffect(function()
		if props.FocusCaptured then
			textbox.value:getValue():CaptureFocus()
		end
	end, {props.FocusCaptured})

	return e("Frame", MergeTables({
		Size = UDim2.fromOffset(0, 0),
		Position = UDim2.fromOffset(0, 0),
		AnchorPoint = Vector2.new(0, 0),
		Visible = true,
		BackgroundTransparency = 0,
		ClipsDescendants = true,
		[Roact.Ref] = container.value
	}, props.Native), {
		Textbox = e("TextBox", MergeTables({
			Size = textboxSize > props.Native.Size.X.Offset and UDim2.new(0, textboxSize, 1, 0) or UDim2.fromScale(1, 1),
			Position = UDim2.fromOffset(position, 0),
			BackgroundTransparency = 1,
			Font = Enum.Font.Gotham,
			TextSize = 15,
			TextColor3 = Color3.new(0, 0, 0),
			TextXAlignment = Enum.TextXAlignment.Left,
			PlaceholderText = "",
			PlaceholderColor3 = Color3.new(1, 1, 1),
			Text = "",
			[Roact.Event.FocusLost] = function(_, enterPressed)
				if props.OnFocusLost then
					props.OnFocusLost(enterPressed)
				end
			end,
			[Roact.Change.Text] = function(rbx)
				setTextboxSize(rbx.TextBounds.X)
				if props.OnTextChanged then
					props.OnTextChanged(rbx.Text)
				end
			end,
			[Roact.Ref] = textbox.value
		}, props.Textbox))
	})
end

return hook(WrappingTextbox)