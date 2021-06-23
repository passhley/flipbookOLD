function _RandomChoice(list, random)
	if #list == 0 then
	return nil
	elseif #list == 1 then
		return list[1]
	else
		if random then
			return list[random:NextInteger(1, #list)]
		else
			return list[math.random(1, #list)]
		end
	end
end

function _UppercaseFirstLetter(str)
	return str:gsub("^%a", string.upper)
end

local WORDS = {
	"lorem", "ipsum", "dolor", "sit", "amet", "consectetuer", "adipiscing", "elit", "sed", "diam", "nonummy",
	"nibh", "euismod", "tincidunt", "ut", "laoreet", "dolore", "magna", "aliquam", "erat"}

local function LipsumSentence(numWords, random)
	random = random or Random.new()
	numWords = numWords or random:NextInteger(6, 12)

	local output = ""

	local commaIndexes = {}
	if random:NextNumber() >= 0.3 and numWords >= 8 then
		commaIndexes[random:NextInteger(4, 5)] = true
	end

	for w = 1, numWords do
		local word = _RandomChoice(WORDS, random)

		if w == 1 then
			output = output .. _UppercaseFirstLetter(word)
		else
			if commaIndexes[w] then
				output = output .. ", " .. word
			else
				output = output .. " " .. word
			end
		end
	end

	output = output .. "."
	return output
end

return LipsumSentence