local Flipbook = script:FindFirstAncestor("Flipbook")
local Utility = Flipbook.utility

local StoryUtils = require(Utility.StoryUtils)
local Maid = require(Utility.Maid)
local Actions = require(Utility.Actions)

local _Maid = Maid.new()
local _ObjectMaids = {}
local _Services = { "Workspace", "ReplicatedFirst", "ReplicatedStorage", "ServerScriptService", "ServerStorage", "StarterGui", "StarterPlayer"}

local PluginStoryLoader = {}

local function _HandleChild(child)
	if child:IsA("ModuleScript") then
		local isStory = StoryUtils.IsStory(child)
		local isFlipbook = StoryUtils.IsFlip(child)

		if isStory or isFlipbook then
			local storyData, location = StoryUtils.GetContents(child)
			Actions.AddStory(location, storyData)

			local _maid = Maid.new()
			_ObjectMaids[child] = _maid

			_maid:GiveTask(child.Changed:Connect(function()
				local _isStory = StoryUtils.IsStory(child)
				local _isFlipbook = StoryUtils.IsFlip(child)

				if not _isStory and not _isFlipbook then
					Actions.RemoveStory(child)
				elseif _isStory or _isFlipbook then
					-- local c = StoryUtils.GetContents(child)
					-- Actions.UpdateStory()
				end
			end))

			_maid:GiveTask(child.AncestryChanged:Connect(function()
				if not child:IsDescendantOf(game) then
					Actions.RemoveStory(child)
				end
			end))
		else
			local change
			change = child.Changed:Connect(function()
				local _isStory = StoryUtils.IsStory(child)
				local _isFlipbook = StoryUtils.IsFlip(child)

				if _isStory or _isFlipbook then
					local storyData, location = StoryUtils.GetContents(child)
					Actions.AddStory(location, storyData)

					local _maid = Maid.new()
					_ObjectMaids[child] = _maid

					_maid:GiveTask(child.Changed:Connect(function()
						local _isStory = StoryUtils.IsStory(child)
						local _isFlipbook = StoryUtils.IsFlip(child)

						if not _isStory and not _isFlipbook then
							Actions.RemoveStory(child)
						elseif _isStory or _isFlipbook then
							local c = StoryUtils.GetContents(child)
							Actions.UpdateStory(c)
						end
					end))

					_maid:GiveTask(child.AncestryChanged:Connect(function()
						if not child:IsDescendantOf(game) then
							Actions.RemoveStory(child)
						end
					end))

					change:Disconnect()
					change = nil
				end
			end)
		end
	end
end

function PluginStoryLoader.Enable()
	Actions.ClearStories()

	for _, serviceName in ipairs(_Services) do
		local service = game:GetService(serviceName)

		_Maid:GiveTask(service.DescendantAdded:Connect(function(child)
			_HandleChild(child)
		end))

		for _, child in ipairs(service:GetDescendants()) do
			_HandleChild(child)
		end
	end
end

function PluginStoryLoader.Disable()
	for _, maid in pairs(_ObjectMaids) do
		maid:Destroy()
	end
	_ObjectMaids = {}

	Actions.ClearStories()
	_Maid:DoCleaning()
end

return PluginStoryLoader