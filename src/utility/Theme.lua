local Flipbook = script:FindFirstAncestor("Flipbook")
local Utility = Flipbook.utility

local HexColor = require(Utility.HexColor)

local Theme = {
	Light = {
		Brand = HexColor(0x171717),
		Library = HexColor(0xA3A3A3),

		Text = HexColor(0x171717),
		TextSecondary = HexColor(0x52525B),

		Border = HexColor(0xD4D4D8),
		BrandIcon = HexColor(0x6366F1),
		Background = HexColor(0xFFFFFF),

		Storylist = {
			Background = HexColor(0xF5F5F5),
			Selected = HexColor(0x6366F1),
			-- 0x1D94FC

			Folder = HexColor(0x504C88),
			TextSelected = HexColor(0xFFFFF),
			ComponentSelected = HexColor(0xFFFFF)
		}
	},

	Dark = {
		Brand = HexColor(0xFAFAFA),
		Library = HexColor(0xA3A3A3),

		Text = HexColor(0xFAFAFA),
		TextSecondary = HexColor(0x52525B),

		Border = HexColor(0x404040),
		BrandIcon = HexColor(0x6366F1),
		Background = HexColor(0x262626),

		Storylist = {
			Background = HexColor(0x171717),
			Selected = HexColor(0x1D94FC),

			Folder = HexColor(0x504C88),
			TextSelected = HexColor(0xFFFFF),
			ComponentSelected = HexColor(0xFFFFF)
		}
	}
}

return Theme