local Flipbook = script:FindFirstAncestor("Flipbook")
local Components = Flipbook.components
local Vendor = Flipbook.vendor

local PluginStore = require(script.Parent.PluginStore)
local PluginStoryLoader = require(script.Parent.PluginStoryLoader)
local Roact = require(Vendor.Roact)
local RoactRodux = require(Vendor.RoactRodux)

local FlipbookApp = require(Components.Flipbook)

local e = Roact.createElement
local _MountedApp = nil
local _Widget = nil

local PluginAppManager = {}

function PluginAppManager.Init(plugin)
	local widget = plugin:CreateDockWidgetPluginGui(
		"flipbook",
		DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, false, false, 800, 400, 600, 300)
	)
	widget.Name = "flipbook"
	widget.Title = "flipbook"
	_Widget = widget
end

function PluginAppManager.Unmount()
	if _MountedApp then
		PluginStoryLoader.Disable()
		Roact.unmount(_MountedApp)
		_MountedApp = nil
	end
end

function PluginAppManager.Mount()
	if _MountedApp then
		PluginAppManager.Unmount()
	end

	local store = PluginStore.GetStore()
	PluginStoryLoader.Enable()
	_MountedApp = Roact.mount(
		e(RoactRodux.StoreProvider, {
			store = store
		}, {
			Flipbook = e(FlipbookApp)
		}),
		_Widget
	)
end

function PluginAppManager.ToggleWidget()
	if _Widget.Enabled then
		_Widget.Enabled = false
		PluginAppManager.Unmount()
	else
		_Widget.Enabled = true
		PluginAppManager.Mount()
	end
end

return PluginAppManager