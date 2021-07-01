local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local Theme = require(Utility.Theme.Theme)
local FileLoader = require(Flipbook.FileLoader)

local Components = script.Parent.Parent.Parent.Components
local TextLabel = require(Components.TextLabel)
local Icon = require(Components.Icon)
local Header = require(script.Parent.Header)
local StoryEntries = require(script.Parent.Parent.StoryEntries)

local e = Roact.createElement

local function Navbar(props)
	local theme = props.Theme or Theme.Light
	local stories = props.Stories or {}

	return e("Frame", {
		Position = UDim2.fromOffset(10, 0),
		Size = UDim2.new(0, 250, 1, 0),
		BackgroundTransparency = 1
	}, {
		List = e("UIListLayout", { Padding = UDim.new(0, 20), SortOrder = Enum.SortOrder.LayoutOrder }),
		Header = e(Header, { Theme = theme}),
		Content = e("Frame", {
			Size = UDim2.new(1, 0, 1, -95),
			LayoutOrder = 1,
			BackgroundTransparency = 1
		}, {
			Header = e(TextLabel, {
				Size = UDim2.new(1, -10, 0, 20),
				Position = UDim2.fromOffset(10, 0),
				TextXAlignment = Enum.TextXAlignment.Left,
				Text = "L I B R A R Y",
				Font = Enum.Font.GothamBlack,
				TextSize = 13,
				TextColor3 = Theme.Library
			}),
			Refresh = e(Icon, {
				Size = UDim2.fromOffset(16, 16),
				Position = UDim2.new(1, 0, 0, 2),
				AnchorPoint = Vector2.new(1, 0),
				Image = "rbxassetid://6031097226",
				ImageColor3 = theme.TextPrimary
			}, {
				Hitbox = e("TextButton", {
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					Text = "",
					[Roact.Event.Activated] = function()
						FileLoader.refreshFiles()
					end
				})
			}),
			Divider = e("Frame", {
				Size = UDim2.new(1, 0, 0, 1),
				BorderSizePixel = 0,
				BackgroundColor3 = Theme.Library,
				Position = UDim2.fromOffset(0, 20)
			}),

			Entries = e(StoryEntries, { Theme = theme, Stories = stories })
		})
	})
end

return Navbar