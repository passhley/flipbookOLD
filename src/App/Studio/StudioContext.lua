local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor

local Roact = require(Vendor.Roact)

local pluginContext = Roact.createContext(nil)
local toolbarContext = Roact.createContext(nil)

return {
	pluginContext = pluginContext,
	toolbarContext = toolbarContext
}