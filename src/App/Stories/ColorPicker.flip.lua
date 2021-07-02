local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor

local Roact = require(Vendor.Roact)

local Components = script.Parent.Parent.Components
local FlipbookComponents = Components.FlipbookComponents
local ColorPicker = require(FlipbookComponents.ColorPicker)

local function ColorPickerFlip()
	return {
		metadata = {
			location = "Flipbook Internal",
			componentGroup = "Controls",
			title = "Color Picker",
			library = "Roact",
			libraryPath = Roact,

			argTypes = {
				Position = {
					initial = UDim2.fromScale(0.5, 0.5)
				},
				AnchorPoint = {
					initial = Vector2.new(0.5, 0.5)
				}
			}
		},

		component = ColorPicker
	}
end

return ColorPickerFlip