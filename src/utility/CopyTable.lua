local function copyTable(t0)
	local t1 = {}
	for k, v in pairs(t0) do
		t1[k] = v
	end	
	return t1
end

return copyTable