local Flipbook = script:FindFirstAncestor("Flipbook")

local PluginStore = require(Flipbook.plugin.PluginStore)

local function SetSelectedStory(object)
	PluginStore.Dispatch({
		type = "SetSelectedStory",
		Object = object
	})
end

return SetSelectedStory