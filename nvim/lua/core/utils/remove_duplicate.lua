-- https://stackoverflow.com/questions/20066835/lua-remove-duplicate-elements
return function(table)
	local hash = {}
	local res = {}

	for _, value in ipairs(table) do
		if not hash[value] then
			res[#res + 1] = value
			hash[value] = true
		end
	end

	return res
end
