local HttpService = game:GetService("HttpService")

local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility
local Node = require(script.Node)

local Rodux = require(Vendor.Rodux)
local deepCopyTable = require(Utility.DeepCopyTable)
local FileUtils = require(Utility.FileUtils)

local stories = Rodux.createReducer({ root = Node:create({}, "Root", nil, "Root"), fileDirectory = {} }, {
	addStory = function(state, action)
		local newState = deepCopyTable(state)
		local file = action.file
		local isFlipbook = FileUtils.fileIsFlipbook(file)
		local isStory = FileUtils.fileIsStory(file)
		local location = FileUtils.getFileLocation(file)
		local title = FileUtils.getFileName(file)
		local internalUID = HttpService:GenerateGUID(false)

		file:SetAttribute("__flipbookInternalUID", internalUID)

		if isFlipbook then
			local directories = location:split("/")

			local root = newState.root
			for _, thisLocation in pairs(directories) do
				local directoryNode = nil

				for _, directory in pairs(root.Data) do
					if directory.Id == thisLocation then
						directoryNode = directory
					end
				end

				if directoryNode == nil then
					directoryNode = root:AddChild({}, "Directory", thisLocation)
				end

				root = directoryNode
			end

			local metadata = FileUtils.getFlipMetadata(file)
			if metadata then
				if metadata.componentGroup then
					local cGroupNode = nil

					for _, cGroup in pairs(root.Data) do
						if cGroup.Id == metadata.componentGroup then
							cGroupNode = cGroup
						end
					end

					if cGroupNode == nil then
						cGroupNode = root:AddChild({}, "ComponentGroup", metadata.componentGroup)
					end

					root = cGroupNode
				end

				if metadata.title then
					title = metadata.title
				end
			end

			if root then
				local fileNode = root:AddChild({
					file = file,
					title = title
				}, "File", internalUID)

				newState.fileDirectory[internalUID] = fileNode
			end

		elseif isStory then
			local directoryNode = nil
			for _, directory in pairs(newState.root.Data) do
				if directory.Id == location then
					directoryNode = directory
				end
			end

			if directoryNode == nil then
				directoryNode = newState.root:AddChild({}, "Directory", location)
			end

			local fileNode = directoryNode:AddChild({
				file = file,
				title = title
			}, "File", internalUID)

			newState.fileDirectory[internalUID] = fileNode
		end

		return newState
	end,

	removeStory = function(state, action)
		local newState = deepCopyTable(state)

		local file = action.file
		local internalUID = file:GetAttribute("__flipbookInternalUID")
		local directory = newState.fileDirectory
		local fileNode = directory[internalUID]

		if fileNode then
			fileNode.Parent:DeleteData(fileNode)
			newState.fileDirectory[internalUID] = nil
		end

		return newState
	end,

	clearStories = function()
		return {
			root = Node:create({}, "Root", nil, "Root"),
			fileDirectory = {}
		}
	end
})

return stories