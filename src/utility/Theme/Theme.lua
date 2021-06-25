local Flipbook = script:FindFirstAncestor("Flipbook")
local Utility = Flipbook.utility

local HexColor = require(Utility.HexColor)

local Theme = {
	Brand = HexColor(0x6366F1),
	Library = HexColor(0xA3A3A3),

	Light = {
		Background = HexColor(0xF5F5F5),

		TextPrimary = HexColor(0x171717),
		TextSecondary = HexColor(0xCACACF),

		Icons = {
			Folder = HexColor(0x504C88),
			Component = HexColor(0x5BABE3),
			State = HexColor(0x3AE662)
		},

		InputField = {
			Selected = HexColor(0x6366F1),
			Background = HexColor(0xFFFFFF)
		}
	},

	Dark = {
		Background = HexColor(0x171717),

		TextPrimary = HexColor(0xFFFFFF),
		TextSecondary = HexColor(0x52525B),

		Icons = {
			Folder = HexColor(0x504C88),
			Component = HexColor(0x5BABE3),
			State = HexColor(0x3AE662)
		},

		InputField = {
			Selected = HexColor(0x6366F1),
			Background = HexColor(0x171717)
		}
	}
}

return Theme