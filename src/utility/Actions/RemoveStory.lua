local Flipbook = script:FindFirstAncestor("Flipbook")

local PluginStore = require(Flipbook.plugin.PluginStore)

local function RemoveStory(object)
	PluginStore.Dispatch({
		type = "RemoveStory",
		Object = object
	})
end

return RemoveStory