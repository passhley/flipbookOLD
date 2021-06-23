local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local MergeTables = require(Utility.MergeTables)

local Folder = require(script.Parent.Entries.Folder)

local e = Roact.createElement

local function StoryEntries(props)
	local theme = props.Theme
	local _stories = props.Stories

	local children = {}
	if _stories ~= nil then
		for folder, childs in pairs(_stories) do
			children[folder] = e(Folder, {
				Theme = theme,
				FolderName = folder:gsub("^%a", string.upper),
				SelectComponent = props.SelectComponent,
				SelectedComponent = props.SelectedComponent,
				Components = childs
			})
		end
	end

	return e("Frame", {
		Size = UDim2.new(1, 0, 1, -105),
		BackgroundTransparency = 1
	}, {

		List = e("UIListLayout", {
			Padding = UDim.new(0, 10),
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder
		}),
		LibraryHeader = e("TextLabel", {
			Size = UDim2.new(1, -20, 0, 20),
			TextColor3 = theme.Library,
			Text = "L I B R A R Y",
			BackgroundTransparency = 1,
			TextXAlignment = Enum.TextXAlignment.Left,
			Font = Enum.Font.GothamBlack,
			TextSize = 13
		}),
		Entries = e("ScrollingFrame", {
			Size = UDim2.new(1, 0, 1, -30),
			LayoutOrder = 1,
			ScrollBarThickness = 8,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ScrollBarImageColor3 = theme.Border,
			TopImage = "rbxassetid://6017290134",
			BottomImage = "rbxassetid://6017289712",
			MidImage = "rbxassetid://6017289904"
		}, MergeTables(children, {
			List = e("UIListLayout", {
				Padding = UDim.new(0, 5)
			})
		}))
	})
end

return StoryEntries