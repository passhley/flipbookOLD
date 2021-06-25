local Flipbook = script:FindFirstAncestor("Flipbook")
local Plugin = Flipbook.plugin

local PluginToolbar = require(Plugin.PluginToolbar)
local PluginAppManager = require(Plugin.PluginAppManager)
local PluginStore = require(Plugin.PluginStore)

PluginToolbar.Init(plugin)
PluginAppManager.Init(plugin)
PluginStore.Init()

PluginAppManager.ToggleWidget()

-- Flipbook.stories["Welcome.flip"].Parent = game.ReplicatedStorage