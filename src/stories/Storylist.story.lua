local Flipbook = script:FindFirstAncestor("Flipbook")
local Components = Flipbook.components
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local Hooks = require(Vendor.Hooks)
local CustomHooks = require(Utility.CustomHooks)

local Storylist = require(Components.Storylist.Storylist)

local e = Roact.createElement
local hook = Hooks.new(Roact)
local useTheme = CustomHooks.useTheme

local function StorylistApp(_, hooks)
	local theme = useTheme(hooks)
	return e(Storylist, {Theme = theme})
end

StorylistApp = hook(StorylistApp)

local function FlipbookStory(target)
	local handle = Roact.mount(
		e(StorylistApp),
		target
	)

	return function()
		Roact.unmount(handle)
		handle = nil
	end
end

return FlipbookStory