local TextService = game:GetService("TextService")

local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor
local Utility = Flipbook.utility

local Roact = require(Vendor.Roact)
local Lexer = require(Utility.Lexer)

local CodeTemplate = require(script.Parent.CodeTemplate)

local e = Roact.createElement

local function _GetLineOfCode(code)
	return select(2, code:gsub("\n", "\n")) + 1
end

local tokenToColor
local function PopulateTokenToColor()
	local studio = settings().Studio.Theme
	tokenToColor = {
		number = studio:GetColor(Enum.StudioStyleGuideColor.ScriptNumber, Enum.StudioStyleGuideModifier.Default);
		string = studio:GetColor(Enum.StudioStyleGuideColor.ScriptString, Enum.StudioStyleGuideModifier.Default);
		char = studio:GetColor(Enum.StudioStyleGuideColor.ScriptString, Enum.StudioStyleGuideModifier.Default);
		comment = studio:GetColor(Enum.StudioStyleGuideColor.ScriptComment, Enum.StudioStyleGuideModifier.Default);
		mcomment = studio:GetColor(Enum.StudioStyleGuideColor.ScriptComment, Enum.StudioStyleGuideModifier.Default);
		iden = studio:GetColor(Enum.StudioStyleGuideColor.ScriptText, Enum.StudioStyleGuideModifier.Default);
		keyword = studio:GetColor(Enum.StudioStyleGuideColor.ScriptKeyword, Enum.StudioStyleGuideModifier.Default);
		builtin = studio:GetColor(Enum.StudioStyleGuideColor.ScriptBuiltInFunction, Enum.StudioStyleGuideModifier.Default);
		operator = studio:GetColor(Enum.StudioStyleGuideColor.ScriptOperator, Enum.StudioStyleGuideModifier.Default);
	}
end
PopulateTokenToColor()

local function CodePreview(props)
	local object = props.Object
	local children = {}
	local frameSize = UDim2.new(0, 0, 0, 0)

	if object then
		local lineHeight = 17
		local code = object.Source
		local loc = _GetLineOfCode(code)
		local maxLineWidth = 0
		local currentLineWidth = 0
		local currentLineNum = 0

		local largeSize = Vector2.new(1e10, 1e10)
		local textSize = 14
		local textFont = Enum.Font.Code
		local charSize = TextService:GetTextSize(" ", textSize, textFont, largeSize).X

		local function _GetTextWidth(text)
			return #text * charSize
		end

		local function _StartNewLine()
			currentLineNum = (currentLineNum + 1)
			currentLineWidth = 0
		end

		local function _AppendCurrentLine(token, text)
			local width = _GetTextWidth(text)
			table.insert(children, e(CodeTemplate, {
				Text = text,
				TextColor3 = (tokenToColor[token] or tokenToColor.operator),
				Size = UDim2.fromOffset(width, lineHeight),
				Position = UDim2.fromOffset(currentLineWidth, (currentLineNum - 1)*lineHeight)
			}))

			currentLineWidth += width
			if (currentLineWidth > maxLineWidth) then
				maxLineWidth = currentLineWidth
			end
		end

		_StartNewLine()

		local gsub = string.gsub
		local sub = string.sub
		local match = string.match
		local gmatch = string.gmatch
		local select = select

		for token,src in Lexer.scan(code) do
			if (token == "space") then
				local newLines = select(2, gsub(src, "\n", "\n"))
				local spacesAtEnd = match(src, "\n?([^\n]+)$")
				for _ = 1,newLines do
					_StartNewLine()
				end
				if (spacesAtEnd and #spacesAtEnd > 0) then
					_AppendCurrentLine(token, spacesAtEnd)
				end
			elseif (token == "comment") then
				if (sub(src, -1) == "\n") then
					src = src:sub(0, -2)
				end
				_AppendCurrentLine(token, src)
				_StartNewLine()
			elseif (token == "mcomment") then
				if (sub(src, -1) ~= "\n") then src = (src .. "\n") end
				local notFirst = false
				for line in gmatch(src, "(.-)\n") do
					if (notFirst) then
						_StartNewLine()
					end
					_AppendCurrentLine(token, line)
					notFirst = true
				end
			else
				if (token == "string") then
					src = gsub(src, "[^\\]\n", "\\n")
				end
				_AppendCurrentLine(token, src)
			end
		end
		-- scroller.CanvasPosition = Vector2.new(0, 0)
		-- scroller.CanvasSize = UDim2.new(
		-- 	0,
		-- 	maxLineWidth + 0 + 0,
		-- 	0,
		-- 	(loc * lineHeight) + 0 + 0
		-- )
		-- codeFrame.Parent = codeFrameParent
		frameSize = UDim2.new(
			1, 0, 0, (loc*lineHeight)
		)
	end

	return e("Frame", {
		Size = UDim2.new(1, -20, 0, frameSize.Y.Offset),
		Position = UDim2.fromOffset(10, 60),
		BackgroundTransparency = 1,
		Visible = props.Visible
	}, children)
end

return CodePreview