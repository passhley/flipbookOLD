local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor

local Rodux = require(Vendor.Rodux)

local Reducer = Rodux.combineReducers({
	Stories = require(script.Stories)
})

return Reducer