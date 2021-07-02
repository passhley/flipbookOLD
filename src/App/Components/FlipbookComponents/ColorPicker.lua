local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local Hooks = require(Vendor.Hooks)
local Theme = require(Utility.Theme.Theme)

local Components = script.Parent.Parent
local RoundedFrame = require(Components.RoundedFrame)
local TextLabel = require(Components.TextLabel)
local Icon = require(Components.Icon)
local Dropshadow = require(Components.Dropshadow)

local e = Roact.createElement
local hook = Hooks.new(Roact)
local valueGradient = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
	ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
})
local valueTransparencyGradient = NumberSequence.new({
	NumberSequenceKeypoint.new(0, 1),
	NumberSequenceKeypoint.new(1, 0)
})

local function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

local function ColorPicker(props, hooks)
	local theme = props.Theme or Theme.Dark
	theme = theme.ColorPicker
	local position = props.Position or UDim2.fromOffset(0, 0)
	local anchorPoint = props.AnchorPoint or Vector2.new(0, 0)

	local isChoosingColor, setIsChoosingColor = hooks.useState(false)
	local hsv, setHSV = hooks.useBinding({H = 0.5, S = 0.5, V = 1})
	local expanded, setExpanded = hooks.useState(false)

	return e(RoundedFrame, {
		Size = UDim2.fromOffset(170, expanded and 390 or 215),
		BackgroundColor3 = theme.Background,
		AnchorPoint = anchorPoint,
		Position = position,
		Visible = props.Enabled
	}, {
		SetExpandedButton = e("TextButton", {
			Size = UDim2.new(1, -20, 0, 16),
			Text = expanded and "See less" or "See more",
			Font = Enum.Font.Gotham,
			TextColor3 = Theme.Brand,
			TextSize = 13,
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 10, 1, -10),
			AnchorPoint = Vector2.new(0, 1),
			TextXAlignment = Enum.TextXAlignment.Right,
			TextYAlignment = Enum.TextYAlignment.Bottom,
			[Roact.Event.Activated] = function()
				setExpanded(not expanded)
			end
		}),

		ColorBox = e("Frame", {
			Size = UDim2.fromOffset(150, 150),
			Position = UDim2.fromOffset(10, 10),
			BackgroundTransparency = 1
		}, {
			Dropshadow = e(Dropshadow),
			PickerBox = e("ImageButton", {
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				Image = "rbxassetid://1357075261",
				[Roact.Event.InputBegan] = function(_, input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						setIsChoosingColor(true)
					end
				end,
				[Roact.Event.InputEnded] = function(_, input)
					setIsChoosingColor(false)
				end,
				[Roact.Event.Activated] = function(rbx, input)
					local absSize = rbx.AbsoluteSize
					local absPos = rbx.AbsolutePosition
					local posX = input.Position.X
					local posY = input.Position.Y

					local diffHue = posX - absPos.X
					local percentHue = diffHue/absSize.X

					local diffSat = posY - absPos.Y
					local percentSat = diffSat/absSize.Y
					percentSat = 1 - percentSat

					local currentV = hsv:getValue().V
					setHSV({H = percentHue, S = percentSat, V = currentV})
				end,
				[Roact.Event.InputChanged] = function(rbx, input)
					if input.UserInputType == Enum.UserInputType.MouseMovement then
						if isChoosingColor then
							local absSize = rbx.AbsoluteSize
							local absPos = rbx.AbsolutePosition
							local posX = input.Position.X
							local posY = input.Position.Y

							local diffHue = posX - absPos.X
							local percentHue = diffHue/absSize.X

							local diffSat = posY - absPos.Y
							local percentSat = diffSat/absSize.Y
							percentSat = 1 - percentSat

							local currentV = hsv:getValue().V
							setHSV({H = percentHue, S = percentSat, V = currentV})
						end
					end
				end
			}, {
				UICorner = e("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),

				PickerIcon = e(Icon, {
					Size = UDim2.fromOffset(16, 16),
					Image = "rbxassetid://6994866787",
					ImageColor3 = Color3.new(0, 0, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = hsv:map(function(values)
						return UDim2.fromScale(
							values.H,
							1 - values.S
						)
					end)
				})
			})
		}),

		ValueSlider = e("Frame", {
			Size = UDim2.fromOffset(150, 10),
			Position = UDim2.fromOffset(10, 170),
			BackgroundTransparency = 1,
		}, {
			Dropshadow = e(Dropshadow),
			ValueSlider = e(RoundedFrame, {
				Size = UDim2.fromScale(1, 1),
				BackgroundColor3 = hsv:map(function(values)
					return Color3.fromHSV(values.H, values.S, values.V)
				end),
				CornerRadius = UDim.new(0, 2)
			}, {
				Frame = e(RoundedFrame, {
					Size = UDim2.fromScale(1, 1),
					CornerRadius = UDim.new(0, 2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.new(1, 1, 1)
				}, {
					Gradient = e("UIGradient", {
						Color = valueGradient,
						Transparency = valueTransparencyGradient
					})
				}),
			}),
		}),

		RGB = expanded and e("Frame", {
			Size = UDim2.fromOffset(150, 50),
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 190)
		}, {
			Header = e(TextLabel, {
				Size = UDim2.new(1, 0, 0, 15),
				Font = Enum.Font.GothamBlack,
				Text = "RGB",
				TextColor3 = theme.HeaderText,
				TextSize = 15,
				TextXAlignment = Enum.TextXAlignment.Left
			}),

			R = e(RoundedFrame, {
				Size = UDim2.fromOffset(46, 30),
				Position = UDim2.fromOffset(0, 20),
				BackgroundColor3 = theme.ColorBox
			}, {
				Input = e("TextBox", {
					Size = UDim2.fromScale(1, 1),
					Font = Enum.Font.GothamBlack,
					TextColor3 = theme.ColorBoxText,
					Text = "",
					PlaceholderText = hsv:map(function(values)
						local rgb = Color3.fromHSV(values.H, values.S, values.V)
						return round(rgb.R*255, 0)
					end),
					PlaceholderColor3 = theme.HeaderText,
					TextSize = 13,
					BackgroundTransparency = 1
				})
			}),

			G = e(RoundedFrame, {
				Size = UDim2.fromOffset(46, 30),
				Position = UDim2.fromOffset(52, 20),
				BackgroundColor3 = theme.ColorBox
			}, {
				Input = e("TextBox", {
					Size = UDim2.fromScale(1, 1),
					Font = Enum.Font.GothamBlack,
					TextColor3 = theme.ColorBoxText,
					Text = "",
					PlaceholderText = hsv:map(function(values)
						local rgb = Color3.fromHSV(values.H, values.S, values.V)
						return round(rgb.G*255, 0)
					end),
					PlaceholderColor3 = theme.HeaderText,
					TextSize = 13,
					BackgroundTransparency = 1
				})
			}),

			B = e(RoundedFrame, {
				Size = UDim2.fromOffset(46, 30),
				Position = UDim2.fromOffset(104, 20),
				BackgroundColor3 = theme.ColorBox
			}, {
				Input = e("TextBox", {
					Size = UDim2.fromScale(1, 1),
					Font = Enum.Font.GothamBlack,
					TextColor3 = theme.ColorBoxText,
					Text = "",
					PlaceholderText = hsv:map(function(values)
						local rgb = Color3.fromHSV(values.H, values.S, values.V)
						return round(rgb.B*255, 0)
					end),
					PlaceholderColor3 = theme.HeaderText,
					TextSize = 13,
					BackgroundTransparency = 1
				})
			}),
		}) or nil,

		HSV = expanded and e("Frame", {
			Size = UDim2.fromOffset(150, 50),
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 250)
		}, {
			Header = e(TextLabel, {
				Size = UDim2.new(1, 0, 0, 15),
				Font = Enum.Font.GothamBlack,
				Text = "HSV",
				TextColor3 = theme.HeaderText,
				TextSize = 15,
				TextXAlignment = Enum.TextXAlignment.Left
			}),

			H = e(RoundedFrame, {
				Size = UDim2.fromOffset(46, 30),
				Position = UDim2.fromOffset(0, 20),
				BackgroundColor3 = theme.ColorBox
			}, {
				Input = e("TextBox", {
					Size = UDim2.fromScale(1, 1),
					Font = Enum.Font.GothamBlack,
					TextColor3 = theme.ColorBoxText,
					Text = "",
					PlaceholderText = hsv:map(function(values)
						return round(values.H * 360, 0)
					end),
					PlaceholderColor3 = theme.HeaderText,
					TextSize = 13,
					BackgroundTransparency = 1
				})
			}),

			S = e(RoundedFrame, {
				Size = UDim2.fromOffset(46, 30),
				Position = UDim2.fromOffset(52, 20),
				BackgroundColor3 = theme.ColorBox
			}, {
				Input = e("TextBox", {
					Size = UDim2.fromScale(1, 1),
					Font = Enum.Font.GothamBlack,
					TextColor3 = theme.ColorBoxText,
					Text = "",
					PlaceholderText = hsv:map(function(values)
						return round(values.S * 100, 0)
					end),
					PlaceholderColor3 = theme.HeaderText,
					TextSize = 13,
					BackgroundTransparency = 1
				})
			}),

			V = e(RoundedFrame, {
				Size = UDim2.fromOffset(46, 30),
				Position = UDim2.fromOffset(104, 20),
				BackgroundColor3 = theme.ColorBox
			}, {
				Input = e("TextBox", {
					Size = UDim2.fromScale(1, 1),
					Font = Enum.Font.GothamBlack,
					TextColor3 = theme.ColorBoxText,
					Text = "",
					PlaceholderText = hsv:map(function(values)
						return round(values.V * 100, 0)
					end),
					PlaceholderColor3 = theme.HeaderText,
					TextSize = 13,
					BackgroundTransparency = 1
				})
			}),
		}) or nil,

		HEX = expanded and e("Frame", {
			Size = UDim2.fromOffset(150, 50),
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 310)
		}, {
			Header = e(TextLabel, {
				Size = UDim2.new(1, 0, 0, 15),
				Font = Enum.Font.GothamBlack,
				Text = "HEX",
				TextColor3 = theme.HeaderText,
				TextSize = 15,
				TextXAlignment = Enum.TextXAlignment.Left
			}),

			HEX = e(RoundedFrame, {
				Size = UDim2.fromOffset(150, 30),
				Position = UDim2.fromOffset(0, 20),
				BackgroundColor3 = theme.ColorBox
			}, {
				Input = e("TextBox", {
					Size = UDim2.fromScale(1, 1),
					Font = Enum.Font.GothamBlack,
					TextColor3 = theme.ColorBoxText,
					Text = "",
					PlaceholderText = hsv:map(function(values)
						local rgb = Color3.fromHSV(values.H, values.S, values.V)
						local red, green, blue = rgb.R, rgb.G, rgb.B
						return string.format("#%02x%02x%02x", red * 255, green * 255, blue * 255)
					end),
					PlaceholderColor3 = theme.HeaderText,
					TextSize = 13,
					BackgroundTransparency = 1
				})
			}) or nil,
		})
	})
end
ColorPicker = hook(ColorPicker)

local function ColorSelector(props, hooks)
	return e(ColorPicker, {
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Enabled = true
	})
end

return hook(ColorSelector)