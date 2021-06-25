local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local StudioContext = require(script.Parent.StudioContext)
local MergeTables = require(Utility.MergeTables)

local e = Roact.createElement

local StudioWidget = Roact.PureComponent:extend("StudioWidget")
StudioWidget.defaultProps = {
	initDockState = Enum.InitialDockState.Right,
	active = false,
	overridePreviousState = false,
	floatingSize = Vector2.new(0, 0),
	minimumSize = Vector2.new(0, 0),
	zIndexBehavior = Enum.ZIndexBehavior.Sibling,
}

function StudioWidget:init()
	local floatingSize = self.props.floatingSize
	local minimumSize = self.props.minimumSize

	local dockWidgetPluginGuiInfo = DockWidgetPluginGuiInfo.new(
		self.props.initDockState,
		self.props.active,
		self.props.overridePreviousState,
		floatingSize.X, floatingSize.Y,
		minimumSize.X, minimumSize.Y
	)

	local pluginGui = self.props.plugin:CreateDockWidgetPluginGui(self.props.id, dockWidgetPluginGuiInfo)

	pluginGui.Name = self.props.id
	pluginGui.Title = self.props.title
	pluginGui.ZIndexBehavior = self.props.zIndexBehavior

	if self.props.onInitialState then
		self.props.onInitialState(pluginGui.Enabled)
	end

	pluginGui:BindToClose(function()
		if self.props.onClose then
			self.props.onClose()
		else
			pluginGui.Enabled = false
		end
	end)

	self.pluginGui = pluginGui
end

function StudioWidget:render()
	return e(Roact.Portal, {
		target = self.pluginGui,
	}, self.props[Roact.Children])
end

function StudioWidget:didUpdate(lastProps)
	if self.props.active ~= lastProps.active then
		self.pluginGui.Enabled = self.props.active
	end
end

function StudioWidget:willUnmount()
	self.pluginGui:Destroy()
end

local function StudioWidgetWrapper(props)
	return e(StudioContext.pluginContext.Consumer, {
		render = function(plugin)
			return e(StudioWidget, MergeTables(props, {
				plugin = plugin,
			}))
		end
	})
end

return StudioWidgetWrapper