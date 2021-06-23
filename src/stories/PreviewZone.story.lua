local Flipbook = script:FindFirstAncestor("Flipbook")
local Components = Flipbook.components
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local Hooks = require(Vendor.Hooks)
local CustomHooks = require(Utility.CustomHooks)

local PreviewZone = require(Components.Preview.PreviewZone)

local e = Roact.createElement
local hook = Hooks.new(Roact)
local useTheme = CustomHooks.useTheme

local function PreviewZoneApp(_, hooks)
	local theme = useTheme(hooks)
	return e(PreviewZone, {Theme = theme})
end

PreviewZoneApp = hook(PreviewZoneApp)

local function PreviewZoneStory(target)
	local handle = Roact.mount(
		e(PreviewZoneApp),
		target
	)

	return function()
		Roact.unmount(handle)
		handle = nil
	end
end

return PreviewZoneStory