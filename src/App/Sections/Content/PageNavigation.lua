local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local Hooks = require(Vendor.Hooks)
local CustomHooks = require(Utility.CustomHooks)

local e = Roact.createElement
local hook = Hooks.new(Roact)
local useSingleMotor = CustomHooks.useSingleMotor

local function PageNavigation(props, hooks)
	local canvasSpring, setCanvasSpring = useSingleMotor(1, hooks)
	local docsSpring, setDocsSpring = useSingleMotor(1, hooks)

	local theme = props.Theme
	local selected, setSelected = hooks.useState("Canvas")

	hooks.useEffect(function()
		if selected == "Docs" then
			setCanvasSpring(1)
		elseif selected == "Canvas" then
			setDocsSpring(1)
		end
	end, { selected })

	return e("Frame", {
		Size = UDim2.new(0, 150, 1, 0),
		Position = UDim2.fromOffset(10, 0),
		BackgroundTransparency = 1
	}, {

		List = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder
		}),

		Canvas = e("TextButton", {
			Size = UDim2.fromScale(0.5, 1),
			Font = Enum.Font.Gotham,
			Text = "Canvas",
			TextSize = 16,
			TextColor3 = selected == "Canvas" and theme.Navbar.Selected or theme.TextPrimary,
			BorderSizePixel = 0,
			BackgroundColor3 = theme.TextSecondary,
			BackgroundTransparency = canvasSpring:map(function(x)
				return selected == "Canvas" and 1 or x
			end),

			[Roact.Event.MouseEnter] = function()
				setCanvasSpring(0.8)
			end,

			[Roact.Event.MouseLeave] = function()
				setCanvasSpring(1)
			end,

			[Roact.Event.Activated] = function()
				setSelected("Canvas")
			end
		}),

		Docs = e("TextButton", {
			Size = UDim2.fromScale(0.5, 1),
			LayoutOrder = 1,
			Font = Enum.Font.Gotham,
			Text = "Docs",
			TextSize = 16,
			TextColor3 = selected == "Docs" and theme.Navbar.Selected or theme.TextPrimary,
			BorderSizePixel = 0,
			BackgroundColor3 = theme.TextSecondary,
			BackgroundTransparency = docsSpring:map(function(x)
				return selected == "Docs" and 1 or x
			end),

			[Roact.Event.MouseEnter] = function()
				setDocsSpring(0.8)
			end,

			[Roact.Event.MouseLeave] = function()
				setDocsSpring(1)
			end,

			[Roact.Event.Activated] = function()
				setSelected("Docs")
			end
		})

	})
end

return hook(PageNavigation)