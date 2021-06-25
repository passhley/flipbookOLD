local StoryUtils = {}

function StoryUtils.IsFlipbook(file)
	return file:IsA("ModuleScript")
		and file.Name:match("%.flip$")
end

function StoryUtils.IsStory(file)
	return file:IsA("ModuleScript")
		and file.Name:match("%.story$")
end

function StoryUtils._SafeRequireFile(file)
	file = file:Clone()

	local success, source = pcall(function()
		return require(file)
	end)

	if not success then
		warn(("[StoryUtils._SafeRequireFile]: Error requiring module [%s], %s"):format(file.Name, source))
		return nil
	end

	file:Destroy()

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

function StoryUtils.GetFileLocation(file)
	if StoryUtils.IsStory(file) then
		local folder = file:FindFirstAncestorWhichIsA("Folder")

		if folder then
			folder = folder.Name:gsub("^%l", string.upper)
		else
			folder = "Unorganized Components"
		end

		return folder
	elseif StoryUtils.IsFlipbook(file) then
		local source = StoryUtils.GetFlipbookSource(file)
		local location = "Unorganized Components"

		if source then
			if source.Location then
				location = source.Location:gsub("^%l", string.upper)
			else
				local folder = file:FindFirstAncestorWhichIsA("Folder")

				if folder then
					location = folder.Name:gsub("^%l", string.upper)
				end
			end
		end

		return location
	end
end

function StoryUtils.GetFileName(file)
	if StoryUtils.IsFlipbook(file) then
		return file.Name:sub(1, #file - #".flip")
	elseif StoryUtils.IsStory(file) then
		return file.Name:sub(1, #file - #".story")
	end
end

return StoryUtils