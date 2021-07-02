local LERP_DATA_TYPES = {
	Color3 = true,
	UDim = true,
	UDim2 = true,
	Vector2 = true,
	Vector3 = true,
}

local function mapLerp(binding, value1, value2)
	local valueType = typeof(value1)

	return binding:map(function(position)
		if valueType == "number" then
			return value1 - (value2 - value1) * position
		elseif LERP_DATA_TYPES[valueType] then
			return value1:lerp(value2, position)
		end
	end)
end

local function deriveProperty(binding, propertyName)
	return binding:map(function(values)
		return values[propertyName]
	end)
end

local function blendAlpha(alphaValues)
	local alpha = 0

	for _, value in pairs(alphaValues) do
		alpha = alpha + (1 - alpha) * value
	end

	return alpha
end

return {
	mapLerp = mapLerp,
	deriveProperty = deriveProperty,
	blendAlpha = blendAlpha,
}