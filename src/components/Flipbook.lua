local Flipbook = script:FindFirstAncestor("Flipbook")
local Components = Flipbook.components
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local RoactRodux = require(Vendor.RoactRodux)
local Hooks = require(Vendor.Hooks)
local CustomHooks = require(Utility.CustomHooks)

local Storylist = require(Components.Storylist.Storylist)
local PreviewZone = require(Components.Preview.PreviewZone)

local e = Roact.createElement
local hook = Hooks.new(Roact)
local useTheme = CustomHooks.useTheme

local function FlipbookApp(props, hooks)
	local theme = useTheme(hooks)
	local selected, setSelected = hooks.useState(nil)

	return e("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 0,
		BackgroundColor3 = theme.Storylist.Background,
		BorderSizePixel = 0
	}, {
		Storylist = e(Storylist, {
			Theme = theme,
			Stories = props.Stories,
			Selected = selected,
			SetSelected = function(component)
				local isSame = false
				if selected then
					if selected.Object and selected.Object == component.Object then
						if selected.Name and selected.Name == component.Name then
							isSame = true
						end
					end
				end

				if isSame then
					setSelected(nil)
				else
					setSelected(component)
				end
			end
		}),

		PreviewZone = e(PreviewZone, {
			Theme = theme,
			Selected = selected
		})
	})
end

return RoactRodux.connect(
	function(state)
		return {
			Stories = state.Stories
		}
	end
)(hook(FlipbookApp))