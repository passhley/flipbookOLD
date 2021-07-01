local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local RoactRodux = require(Vendor.RoactRodux)
local Hooks = require(Vendor.Hooks)
local MergeTables = require(Utility.MergeTables)

local Folder = require(script.Parent.Parent.Components.Folder)
local ScrollingFrame = require(script.Parent.Parent.Components.ScrollingFrame)

local e = Roact.createElement
local hook = Hooks.new(Roact)

local function StoryEntries(props, hooks)
	local useState = hooks.useState

	local theme = props.Theme
	local stories = props.stories

	local canvasSize, setCanvasSize = useState(0)

	local children = {}
	for _, directory in pairs(stories) do
		children[directory.Id] = e(Folder, {
			Theme = theme,
			Id = directory.Id,
			Children = directory.Data,
			Indent = 1
		})
	end

	return e(ScrollingFrame, {
		Size = UDim2.new(1, 10, 1, -25),
		Position = UDim2.fromOffset(-10, 25),
		ScrollBarImageColor3 = theme.TextSecondary,
		CanvasSize = UDim2.fromOffset(0, canvasSize)
	}, MergeTables(children, {
		List = e("UIListLayout", {
			Padding = UDim.new(0, 5),
			[Roact.Change.AbsoluteContentSize] = function(rbx)
				setCanvasSize(rbx.AbsoluteContentSize.Y)
			end
		})
	}))
end
StoryEntries = hook(StoryEntries)

return RoactRodux.connect(
	function(state)
		return {
			stories = state.stories.root:GetDataRef()
		}
	end
)(StoryEntries)