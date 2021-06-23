local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local Maid = require(Utility.Maid)

local e = Roact.createElement

local Preview = Roact.Component:extend("Preview")

function Preview:init()
	self._frame = Roact.createRef()
	self._maid = Maid.new()

	self.monkeyRequireCache = {}
	self.monkeyRequireMaid = Maid.new()

	self.monkeyGlobalTable = {}

	self.monkeyRequire = function(otherScript)
		if self.monkeyRequireCache[otherScript] then
			return self.monkeyRequireCache[otherScript]
		end

		local result, parseError = loadstring(otherScript.Source, otherScript:GetFullName())
		if result == nil then
			error(("Could not parse %s: %s"):format(otherScript:GetFullName(), parseError))
			return
		end

		local fenv = setmetatable({
			require = self.monkeyRequire,
			script = otherScript,
			_G = self.monkeyGlobalTable,
		}, {
			__index = getfenv(),
		})

		setfenv(result, fenv)

		local output = result()
		self.monkeyRequireCache[otherScript] = output

		self.monkeyRequireMaid:GiveTask(otherScript.Changed:connect(function()
			self:refreshPreview()
		end))

		return output
	end

end

function Preview:didMount()
	self:refreshPreview()
end

function Preview:didUpdate()
	self:refreshPreview()
end

function Preview:willUnmount()
	self.monkeyRequireMaid:DoCleaning()
end

function Preview:refreshPreview()
	if self.cleanup then
		local ok, result = pcall(self.cleanup)
		if not ok then
			warn("Error cleaning up story: " .. result)
		end

		self.cleanup = nil
	end

	local preview = self._frame:getValue()
	if preview ~= nil then
		preview:ClearAllChildren()
	end

	local selectedStory = self.props.Selected
	if selectedStory then
		selectedStory = selectedStory.Object

		self.monkeyRequireCache = {}
		self.monkeyGlobalTable = {}
		self.monkeyRequireMaid:DoCleaning()

		local requireOk, result = xpcall(self.monkeyRequire, debug.traceback, selectedStory)
		if not requireOk then
			warn("Error requiring story: " .. result)
			return
		end

		local execOk, cleanup = xpcall(function()
			if typeof(result) == "function" then
				return result(self._frame:getValue())
			elseif typeof(result) == "table" then
				if result.Mount then
					return result.Mount(self._frame:getValue())
				end
			end
		end, debug.traceback)

		if not execOk then
			warn("Error executing story: " .. cleanup)
			return
		end

		self.cleanup = cleanup
	end
end

function Preview:render()
	return e("Frame", {
		Size = UDim2.new(1, -20, 0, 350),
		Position = UDim2.fromOffset(10, 0),
		BackgroundTransparency = 1,
		[Roact.Ref] = self._frame
	})
end

return Preview