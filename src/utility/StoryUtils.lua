local StoryUtils = {}

function StoryUtils.IsFlipbook(file)
	return file:IsA("ModuleScript")
		and file.Name:match("%.flip$")
end

function StoryUtils.IsStory(file)
	return file:IsA("ModuleScript")
		and file.Name:match("%.story$")
end

function StoryUtils.ClearName(fileName)
	if fileName:match("%.story$") then
		return fileName:sub(1, #fileName - #(".story"))
	elseif fileName:match("%.flip$") then
		return fileName:sub(1, #fileName - #(".flip"))
	end

	return
end

function StoryUtils._SafeRequireFile(file)
	print(("[StoryUtils._SafeRequireFile]: Requiring module [%s]"):format(file.Name))
	local newFile = file:Clone()

	if StoryUtils.IsFlipbook(file) then
		newFile.Name = file.Name:sub(1, #file.Name - #".flip")
	elseif StoryUtils.IsStory(file) then
		newFile.Name = file.Name:sub(1, #file.Name - #".story")
	end

	newFile.Parent = file.Parent

	local success, source = pcall(function()
		return require(newFile)
	end)

	newFile:Destroy()

	if not success then
		warn(("[StoryUtils._SafeRequireFile]: Error requiring module [%s], %s"):format(file.Name, source))
		return nil
	end


	return source
end

function StoryUtils.GetFlipbookSource(file)
	local source = StoryUtils._SafeRequireFile(file)

	if source then
		if typeof(source) == "function" then
			source = source()
		end
	end

	return source
end

function StoryUtils.GetStorySource(file)
	return StoryUtils._SafeRequireFile(file)
end

function StoryUtils()

end

function StoryUtils.GetFileLocation(file)
end

function StoryUtils.GetFileName(file)
	if StoryUtils.IsFlipbook(file) then
		return file.Name:sub(1, #file - #".flip")
	elseif StoryUtils.IsStory(file) then
		return file.Name:sub(1, #file - #".story")
	end
end

function StoryUtils.CalculateFolderSize(storyData)
	local componentSize = 26
	local stateSize = 26

	local currentSize = 26

	for _, component in pairs(storyData) do
		currentSize += componentSize

		if typeof(component) == "table" then
			if component.States then
				for _ in pairs(component.States) do
					currentSize += stateSize
				end
			end
		end
	end

	return currentSize
end

return StoryUtils