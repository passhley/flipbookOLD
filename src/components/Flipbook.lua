local Flipbook = script:FindFirstAncestor("Flipbook")
local Components = Flipbook.components
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local RoactRodux = require(Vendor.RoactRodux)
local Hooks = require(Vendor.Hooks)
local CustomHooks = require(Utility.CustomHooks)

local Navbar = require(Components.Navbar.Navbar)

local e = Roact.createElement
local hook = Hooks.new(Roact)
local useTheme = CustomHooks.useTheme

local function App(props, hooks)
	local theme = useTheme(hooks)
	local stories = props.Stories or {}

	print(stories)

	return e("Frame", {
		Size = UDim2.fromScale(1, 1),
		BorderSizePixel = 0,
		BackgroundColor3 = theme.Background
	}, {
		Navbar = e(Navbar, { Theme = theme, Stories = stories })
	})
end

App = hook(App)

return RoactRodux.connect(
	function(state)
		return {
			Stories = state.Stories
		}
	end
)(App)