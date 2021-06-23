local Flipbook = script:FindFirstAncestor("Flipbook")

local PluginStore = require(Flipbook.plugin.PluginStore)

local function UpdateStory(storyData)
	print("Updated story")
	print(storyData)
	PluginStore.Dispatch({
		type = "UpdateStory",
		StoryData = storyData
	})
end

return UpdateStory