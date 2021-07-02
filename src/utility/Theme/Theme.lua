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
		},

		ColorPicker = {
			Background = HexColor(0xF2F2F2),
			HeaderText = HexColor(0xB7B6B6),
			ColorBox = HexColor(0xDBD9D9),
			ColorBoxText = HexColor(0x000000)
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
		},

		ColorPicker = {
			Background = HexColor(0x131313),
			HeaderText = HexColor(0x52525B),
			ColorBox = HexColor(0x1C1C1C),
			ColorBoxText = HexColor(0xFFFFFF)
		}
	}
}

return Theme