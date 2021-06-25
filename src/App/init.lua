local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local Rodux = require(Vendor.Rodux)
local RoactRodux = require(Vendor.RoactRodux)
local Hooks = require(Vendor.Hooks)
local Reducer = require(Utility.Reducer)

local StudioContext = require(script.Studio.StudioContext)
local StudioToolbar = require(script.Studio.StudioToolbar)
local StudioButton = require(script.Studio.StudioButton)
local StudioWidget = require(script.Studio.StudioWidget)

local e = Roact.createElement
local hook = Hooks.new(Roact)
local store = Rodux.Store.new(Reducer)

local function App(props, hooks)
	local useState = hooks.useState

	local plugin = props.plugin
	local enabled, setEnabled = useState(false)

	return e(RoactRodux.StoreProvider, {
		store = store
	}, {
		e(StudioContext.pluginContext.Provider, {
			value = plugin
		}, {
			gui = e(StudioWidget, {
				id = "flipbook",
				title = "flipbook",
				active = enabled,

				initDockState = Enum.InitialDockState.Float,
				initEnabled = false,
				overridePreviousState = false,
				floatingSize = Vector2.new(800, 400),
				minimumSize = Vector2.new(600, 300),

				zIndexBehavior = Enum.ZIndexBehavior.Sibling,

				onInitialState = function(initialState)
					setEnabled(initialState)
				end,

				onClose = function()
					setEnabled(false)
				end
			}),

			toolbar = e(StudioToolbar, { name = "flipbook" }, {
				button = e(StudioButton, {
					name = "flipbook",
					tooltip = "Show or hide the Flipbook UI",
					icon = "rbxassetid://7003396049",
					active = enabled,
					enabled = true,
					onClick = function()
						setEnabled(not enabled)
					end
				})
			})
		})
	})
end

return hook(App)