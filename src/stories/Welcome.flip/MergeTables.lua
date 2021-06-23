local function MergeTables(t0, t1)
	local newT = {}

	for k, v in pairs(t0) do
		newT[k] = v
	end

	for k, v in pairs(t1) do
		newT[k] = v
	end

	return newT
end

return MergeTables