local HexColor = require(script.Parent.HexColor)

local Theme = {
	Brand = HexColor(0x6366F1),
	Library = HexColor(0xA3A3A3),

	Light = {
		Background = HexColor(0xF5F5F5),
		CanvasBackground = HexColor(0xFFFFFF),

		TextPrimary = HexColor(0x171717),
		TextSecondary = HexColor(0xCACACF),

		Icons = {
			Directory = HexColor(0x504C88),
			ComponentGroup = HexColor(0x5BABE3),
			File = HexColor(0x3AE662)
		},

		Navbar = {
			Selected = HexColor(0x6366F1)
		},

		InputField = {
			Selected = HexColor(0x6366F1),
			Background = HexColor(0xFFFFFF)
		}
	},

	Dark = {
		Background = HexColor(0x131313),
		CanvasBackground = HexColor(0x1A1A1A),

		TextPrimary = HexColor(0xFFFFFF),
		TextSecondary = HexColor(0x52525B),

		Icons = {
			Directory = HexColor(0x504C88),
			ComponentGroup = HexColor(0x5BABE3),
			File = HexColor(0x3AE662)
		},

		Navbar = {
			Selected = HexColor(0x6366F1)
		},

		InputField = {
			Selected = HexColor(0x6366F1),
			Background = HexColor(0x171717)
		}
	}
}

return Theme