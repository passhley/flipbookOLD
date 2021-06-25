local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local App = require(Flipbook.App)

local e = Roact.createElement

local app = Roact.createElement(App, { plugin = plugin })
local tree = Roact.mount(app, nil, "flipbook")

-- plugin.Unloading:Connect(function()
-- 	Roact.unmount(tree)
-- end)