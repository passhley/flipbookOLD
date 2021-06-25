local Flipbook = script:FindFirstAncestor("Flipbook")
local Components = Flipbook.components
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local Hooks = require(Vendor.Hooks)
local Theme = require(Utility.Theme)
local MergeTables = require(Utility.MergeTables)

local ScrollingFrame = require(Components.Generic.ScrollingFrame)
local Folder = require(Components.Navbar.Entries.Folder)

local e = Roact.createElement
local hook = Hooks.new(Roact)

local function StoryEntries(props, hooks)
	local theme = props.Theme or Theme.Light
	local stories = props.Stories or {["Buttons"] = {["Fill Button"] = { "Enabled", "Disabled" }}}

	local canvasSize, setCanvasSize = hooks.useState(0)

	local children = {}
	for folder, folderStories in pairs(stories) do
		children[folder] = e(Folder, {
			FolderName = folder,
			Stories = folderStories,
			Theme = theme
		})
	end

	return e(ScrollingFrame, {
		Size = UDim2.new(1, 0, 1, -30),
		Position = UDim2.fromOffset(0, 30),
		ScrollBarImageColor3 = theme.TextSecondary,
		CanvasSize = UDim2.fromOffset(0, canvasSize)
	}, MergeTables(children, {
		List = e("UIListLayout", {
			[Roact.Change.AbsoluteContentSize] = function(rbx)
				setCanvasSize(rbx.AbsoluteContentSize.Y)
			end
		})
	}))
end

return hook(StoryEntries)