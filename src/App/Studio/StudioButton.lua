local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local StudioContext = require(script.Parent.StudioContext)
local MergeTables = require(Utility.MergeTables)

local e = Roact.createElement

local StudioButton = Roact.Component:extend("StudioButton")
StudioButton.defaultProps = {
	enabled = true,
	active = false,
}

function StudioButton:init()
	local button = self.props.toolbar:CreateButton(
		self.props.name,
		self.props.tooltip,
		self.props.icon,
		self.props.text
	)

	button.Click:Connect(function()
		if self.props.onClick then
			self.props.onClick()
		end
	end)

	button.ClickableWhenViewportHidden = true

	self.button = button
end

function StudioButton:render()
	return nil
end

function StudioButton:didUpdate(lastProps)
	if self.props.enabled ~= lastProps.enabled then
		self.button.Enabled = self.props.enabled
	end

	if self.props.active ~= lastProps.active then
		self.button:SetActive(self.props.active)
	end
end

function StudioButton:willUnmount()
	self.button:Destroy()
end

local function StudioButtonWrapper(props)
	return e(StudioContext.toolbarContext.Consumer, {
		render = function(toolbar)
			return e(StudioButton, MergeTables(props, {
				toolbar = toolbar,
			}))
		end
	})
end

return StudioButtonWrapper