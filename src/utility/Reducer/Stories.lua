local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor

local Rodux = require(Vendor.Rodux)

local Stories = Rodux.createReducer({}, {
	AddStory = function(state, action)
		local newState = {}

		for folder, stories in pairs(state) do
			newState[folder] = {}

			for story, data in pairs(stories) do
				newState[folder][story] = data
			end
		end

		if newState[action.Location] == nil then
			newState[action.Location] = {}
		end

		table.insert(newState[action.Location], action.StoryData)

		return newState
	end,

	RemoveStory = function(state, action)
		local newState = {}

		for folder, stories in pairs(state) do
			newState[folder] = {}

			for _, data in pairs(stories) do
				if data.Object ~= action.Object then
					table.insert(newState[folder], data)
				end
			end

			if #newState[folder] == 0 then
				newState[folder] = nil
			end
		end

		return newState
	end,

	UpdateStory = function(state, action)
		local newState = {}

		for folder, stories in pairs(state) do
			newState[folder] = {}

			for _, data in pairs(stories) do
				if data.Object == action.Object then
					table.insert(newState[folder], action.StoryData)
				else
					table.insert(newState[folder], data)
				end
			end
		end

		return newState
	end,

	ClearStories = function()
		return {}
	end
})

return Stories