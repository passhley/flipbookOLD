local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor

local Rodux = require(Vendor.Rodux)

local Stories = Rodux.createReducer({}, {
	AddStory = function(state, action)
		local name = action.Name
		local location = action.Location
		local object = action.Object

		local newState = {}

		for folder, stories in pairs(state) do
			newState[folder] = stories
		end

		if newState[location] == nil then
			newState[location] = {}
		end

		newState[location][name] = object

		return newState
	end,

	RemoveStory = function(state, action)
		local object = action.Object

		local newState = {}

		for folder, stories in pairs(state) do
			local count = 0

			if newState[folder] == nil then
				newState[folder] = {}
			end

			for storyName, story in pairs(stories) do
				print(object)
				print(story)
				if object ~= story then
					newState[folder][storyName] = story
					count += 1
				end
			end

			if count > 0 then
				newState[folder] = nil
			end
		end

		return newState
	end,

	ClearStories = function()
		return {}
	end
})

return Stories