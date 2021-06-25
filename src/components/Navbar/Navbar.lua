local Flipbook = script:FindFirstAncestor("Flipbook")
local Components = Flipbook.components
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local Theme = require(Utility.Theme)

local TextLabel = require(Components.Generic.TextLabel)
local Header = require(script.Parent.Header)
local StoryEntries = require(script.Parent.StoryEntries)

local e = Roact.createElement

local function Navbar(props)
	local theme = props.Theme or Theme.Light
	local stories = props.Stories or {}

	return e("Frame", {
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
			Entries = e(StoryEntries, { Theme = theme, Stories = stories })
		})
	})
end

return Navbar