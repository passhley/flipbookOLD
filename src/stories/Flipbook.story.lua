local Flipbook = script:FindFirstAncestor("Flipbook")
local Components = Flipbook.components
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local Hooks = require(Vendor.Hooks)
local CustomHooks = require(Utility.CustomHooks)

local Storylist = require(Components.Storylist.Storylist)
local PreviewZone = require(Components.Preview.PreviewZone)

local e = Roact.createElement
local hook = Hooks.new(Roact)
local useTheme = CustomHooks.useTheme

local function FlipbookApp(_, hooks)
	local theme = useTheme(hooks)
	return e("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 0,
		BackgroundColor3 = theme.Storylist.Background,
		BorderSizePixel = 0
	}, {
		Storylist = e(Storylist, {
			Theme = theme
		}),

		PreviewZone = e(PreviewZone, {
			Theme = theme
		})
	})
end

FlipbookApp = hook(FlipbookApp)

local function FlipbookStory(target)
	local handle = Roact.mount(
		e(FlipbookApp),
		target
	)

	return function()
		Roact.unmount(handle)
		handle = nil
	end
end

return FlipbookStory