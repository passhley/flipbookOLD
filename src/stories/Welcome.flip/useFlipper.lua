local Flipper = require(script.Parent.Flipper)

local function useSingleMotor(initialValue, hooks)
	local useBinding = hooks.useBinding

	local motor = Flipper.SingleMotor.new(initialValue)
	local spring, setBinding = useBinding(motor:getValue())
	motor:onStep(setBinding)

	local function setSpring(value, options)
		motor:setGoal(
			Flipper.Spring.new(value, options)
		)
	end

	return spring, setSpring
end

local function useGroupMotor(initialValue, hooks)
	local useBinding = hooks.useBinding

	local motor = Flipper.GroupMotor.new(initialValue)
	local spring, setBinding = useBinding(motor:getValue())
	motor:onStep(setBinding)

	local function setSpring(values)
		local springs = {}
		for k, v in pairs(values) do
			springs[k] = Flipper.Spring.new(v[1], v[2])
		end

		motor:setGoal(springs)
	end

	return spring, setSpring
end

return {
	useSingleMotor = useSingleMotor,
	useGroupMotor = useGroupMotor
}