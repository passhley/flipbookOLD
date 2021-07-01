local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Rodux = require(Vendor.Rodux)
local Reducer = require(Utility.Reducer)

local Store = Rodux.Store.new(Reducer)

local LOADABLE_SERVICES = {
	"Workspace",
	"ReplicatedStorage",
	"ReplicatedFirst",
	"ServerStorage",
	"ServerScriptService",
	"StarterGui"
}

local Flipbook = script:FindFirstAncestor("Flipbook")
local Utility = Flipbook.utility

local FileUtils = require(Utility.FileUtils)
local Maid = require(Utility.Maid)

local fileMaids = {}

local FileLoader = { maid = Maid.new() }

function FileLoader.getStore()
	return Store
end

function FileLoader.handleFile(file, addStory, removeStory)
	local isFlipbook = FileUtils.fileIsFlipbook(file)
	local isStory = FileUtils.fileIsStory(file)

	if file:IsA("ModuleScript") then
		if isFlipbook or isStory then
			addStory(file)

			local fileMaid = Maid.new()
			fileMaid:GiveTask(file.AncestryChanged:Connect(function()
				removeStory(file)

				if file:IsDescendantOf(game) then
					delay(0.1, function()
						addStory(file)
					end)
				end
			end))
		else
			local changedConnection
			changedConnection = file.Changed:Connect(function()
				FileLoader.handleFile(file, addStory)
				changedConnection:Disconnect()
				changedConnection = nil
			end)
		end
	end
end

function FileLoader.startLoadingFiles()
	FileLoader.maid:DoCleaning()

	local function addStory(file)
		Store:dispatch({
			type = "addStory",
			file = file
		})
	end

	local function removeStory(file)
		Store:dispatch({
			type = "removeStory",
			file = file
		})
	end

	for _, serviceName in ipairs(LOADABLE_SERVICES) do
		local service = game:GetService(serviceName)

		for _, descendant in ipairs(service:GetDescendants()) do
			FileLoader.handleFile(descendant, addStory, removeStory)
		end

		FileLoader.maid:GiveTask(service.DescendantAdded:Connect(function(descendant)
			FileLoader.handleFile(descendant, addStory, removeStory)
		end))
	end
end

function FileLoader.stopLoadingFiles()
	Store:dispatch({
		type = "clearStories"
	})
end

function FileLoader.refreshFiles()
	FileLoader.stopLoadingFiles()
	delay(0.1, function()
		FileLoader.startLoadingFiles()
	end)
end

return FileLoader