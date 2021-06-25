local Flipbook = script:FindFirstAncestor("Flipbook")
local Components = Flipbook.components
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local Theme = require(Utility.Theme)

local Branding = require(Components.Generic.Branding)
local Searchbar = require(Components.Searchbar.Searchbar)

local e = Roact.createElement

local function Header(props)
	local theme = props.Theme or Theme.Light

	return e("Frame", {
		Size = UDim2.new(1, 0, 0, 75),
		BackgroundTransparency = 1
	}, {

		Padding = e("UIPadding", { PaddingLeft = UDim.new(0, 10), PaddingTop = UDim.new(0, 10) }),
		List = e("UIListLayout", { Padding = UDim.new(0, 10) }),

		Header = e("Frame", {
			Size = UDim2.new(1, 0, 0, 30),
			BackgroundTransparency = 1,
		}, {

			List = e("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center }),
			Branding = e(Branding, { TextSize = 20, Size = UDim2.new(1, -25, 1, 0), TextXAlignment = Enum.TextXAlignment.Left }),
			--TODO: Add options button
		}),

		Searchbar = e(Searchbar, { Theme = theme, Size = UDim2.new(1, 0, 0, 24) })
	})
end

return Header