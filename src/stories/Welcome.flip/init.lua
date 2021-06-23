local Roact = require(script.Roact)
local Hooks = require(script.Hooks)
local HexColor = require(script.HexColor)
local MergeTables = require(script.MergeTables)
local useFlipper = require(script.useFlipper)

local function map(num, min0, max0, min1, max1)
	if max0 == min0 then
		error("Range of zero")
	end

	return (((num - min0)*(max1 - min1)) / (max0 - min0)) + min1
end

local e = Roact.createElement
local hook = Hooks.new(Roact)

local Colors = {
	Brand = HexColor(0x6366F1),
	Text = HexColor(0x171717),
	Background = HexColor(0xE5E7EB)
}

local function RoundedFrame(props)
	local children = props[Roact.Children] or {}
	local border = props.Border
	local borderColor = props.BorderColor
	local cornerRadius = props.CornerRadius or UDim.new(0, 4)

	props[Roact.Children] = nil
	props.Border = nil
	props.BorderColor = nil
	props.CornerRadius = nil

	return e("Frame", props, MergeTables(children, {
		UICorner = e("UICorner", {CornerRadius = cornerRadius}),
		UIStroke = border and e("UIStroke", {
			Thickness = border,
			Color = borderColor
		}) or nil
	}))
end

local function HoverButton(props, hooks)
	local hover, setHover = hooks.useState(false)
	local size = props.Size or UDim2.fromOffset(0, 0)

	return e("Frame", {
		Size = size,
		Position = props.Position or UDim2.fromOffset(0, 0),
		AnchorPoint = props.AnchorPoint or Vector2.new(0, 0),
		BackgroundTransparency = 1
	}, {
		Header = e("TextLabel", {
			Size = UDim2.new(1, 0, 0, 13),
			BackgroundTransparency = 1,
			Text = props.Text or "",
			TextColor3 = hover and Colors.Text or Colors.Brand,
			Font = Enum.Font.Gotham,
			TextSize = props.TextSize or 13,
			ZIndex = 2
		}),
		Line = e("Frame", {
			Size = UDim2.new(1, 0, 0, 1),
			BorderSizePixel = 0,
			BackgroundColor3 = hover and Colors.Text or Colors.Brand,
			Position = UDim2.fromScale(0, 1),
			AnchorPoint = Vector2.new(0, 1),
			ZIndex = 2
		}),
		Hitbox = e("TextButton", {
			Size = UDim2.new(1, 0, 1, 0),
			Text = "",
			BackgroundTransparency = 1,
			[Roact.Event.MouseEnter] = function()
				setHover(true)
			end,
			[Roact.Event.MouseLeave] = function()
				setHover(false)
			end,
			[Roact.Event.Activated] = props.OnClick
		})
	})
end
HoverButton = hook(HoverButton)

local function Homepage(props)
	local setPage = props.SetPage

	return e("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Visible = props.Visible
	}, {
		Container = e("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1
		}, {
			List = e("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center
			}),

			Header = e("TextLabel", {
				Size = UDim2.new(1, 0, 0, 34),
				BackgroundTransparency = 1,
				Text = "Welcome to",
				TextColor3 = Colors.Text,
				Font = Enum.Font.GothamBlack,
				TextSize = 34
			}),

			Brand = e("TextLabel", {
				Size = UDim2.new(1, 0, 0, 80),
				BackgroundTransparency = 1,
				Text = "flipbook",
				TextColor3 = Colors.Brand,
				Font = Enum.Font.GothamBlack,
				TextSize = 86,
				LayoutOrder = 1
			}),
		}),

		Learn = e(HoverButton, {
			Size = UDim2.fromOffset(125, 15),
			Position = UDim2.new(0.5, 0, 1, -56),
			AnchorPoint = Vector2.new(0.5, 1),
			TextSize = 15,
			Font = Enum.Font.GothamBlack,
			Text = "Learn how to use",
			OnClick = function()
				setPage("Why")
			end
		})
	})
end

local function WhyPage(props)
	local setPage = props.SetPage

	return e("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Visible = props.Visible
	}, {
		Container = e("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1
		}, {
			List = e("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center
			}),

			Header = e("TextLabel", {
				Size = UDim2.new(1, 0, 0, 34),
				BackgroundTransparency = 1,
				Text = "Welcome to",
				TextColor3 = Colors.Text,
				Font = Enum.Font.GothamBlack,
				TextSize = 34
			}),

			Brand = e("TextLabel", {
				Size = UDim2.new(1, 0, 0, 80),
				BackgroundTransparency = 1,
				Text = "flipbook",
				TextColor3 = Colors.Brand,
				Font = Enum.Font.GothamBlack,
				TextSize = 86,
				LayoutOrder = 1
			}),
		}),

		Next = e(HoverButton, {
			Size = UDim2.fromOffset(30, 15),
			Position = UDim2.new(0.5, 0, 1, -56),
			AnchorPoint = Vector2.new(0.5, 1),
			TextSize = 15,
			Font = Enum.Font.GothamBlack,
			Text = "Next",
			OnClick = function()
				setPage("Home")
			end
		})
	})
end

local function WelcomeApp(_, hooks)
	local page, setPage = hooks.useState("Home")

	return e(RoundedFrame, {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Colors.Background,
		CornerRadius = UDim.new(0, 10)
	}, {
		e(Homepage, {
			Visible = page == "Home",
			SetPage = setPage
		}),

		e(WhyPage, {
			Visible = page == "Why",
			SetPage = setPage
		})
	})
end
WelcomeApp = hook(WelcomeApp)

return {
	Location = "Welcome to Flipbook",
	Mount = function(t)
		local handle = Roact.mount(e(WelcomeApp), t)
		return function()
			Roact.unmount(handle)
		end
	end
}