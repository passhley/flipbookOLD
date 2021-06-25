local Flipbook = script:FindFirstAncestor("Flipbook")
local Utility = Flipbook.utility

local Maid = require(Utility.Maid)
local Actions = require(Utility.Actions)
local StoryUtils = require(Utility.StoryUtils)

local _Maid = Maid.new()
local _FileMaids = {}
local _ReadableServices = {
	"Workspace", "ReplicatedStorage", "ReplicatedFirst",
	"ServerScriptService", "ServerStorage", "StarterGui", "StarterPlayer"
}

local PluginStoryLoader = {}

function PluginStoryLoader._HandleFile(file)
	if file:IsA("ModuleScript") then
		local isFlipbook = StoryUtils.IsFlipbook(file)
		local isStory = StoryUtils.IsStory(file)

		if isFlipbook or isStory then
			local location = StoryUtils.GetFileLocation(file)
			Actions.AddStory(location, file)

			local _maid = Maid.new()
			_FileMaids[file] = _maid

			_maid:GiveTask(file.Changed:Connect(function()
				local _isStory = StoryUtils.IsStory(file)
				local _isFlipbook = StoryUtils.IsFlipbook(file)

				if not _isStory and not _isFlipbook then
					Actions.RemoveStory(file)
					_FileMaids[file] = nil
					_maid:Destroy()
				end
			end))

			_maid:GiveTask(file.AncestryChanged:Connect(function()
				if not file:IsDescendantOf(game) then
					Actions.RemoveStory(file)
					_FileMaids[file] = nil
					_maid:Destroy()
				end
			end))
		else
			local fileChanged
			fileChanged = file.Changed:Connect(function()
				PluginStoryLoader._HandleFile(file)
				fileChanged:Disconnect()
				fileChanged = nil
			end)
		end
	end
end

function PluginStoryLoader.Enable()
	for _, serviceName in ipairs(_ReadableServices) do
		local service = game:GetService(serviceName)

		_Maid:GiveTask(service.DescendantAdded:Connect(function(file)
			PluginStoryLoader._HandleFile(file)
		end))

		for _, file in ipairs(service:GetDescendants()) do
			PluginStoryLoader._HandleFile(file)
		end
	end
end

function PluginStoryLoader.Disable()
	for _, maid in pairs(_FileMaids) do
		maid:Destroy()
	end
	_FileMaids = {}

	Actions.ClearStories()
	_Maid:DoCleaning()
end


return PluginStoryLoader