local function RoactFlipbookWithStates(t, flipbook)
	return {
		Location = "Flipbook Components", --Optional, will use the first ancestor folder name if nil.
		Mount = {
			Component = RoactComponent,
			States = {
				State0 = {
					-- Properties you want the component to have for this state
				}
			}
		},

		Controls = { --Optional
			Property = {
				Description = "", --Optional
				ControlType = flipbook.Radio --These are built in components for the control tab, if not specified, it
												--will try to find the best fit one given the starting value in properties,
			}
		}
	}
end

local function RoactFlipbookWithoutStates(t, flipbook)
	return {
		Location = "Flipbook Components", --Optional, will use the first ancestor folder name if nil.
		Mount = RoactComponent,

		Controls = { --Optional
			Property = {
				Description = "", --Optional
				ControlType = flipbook.Radio --These are built in components for the control tab, if not specified, it
												--will try to find the best fit one given the starting value in properties,
			}
		}
	}
end

local function OOPFlipbookWithStates(t, flipbook)
	return {
		Location = "Flipbook Components",
		Mount = {

			-- If we are using states, or controls we want to return
			-- the component AFTER the cleanup function so that we can
			-- access it in the other handlers
			Create = function()
				-- Create your UI here
				local component = Instance.new("Frame")

				return function()
					-- Cleanup your UI here
					component:Destroy()
				end, component
			end,

			States = {
				State0 = function(component)
					-- We pass in the component here,
					-- so that it can be altered
				end
			}
		},

		Controls = { --Optional
			Property = {
				Description = "", --Optional
				ControlType = flipbook.Radio --These are built in components for the control tab, if not specified, it
												--will try to find the best fit one given the starting value in properties,
			}
		},

		Connections = {
			Property = function(component)
				-- This is called whenever the [Property]
				-- is changed
			end
		}
	}
end

local function OOPFlipbookWithoutStates(t, flipbook)
	return {
		Location = "", -- Optional

		-- If we are using controls we want to return
		-- the component AFTER the cleanup function so that we can
		-- access it in the other handlers
		Mount = function()
			-- Build UI here
			local component = Instance.new("Frame")

			return function()
				-- Cleanup your UI here
				component:Destroy()
			end, component
		end,

		Controls = { --Optional
			Property = {
				Description = "", --Optional
				ControlType = flipbook.Radio --These are built in components for the control tab, if not specified, it
												--will try to find the best fit one given the starting value in properties,
			}
		},

		Connections = {
			Property = function(component)
				-- This is called whenever the [Property]
				-- is changed
			end
		}
	}
end