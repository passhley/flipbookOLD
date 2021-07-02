local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local Hooks = require(Vendor.Hooks)
local Flipper = require(Vendor.Flipper)
local CustomHooks = require(Utility.CustomHooks)
local Theme = require(Utility.Theme.Theme)

local Components = script.Parent.Parent
local RoundedFrame = require(Components.RoundedFrame)
local TextLabel = require(Components.TextLabel)

local e = Roact.createElement
local hook = Hooks.new(Roact)
local useSingleMotor = CustomHooks.useSingleMotor

local function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

local function Slider(props, hooks)
	local theme = props.Theme or Theme.Dark
	local size = props.Size or UDim2.fromOffset(200, 30)
	local position = props.Position or UDim2.fromOffset(0, 0)
	local anchorPoint = props.AnchorPoint or Vector2.new(0, 0)
	local displayValue = props.DisplayValue or true
	local max = props.Max or 1
	local min = props.Min or 0
	local map = props.Map or nil

	local hoverSpring, setHoverSpring = useSingleMotor(1, hooks)
	local percent, setPercent = useSingleMotor(0.5, hooks)
	local active = hooks.useValue(false)
	local barRef = hooks.useValue(Roact.createRef(nil))
	local mappedValue, setMappedValue = hooks.useBinding(0.5)

	return e("Frame", {
		Size = size,
		Position = position,
		AnchorPoint = anchorPoint,
		BackgroundTransparency = 1,

		[Roact.Event.InputBegan] = function(_, input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				local bar = barRef.value:getValue()
				local sliderBounds = Vector2.new(
					bar.AbsolutePosition.X,
					bar.AbsolutePosition.X + bar.AbsoluteSize.X/2
				)

				local posX = input.Position.X
				local diff = posX - sliderBounds.X
				local thisPercent = diff/bar.AbsoluteSize.X
				thisPercent = math.clamp(thisPercent, 0, 1)

				local thisMappedValue = round(min + ((max - min)*thisPercent), 2)
				setMappedValue(thisMappedValue)
				if map then
					map(thisMappedValue)
				end

				setPercent(Flipper.Spring.new(thisPercent))
			end
		end,
		[Roact.Event.InputEnded] = function()
			active.value = false
		end,
		[Roact.Event.InputChanged] = function(_, input)
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				if active.value == true then
					local bar = barRef.value:getValue()
					local sliderBounds = Vector2.new(
						bar.AbsolutePosition.X,
						bar.AbsolutePosition.X + bar.AbsoluteSize.X/2
					)

					local posX = input.Position.X
					local diff = posX - sliderBounds.X
					local thisPercent = diff/bar.AbsoluteSize.X
					thisPercent = math.clamp(thisPercent, 0, 1)

					local thisMappedValue = round(min + ((max - min)*thisPercent), 2)
					setMappedValue(thisMappedValue)
					if map then
						map(thisMappedValue)
					end

					setPercent(Flipper.Spring.new(thisPercent))
				end
			end
		end
	}, {
		Bar = e(RoundedFrame, {
			Size = UDim2.new(1, displayValue and -40 or 0, 0, 4),
			Position = UDim2.fromScale(0, 0.5),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = theme.TextSecondary,
			[Roact.Ref] = barRef.value
		}, {
			Ball = e(RoundedFrame, {
				Size = UDim2.fromOffset(20, 20),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = percent:map(function(x)
					return UDim2.fromScale(x, 0.5)
				end),
				CornerRadius = UDim.new(0.5, 0),
				BackgroundColor3 = Theme.Brand,
				BackgroundTransparency = hoverSpring
			}, {
				InnerBall = e(RoundedFrame, {
					Size = UDim2.fromOffset(12, 12),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.fromScale(0.5, 0.5),
					CornerRadius = UDim.new(0.5, 0),
					BackgroundColor3 = Theme.Brand
				}),

				Hitbox = e("TextButton", {
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					Text = "",
					[Roact.Event.MouseEnter] = function()
						setHoverSpring(Flipper.Spring.new(0.5))
					end,
					[Roact.Event.MouseLeave] = function()
						setHoverSpring(Flipper.Spring.new(1))
					end,
					[Roact.Event.InputBegan] = function(_, input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							active.value = true
						end
					end,
					[Roact.Event.InputEnded] = function(_, input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							active.value = false
						end
					end,
				}),
			}),
		}),


		Value = displayValue and e(RoundedFrame, {
			Size = UDim2.fromOffset(30, 20),
			Position = UDim2.fromScale(1, 0.5),
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundTransparency = 1
		}, {
			Stroke = e("UIStroke", {
				Thickness = 1,
				Color = theme.TextSecondary
			}),

			Value = e(TextLabel, {
				Size = UDim2.fromScale(1, 1),
				Font = Enum.Font.Gotham,
				TextColor3 = theme.TextPrimary,
				TextSize = 12,
				Text = mappedValue
			})

		}) or nil

	})
end

return hook(Slider)