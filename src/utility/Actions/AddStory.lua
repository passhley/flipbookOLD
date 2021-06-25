local Flipbook = script:FindFirstAncestor("Flipbook")

local PluginStore = require(Flipbook.plugin.PluginStore)

local function AddStory(location, name, object)
	PluginStore.Dispatch({
		type = "AddStory",
		Location = location,
		Name = name,
		Object = object
	})
end

return AddStory