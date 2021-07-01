local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local FileLoader = require(script.Parent.FileLoader)

local App = require(Flipbook.App)

local app = Roact.createElement(App, { plugin = plugin, store = FileLoader.getStore() })
local tree = Roact.mount(app, nil, "flipbook")

FileLoader.startLoadingFiles()

plugin.Unloading:Connect(function()
	FileLoader.stopLoadingFiles()
	Roact.unmount(tree)
end)