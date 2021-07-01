local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local RoactRodux = require(Vendor.RoactRodux)
local Hooks = require(Vendor.Hooks)
local Maid = require(Utility.Maid)
local FileUtils = require(Utility.FileUtils)

local e = Roact.createElement
local hook = Hooks.new(Roact)

local Preview = Roact.Component:extend("Preview")

function Preview:init()
	self.previewZone = Roact.createRef()

	self.requireCache = {}
	self.requireMaid = Maid.new()
	self.globalTable = {}

	self.require = function(file)
		if self.requireCache[file] then
			return self.requireCache[file]
		end

		local source, errorMsg = loadstring(file.Source, file:GetFullName())
		if source == nil then
			error("[Flipbook]: Could not load file [" .. file.Name .. "] " .. errorMsg)
			return
		end

		local fenv = setmetatable({
			require = self.require,
			script = file,
			_G = self.globalTable,
		}, {
			__index = getfenv(),
		})

		setfenv(source, fenv)

		local fileData = source()
		self.requireCache[file] = fileData
		self.requireMaid:GiveTask(file.Changed:Connect(function()
			self:previewFile()
		end))

		return fileData
	end
end

function Preview:didMount()
	self:previewFile()
end

function Preview:didUpdate()
	self:previewFile()
end

function Preview:willUnmount()
	self.requireMaid:Destroy()
end

function Preview:previewFile()
	if self.cleanup then
		pcall(self.cleanup)
		self.cleanup = nil
	end

	local previewZone = self.previewZone:getValue()
	if previewZone then
		previewZone:ClearAllChildren()
	end

	local currentFile = self.props.currentFile
	if currentFile and typeof(currentFile) ~= "table" and currentFile:IsA("ModuleScript") then
		self.requireCache = {}
		self.globalTable = {}
		self.requireMaid:DoCleaning()

		local successRequire, result = xpcall(self.require, debug.traceback, currentFile)
		if not successRequire then
			warn("[Flipbook]: Issue requiring file: " .. result)
			return
		end

		if not result then
			return
		end

		local isStory = FileUtils.fileIsStory(currentFile)
		local isFlipbook = FileUtils.fileIsFlipbook(currentFile)
		if isStory then
			local executionSuccess, cleanup = xpcall(function()
				return result(previewZone)
			end, debug.traceback)

			if not executionSuccess then
				warn("[Flipbook]: Issue executing file: " .. cleanup)
				return
			end

			self.cleanup = cleanup
		elseif isFlipbook then
			if typeof(result) == "function" then
				result = result()--TODO: Pass in flipbook components here
			end

			local metadata = result.metadata
			local component = result.component
			local isRoact = false

			if component == nil then
				warn("[Flipbook]: No component found in flipbook")
				return
			end

			if metadata then
				if metadata.library then
					if metadata.library == "Roact" then
						isRoact = true
					end
				end
			end

			if isRoact then
				local defaultProps = {}
				if metadata then
					if metadata.argTypes then
						for argName, argData in pairs(metadata.argTypes) do
							if argData.initial == nil then
								warn("[Flipbook]: Issue setting property for " .. argName .. " initial value is nil")
								return
							end

							defaultProps[argName] = argData.initial
						end
					end
				end

				self.currentComponent = component

				local handle = nil
				local executionSuccess, errorMsg = pcall(function()
					local element = Roact.createElement(self.currentComponent)
					handle = Roact.mount(
						element,
						previewZone
					)
				end)

				if errorMsg then
					warn(errorMsg)
				end

				if not executionSuccess then
					warn("[Flipbook]: Issue executing file: " .. handle)
					return
				end

				self.cleanup = function()
					Roact.unmount(handle)
				end
			else
				local success, cleanup, returnedComponent = xpcall(function()
					return result.component(previewZone)
				end, debug.traceback)

				if not success then
					warn("[Flipbook]: Issue executing file: " .. cleanup)
					return
				end

				if returnedComponent then
					self.component = returnedComponent
				end

				if result.metadata then
					if result.metadata.argTypes then
						for _, argData in pairs(result.metadata.argTypes) do
							if argData.onUpdate then
								argData.onUpdate(self.returnedComponent, argData.initial, argData.initial)
							end
						end
					end
				end

				self.cleanup = cleanup
			end
		end
	end
end

function Preview:render()
	return e("Frame", {
		Size = UDim2.new(1, 0, 0, 300),
		BackgroundTransparency = 1,
		[Roact.Ref] = self.previewZone
	})
end

return RoactRodux.connect(
	function(state)
		return {
			currentFile = state.currentFile
		}
	end
)(Preview)