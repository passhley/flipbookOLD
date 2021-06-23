--[[

	-- This will function just like a normal
	-- Hoarcekat story.
	local function NoControlsStory(target)
		-- Create object here
		
		return function()
			-- Destroy object here
		end
	end

	local function RoactControlledStory(target, storybook)
		-- Mount object here

		return {
			Disconnect = function()
				-- Unmount object here
			end,

			Controls = {
				controlProperty = {
					initialValue = any,
					description = "",
					controlType = [StorybookControlType] or nil 
				}
			}
		}
	end

	local function NonRoactControlledStory(target, storybook)
		-- Create object here

		return {
			Disconnect = function()
				-- Destroy object here
			end,

			Controls = {
				controlProperty = {
					initialValue = any,
					description = "",
					controlType = [StorybookControlType] or nil 
				}
			},

			Connections = {
				controlProperty = function(old, new)
					-- Use given values to upadte UI
				end
			}
		}
	end

-------------------------------------------------------------------------------

	local function RoactComponent(props)
		return e("TextLabel", {
			TextColor3 = props.TextColor,
			Text = props.Text
		}, {
			UICorner = e("UICorner", {
				CornerRadius = props.CornerRadius
			})
		})
	end


	-- For Roact apps, we will pass in the component itself instead
	-- of mounting it, it will automatically clean up.
	local function RoactApp(t, storybook)
		local thisConnection = RunService.RenderStepped:Connect(function(dt)
			print(dt)
		end)

		return RoactComponent, {
			Disconnect = function()
				thisConnection:Disconnect()
				thisConnection = nil
			end,

			Controls = {
				TextColor = {
					initialValue = Color3.new(1, 1, 1),
					description = "The color of the text.",
					controlType = storybook.ColorPicker
				},

				CornerRadius = {
					initialValue = UDim.new(0, 4),
					description = "Size of the corner bevels",
					controlType = storybook.UDimInput
				}
			}
		}
	end

	-- Internally this will probably be something like
	local states = {}
	for control, controlData in pairs(Controls) do
		props[control] = controlData.initialValue
	end



]]