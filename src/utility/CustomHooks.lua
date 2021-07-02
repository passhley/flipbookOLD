local Flipbook = script:FindFirstAncestor("Flipbook")
local Utility = Flipbook.utility
local Vendor = Flipbook.vendor

local Flipper = require(Vendor.Flipper)
local Theme = require(Utility.Theme.Theme)
local GetStudio = require(Utility.Theme.GetStudio)

local function useTheme(hooks)
	local useState, useEffect = hooks.useState, hooks.useEffect
	local theme, setTheme = useState(Theme.Light)

	useEffect(function()
		local studioTheme = GetStudio().Theme
		if studioTheme.Name == "Dark" then
			setTheme(Theme.Dark)
		else
			setTheme(Theme.Light)
		end

		local connection = GetStudio().ThemeChanged:Connect(function()
			local _studioTheme = GetStudio().Theme

			if _studioTheme.Name == "Dark" then
				setTheme(Theme.Dark)
			else
				setTheme(Theme.Light)
			end
		end)

		return function()
			connection:Disconnect()
			connection = nil
		end
	end, { theme })

	return theme
end

local function useSingleMotor(initialValue, hooks)
	warn("USE SINGLE MOTOR!!!!!")
	local useBinding = hooks.useBinding

	local motor = Flipper.SingleMotor.new(initialValue)
	local spring, setBinding = useBinding(motor:getValue())
	motor:onStep(setBinding)

	local function setSpring(...)
		motor:setGoal(...)
	end

	return spring, setSpring
end

local function useGroupMotor(initialValue, hooks)
	local useBinding = hooks.useBinding

	local motor = Flipper.GroupMotor.new(initialValue)
	local spring, setBinding = useBinding(motor:getValue())
	motor:onStep(setBinding)

	local function setSpring(...)
		motor:setGoal(...)
	end

	return spring, setSpring
end

return {
	useTheme = useTheme,
	useSingleMotor = useSingleMotor,
	useGroupMotor = useGroupMotor
}