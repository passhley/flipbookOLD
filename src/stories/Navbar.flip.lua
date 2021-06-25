local Flipbook = script:FindFirstAncestor("Flipbook")
local Components = Flipbook.components
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local Hooks = require(Vendor.Hooks)
local CustomHooks = require(Utility.CustomHooks)

local Navbar = require(Components.Navbar.Navbar)

local e = Roact.createElement
local hook = Hooks.new(Roact)
local useTheme = CustomHooks.useTheme

local function NavbarApp(_, hooks)
	local theme = useTheme(hooks)

	return e("Frame", {
		Size = UDim2.new(0, 250, 1, 0),
		BackgroundColor3 = theme.Background,
		BorderSizePixel = 0
	}, {
		Navbar = e(Navbar, { Theme = theme })
	})
end
NavbarApp = hook(NavbarApp)

return {
	Location = "flipbook Components",
	Mount = function(t)
		local handle = Roact.mount(
			e(NavbarApp),
			t
		)
		return function()
			Roact.unmount(handle)
		end
	end
}