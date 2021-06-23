local Flipbook = script:FindFirstAncestor("Flipbook")
local Components = Flipbook.components
local Vendor = Flipbook.vendor

local Roact = require(Vendor.Roact)

local Icon = require(Components.Generic.Icon)

local e = Roact.createElement

local function Component(props)
	local theme = props.Theme
	local componentName = props.ComponentName or "AA"
	local componentObject = props.Object
	local selected = props.Selected or false

	return e("Frame", {
			Size = UDim2.new(1, 0, 0, 26),
			BorderSizePixel = 0,
			BackgroundTransparency = selected and 0 or 1,
			BackgroundColor3 = theme.Storylist.Selected
		}, {
			--TODO: We will reimplement this in
			--what we will need to do is do a thing like
			--check if the component passes states aswell
			--and if it does, we will make it another dropdown,
			--otherwise it will be clickable and preview
			-- Arrow = e(Arrow, {
			-- 	Size = UDim2.fromOffset(20, 20),
			-- 	Position = UDim2.new(0, 10, 0.5, 0),
			-- 	AnchorPoint = Vector2.new(0, 0.5),
			-- 	Direction = "Right",
			-- 	Theme = theme
			-- }),

			Icon = e(Icon, {
				Size = UDim2.fromOffset(16, 16),
				Image = "rbxassetid://6991866319",
				Position = UDim2.new(0, 30, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				ImageColor3 = selected and theme.Storylist.ComponentSelected or theme.Storylist.Selected
			}),

			Header = e("TextLabel", {
				Size = UDim2.new(1, -(16+30), 1, 0),
				Position = UDim2.fromOffset(16+30+10, 0),
				TextSize = 14,
				Font = Enum.Font.Gotham,
				TextXAlignment = Enum.TextXAlignment.Left,
				BackgroundTransparency = 1,
				TextColor3 = selected and theme.Storylist.TextSelected or theme.Text,
				Text = componentName
			}),

			Hitbox = e("TextButton", {
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				Text = "",

				[Roact.Event.Activated] = function()
					props.OnClick({Name = componentName, Object = componentObject})
				end
			})
	})
end

return Component