local function _IsAStory(instance)
	return instance:IsA("ModuleScript") and instance.Name:match("%.story$")
end

local function _IsAFlip(instance)
	return instance:IsA("ModuleScript") and instance.Name:match("%.flip$")
end

local function _GetSource(obj)
	local source
	local success, errorMsg = pcall(function()
		source = require(obj)
	end)

	if success then
		print("[flipbook._GetSource]: Success loading source for", obj.Name)
	else
		warn("[flipbook._GetSource]: Issue loading source for", obj.Name)
	end

	if errorMsg then
		warn(("[flipbook._GetSource]: Error loading story (%s). Error message: %s"):format(obj.Name, errorMsg))
	end

	return source
end

local function _GetContents(child)
	local isStory = _IsAStory(child)
	local isFlip = _IsAFlip(child)

	local contents = nil
	local folder = nil

	if isStory or isFlip then
		contents = {}
		local storyName = child.Name
		local source = _GetSource(child)

		if source then
			if isFlip then
				storyName = storyName:sub(1, #storyName - #".flip")

				folder = source.Location

				if folder == nil then
					folder = child:FindFirstAncestorWhichIsA("Folder")

					if folder then
						folder = folder.Name
					end
				end

				contents.Name = storyName
				contents.Object = child
			elseif isStory then
				folder = child:FindFirstAncestorWhichIsA("Folder")
				if folder then
					folder = folder.Name
				end
				storyName = storyName:sub(1, #storyName - #".story")

				contents.Name = storyName
				contents.Object = child
			end
		end
	end

	return contents, folder
end

return {
	IsFlip = _IsAFlip,
	IsStory = _IsAStory,
	GetContents = _GetContents,
}