local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor

local Rodux = require(Vendor.Rodux)

local Reducer = Rodux.combineReducers({
	stories = require(script.Stories),
	currentFile = require(script.SelectedStory)
})

return Reducer