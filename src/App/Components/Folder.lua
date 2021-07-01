local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local Hooks = require(Vendor.Hooks)
local MergeTables = require(Utility.MergeTables)
local FileUtils = require(Utility.FileUtils)

local Arrow = require(script.Parent.Arrow)
local Icon = require(script.Parent.Icon)
local TextLabel = require(script.Parent.TextLabel)
local File = require(script.Parent.File)

local e = Roact.createElement
local hook = Hooks.new(Roact)

local function Folder(props, hooks)
	local useState = hooks.useState

	local theme = props.Theme
	local indent = props.Indent
	local type = props.Type or "Directory"

	local children = {}
	for _, child in pairs(props.Children) do
		if child.type == "Directory" or child.type == "ComponentGroup" then
			children[child.Id] = e(Folder, {
				Theme = theme,
				Type = child.type,
				Id = child.Id,
				Indent = indent + 1,
				Children = child.Data,
			})
		elseif child.type == "File" then
			local thisIndent = indent+1

			children[child.Id] = e(File, {
				Theme = theme,
				Id = child.Id,
				Indent = thisIndent,
				FileData = child.Data
			})
		end
	end

	local open, setOpen = useState(false)

	return e("Frame", {
		Size = UDim2.new(1, 0, 0, 26),
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.Y,
	}, {
		Header = e("Frame", {
			Size = UDim2.new(1, 0, 0, 26),
			BackgroundTransparency = 1
		}, {
			Padding = e("UIPadding", { PaddingLeft = UDim.new(0, 10*indent)}),

			Arrow = e(Arrow, {
				Size = UDim2.fromOffset(16, 16),
				Direction = open and "Down" or "Right",
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.fromScale(0, 0.5),
				ImageColor3 = theme.TextSecondary
			}),

			Icon = e(Icon, {
				Size = UDim2.fromOffset(16, 16),
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(0, 20, 0.5, 0),
				ImageColor3 = theme.Icons[type],
				Image = type == "Directory" and "rbxassetid://6991866090" or type == "ComponentGroup" and "rbxassetid://6991866319"
			}),

			Text = e(TextLabel, {
				Size = UDim2.new(1, -45, 1, 0),
				Position = UDim2.fromOffset(45, 0),
				Font = Enum.Font.Gotham,
				Text = props.Id,
				TextColor3 = theme.TextPrimary,
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left
			}),

			Hitbox = e("TextButton", {
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				Text = "",
				[Roact.Event.Activated] = function()
					setOpen(not open)
				end
			})

		}),

		Children = open and e("Frame", {
			Size = UDim2.new(1, 0, 0, 26),
			Position = UDim2.fromOffset(0, 26),
			BackgroundTransparency = 1,
			AutomaticSize = Enum.AutomaticSize.Y,
			Visible = open
		}, MergeTables(children, {
			List = e("UIListLayout")
		})) or nil

	})
end
Folder = hook(Folder)

return Folder