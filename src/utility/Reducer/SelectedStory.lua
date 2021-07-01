local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor

local Rodux = require(Vendor.Rodux)

local selectedStory = Rodux.createReducer({}, {
	setSelectedStory = function(state, action)
		if state == action.file then
			return {}
		end

		return action.file
	end
})

return selectedStory