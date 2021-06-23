local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Rodux = require(Vendor.Rodux)
local Reducer = require(Utility.Reducer)

local _Store

local PluginStore = {}

function PluginStore.Init()
	_Store = Rodux.Store.new(Reducer)
end

function PluginStore.GetStore()
	return _Store
end

function PluginStore.Dispatch(...)
	_Store:dispatch(...)
end

return PluginStore