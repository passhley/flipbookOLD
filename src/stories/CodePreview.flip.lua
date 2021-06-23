local Flipbook = script:FindFirstAncestor("Flipbook")
local Components = Flipbook.components
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)

local CodePreview = require(Components.Control.CodePreview.CodePreview)

local e = Roact.createElement

return {
	Location = "CodePreview",
	Mount = function(t)
		local handle = Roact.mount(e(CodePreview, { Object = game.ServerScriptService.Flipbook.stories["CodePreview.flip"]}), t)
		return function ()
			Roact.unmount(t)
		end
	end
}