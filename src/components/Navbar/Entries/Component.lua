local Flipbook = script:FindFirstAncestor("Flipbook")
local Components = Flipbook.components
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local Hooks = require(Vendor.Hooks)
local Theme = require(Utility.Theme)
local MergeTables = require(Utility.MergeTables)

local Icon = require(Components.Generic.Icon)
local Arrow = require(Components.Generic.Arrow)
local TextLabel = require(Components.Generic.TextLabel)
local State = require(script.Parent.State)

local e = Roact.createElement
local hook = Hooks.new(Roact)

local function Component(props, hooks)
	local theme = props.Theme or Theme.Light
	local open, setOpen = hooks.useState(false)

	local componentName = props.Name or "Component"
	local story = props.Story
	local stateCount = 0
	local states = {}

	if typeof(story) == "table" then
		if story.States then
			for _, state in pairs(story.States) do
				states[state] = e(State, {
					Theme = theme,
					Name = state,
					Object = story.Component
				})
				stateCount += 1
			end
		end
	end

	local expandedSize = 26 + (stateCount*26)

	return e("Frame", {
		Size = UDim2.new(1, 0, 0, open and expandedSize or 26),
		BackgroundTransparency = 1
	}, {
		Header = e("Frame", {
			Size = UDim2.new(1, 0, 0, 26),
			BackgroundTransparency = 1
		}, {
			Padding = e("UIPadding", { PaddingLeft = UDim.new(0, 20) }),
			Arrow = stateCount > 0 and e(Arrow, {
				Direction = open and "Down" or "Right",
				Size = UDim2.fromOffset(16, 16),
				Position = UDim2.fromScale(0, 0.5),
				AnchorPoint = Vector2.new(0, 0.5),
				ImageColor3 = theme.TextSecondary
			}) or nil,
			Icon = e(Icon, {
				Size = UDim2.fromOffset(16, 16),
				Position = UDim2.new(0, 20, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				Image = "rbxassetid://6991866319",
				ImageColor3 = theme.Icons.Component
			}),
			Header = e(TextLabel, {
				Size = UDim2.new(1, -45, 0, 20),
				Position = UDim2.new(0, 45, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				Text = componentName,
				TextXAlignment = Enum.TextXAlignment.Left,
				Font = Enum.Font.Gotham,
				TextColor3 = theme.TextPrimary,
				TextSize = 14
			}),
			Hitbox = e("TextButton", {
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				Text = "",

				[Roact.Event.Activated] = function()
					setOpen(not open)
				end
			})
		}),

		States = e("Frame", {
			Size = UDim2.new(1, 0, 0, expandedSize - 26),
			Visible = open == true,
			Position = UDim2.fromOffset(0, 26),
			BackgroundTransparency = 1
		}, MergeTables(states, {
			List = e("UIListLayout")
		}))
	})
end

return hook(Component)