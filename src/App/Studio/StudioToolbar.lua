local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local StudioContext = require(script.Parent.StudioContext)
local MergeTables = require(Utility.MergeTables)

local e = Roact.createElement

local StudioToolbar = Roact.Component:extend("StudioToolbar")

function StudioToolbar:init()
	self.toolbar = self.props.plugin:CreateToolbar(self.props.name)
end

function StudioToolbar:render()
	return e(StudioContext.toolbarContext.Provider, {
		value = self.toolbar,
	}, self.props[Roact.Children])
end

function StudioToolbar:didUpdate(lastProps)
	if self.props.name ~= lastProps.name then
		self.toolbar.Name = self.props.name
	end
end

function StudioToolbar:willUnmount()
	self.toolbar:Destroy()
end

local function StudioToolbarWrapper(props)
	return e(StudioContext.pluginContext.Consumer, {
		render = function(plugin)
			return e(StudioToolbar, MergeTables(props, {
				plugin = plugin,
			}))
		end
	})
end

return StudioToolbarWrapper