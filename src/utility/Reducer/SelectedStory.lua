local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor

local Rodux = require(Vendor.Rodux)

local SelectedStory = Rodux.createReducer({}, {
	SetSelectedStory = function(state, action)
		if state.Object == action.StoryData.Object then
			return nil
		end

		return action.StoryData
	end
})

return SelectedStory