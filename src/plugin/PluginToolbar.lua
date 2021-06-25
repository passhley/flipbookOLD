local PluginAppManager = require(script.Parent.PluginAppManager)

local PluginToolbar = {}

function PluginToolbar.Init(plugin)
	local toolbar = plugin:CreateToolbar("flipbook")
	local flipbookButton = toolbar:CreateButton(
		"flipbook",
		"Live UI Previewer",
		"rbxassetid://6991267103",
		"flipbook"
	)

	flipbookButton.Click:Connect(function()
		PluginAppManager.ToggleWidget()
	end)
	flipbookButton.ClickableWhenViewportHidden = true
end

return PluginToolbar