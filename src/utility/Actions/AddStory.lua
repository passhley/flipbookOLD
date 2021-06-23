local Flipbook = script:FindFirstAncestor("Flipbook")

local PluginStore = require(Flipbook.plugin.PluginStore)

local function AddStory(location, storyData)
	PluginStore.Dispatch({
		type = "AddStory",
		Location = location,
		StoryData = storyData
	})
end

return AddStory