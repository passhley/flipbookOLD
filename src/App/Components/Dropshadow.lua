local Flipbook = script:FindFirstAncestor("Flipbook")
local Vendor = Flipbook.vendor

local Roact = require(Vendor.Roact)

local e = Roact.createElement

local function Dropshadow()
	return e("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1
	}, {
		AmbientShadow = e("ImageLabel", {
			ScaleType = Enum.ScaleType.Slice,
			BackgroundTransparency = 1,
			ImageColor3 = Color3.new(0,0,0),
			Size = UDim2.new(1, 5, 1, 5),
			Image = "rbxassetid://1316045217",
			Position = UDim2.new(0.5, 0, 0.5, 3),
			AnchorPoint = Vector2.new(0.5, 0.5),
			SliceCenter = Rect.new(10, 10, 118, 118),
			ImageTransparency = 0.9
		}),

		PenumbraShadow = e("ImageLabel", {
			ScaleType = Enum.ScaleType.Slice,
			BackgroundTransparency = 1,
			ImageColor3 = Color3.new(0,0,0),
			Size = UDim2.new(1, 18, 1, 18),
			Image = "rbxassetid://1316045217",
			Position = UDim2.new(0.5, 0, 0.5, 1),
			AnchorPoint = Vector2.new(0.5, 0.5),
			SliceCenter = Rect.new(10, 10, 118, 118),
			ImageTransparency = 0.98
		}),

		UmbraShadow = e("ImageLabel", {
			ScaleType = Enum.ScaleType.Slice,
			BackgroundTransparency = 1,
			ImageColor3 = Color3.new(0,0,0),
			Size = UDim2.new(1, 10, 1, 10),
			Image = "rbxassetid://1316045217",
			Position = UDim2.new(0.5, 0, 0.5, 6),
			AnchorPoint = Vector2.new(0.5, 0.5),
			SliceCenter = Rect.new(10, 10, 118, 118),
			ImageTransparency = 0.97
		})
	})
end

return Dropshadow