local Node = {}

local HttpService = game:GetService("HttpService")
Node.__index = Node

function Node:create(dataTbl, Type, parentNode, Id)
	local newNode = {}

	newNode.Id = Id or HttpService:GenerateGUID()
	newNode.Data = dataTbl or {}
	newNode.type =  Type or "Node"
	newNode.Parent = parentNode or "Root"

	setmetatable(newNode, Node)
	return newNode
end


function Node:Get(IndexRef)
	return self.Data[IndexRef]
end

function Node:Set(IndexRef, Value)
	if Value == nil then return "value can not be nil" end
	self.Data[IndexRef] = Value
end

function Node:UpdateParent(newParent)
	self.Parent = newParent
end

function Node:GetDataRef()
	return self.Data
end

function Node:AddChild(dataTbl, Type, Id)
	local newNode = Node:create(dataTbl, Type, self, Id)
	self.Data[newNode] = newNode
	return newNode
end

function Node:isDataEmpty()
	for _, Data in pairs(self.Data) do
		if Data == nil then continue end
		return false
	end
	return true
end

local function isFolderEmpty(self)
	local Parent = nil
	if self.Parent ~= "Root" then
		Parent = self.Parent
		Parent:DeleteData(self)
		if not Parent:isDataEmpty() then return end
		isFolderEmpty(Parent)
	else
		Parent = self
		if not Parent:isDataEmpty() then return end
	end
end

function Node:DeleteData(IndexRef)
	self.Data[IndexRef] = nil

	if not self:isDataEmpty() then return end

	isFolderEmpty(self)
end

return Node