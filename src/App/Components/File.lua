local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local RoactRodux = require(Vendor.RoactRodux)
local Hooks = require(Vendor.Hooks)
local MergeTables = require(Utility.MergeTables)

local Icon = require(script.Parent.Icon)
local TextLabel = require(script.Parent.TextLabel)

local e = Roact.createElement
local hook = Hooks.new(Roact)

local function File(props, hooks)
	local useState = hooks.useState

	local theme = props.Theme
	local indent = props.Indent or 0
	local selected = props.Selected
	local setSelected = props.setSelected

	return e("Frame", {
		Size = UDim2.new(1, 0, 0, 26),
		BackgroundTransparency = selected and 0 or 1
	}, {
		Padding = e("UIPadding", { PaddingLeft = UDim.new(0, 10*indent)}),

		Icon = e(Icon, {
			Size = UDim2.fromOffset(16, 16),
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 20, 0.5, 0),
			ImageColor3 = theme.Icons.File,
			Image = "rbxassetid://6994866787"
		}),

		Text = e(TextLabel, {
			Size = UDim2.new(1, -45, 1, 0),
			Position = UDim2.fromOffset(45, 0),
			Font = Enum.Font.Gotham,
			Text = props.FileData.title,
			TextColor3 = theme.TextPrimary,
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left
		}),

		Hitbox = e("TextButton", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Text = "",
			[Roact.Event.Activated] = function()
				setSelected(props.FileData.file)
			end
		})
	})
end
File = hook(File)

return RoactRodux.connect(
	function(state, props)
		local selected = false
		if state.currentFile then
			if typeof(state.currentFile) ~= "table" then
				if state.currentFile:IsA("ModuleScript") then
					local fileData = props.FileData
					if fileData == nil then
						if props.innerProps then
							fileData = props.innerProps.FileData
						end
					end

					selected = fileData.file == state.currentFile
				end
			end
		end


		return {
			Selected = selected
		}
	end,
	function(dispatch)
		return {
			setSelected = function(file)
				dispatch({
					type = "setSelectedStory",
					file = file
				})
			end
		}
	end
)(File)