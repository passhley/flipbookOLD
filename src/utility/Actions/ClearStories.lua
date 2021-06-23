local Flipbook = script:FindFirstAncestor("Flipbook")

local PluginStore = require(Flipbook.plugin.PluginStore)

local function ClearStories()
	PluginStore.Dispatch({
		type = "ClearStories",
	})
end

return ClearStories