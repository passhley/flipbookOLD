local function fileIsFlipbook(file)
	return file:IsA("ModuleScript") and file.Name:match("%.flip$")
end

local function fileIsStory(file)
	return file:IsA("ModuleScript") and file.Name:match("%.story$")
end

local function getFileName(file)
	local isStory = fileIsStory(file)
	local isFlip = fileIsFlipbook(file)

	return file.Name:sub(1, #file.Name - #(isStory and ".story" or isFlip and ".flip"))
end

local function getFileFolder(file)
	local folder = file:FindFirstAncestorWhichIsA("Folder")

	if folder then
		return folder.Name
	else
		return file.Parent.Name
	end
end

local function getFileSource(file)
	local newFile = file:Clone()
	newFile.Name = getFileName(file)
	newFile.Parent = file.Parent

	local success, source = pcall(function()
		return require(newFile)
	end)

	newFile:Destroy()

	local isFlip = fileIsFlipbook(file)
	if isFlip then
		if typeof(source) == "function" then
			source = source()
		end
	end

	if not success then
		warn(("[FileUtils.getFileSource]: Error requiring module [%s], %s"):format(file.Name, source))
		return nil
	end

	return source
end

local function getFlipMetadata(flip)
	local source = getFileSource(flip)

	if source then
		local metadata = source.metadata

		if metadata then
			return metadata
		end
	end

	return
end

local function getFileLocation(file)
	local isStory = fileIsStory(file)
	local isFlip = fileIsFlipbook(file)

	if isStory then
		return getFileFolder(file)
	elseif isFlip then
		local metadata
		if typeof(file) == "table" and file.metadata then
			metadata = file.metadata
		else
			metadata = getFlipMetadata(file)
		end

		if metadata then
			return metadata.location
		else
			return getFileFolder(file)
		end
	end

	return
end

return {
	fileIsFlipbook = fileIsFlipbook,
	fileIsStory = fileIsStory,
	getFileName = getFileName,
	getFileSource = getFileSource,
	getFileLocation = getFileLocation,
	getFlipMetadata = getFlipMetadata,
}