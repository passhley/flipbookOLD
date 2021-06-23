local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor

local Roact = require(Vendor.Roact)

local Navigation = require(script.Parent.Navigation)
local StoryEntries = require(script.Parent.StoryEntries)

local e = Roact.createElement

local function Storylist(props)
	local theme = props.Theme
	local stories = props.Stories
	local selected, setSelected = props.Selected, props.SetSelected

	return e("Frame", {
		Size = UDim2.new(0, 250, 1, 0),
		BorderSizePixel = 0,
		BackgroundColor3 = theme.Storylist.Background,
		BackgroundTransparency = 1
	}, {

		List = e("UIListLayout", { Padding = UDim.new(0, 20) }),
		Navigation = e(Navigation, { Theme = theme }),
		StoryEntries = e(StoryEntries, { Theme = theme, SelectComponent = setSelected, SelectedComponent = selected, Stories = stories })
	})
end

return Storylist