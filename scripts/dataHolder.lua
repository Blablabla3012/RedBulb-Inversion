--https://isaacblueprints.com/tutorials/concepts/entity_data/

local dataHolder = {}
dataHolder.Data = {}

local data = require("scripts.data")
local level = Game():GetLevel()


function dataHolder:GetEntityData(entity)
	local ptrHash = GetPtrHash(entity)
	if not dataHolder.Data[ptrHash] then
		dataHolder.Data[ptrHash] = {}
		local entityData = dataHolder.Data[ptrHash]

		entityData.Pointer = EntityPtr(entity)
		entityData.touched = false
		entityData.position = nil
	end

	return dataHolder.Data[ptrHash]
end

function dataHolder:GetRightEntityData()
	if not data.doInversion then
	return end

	local roomDescData = level:GetCurrentRoomDesc().Data
	if roomDescData.Type ~= RoomType.ROOM_DEVIL or roomDescData.Subtype ~= data.roomIds.demonicAngelSubtypeId then
	return end

	for i, entity in ipairs(Isaac.GetRoomEntities()) do
		if entity.Type == 5 and entity.Variant == 100 then
			dataHolder:GetEntityData(entity)
		
			local ptrHash = GetPtrHash(entity)
			dataHolder.Data[ptrHash].position = entity.Position
	end end
end


function dataHolder:ClearDataOfEntity(entity)
	local ptrHash = GetPtrHash(entity)
	dataHolder.Data[ptrHash] = nil
end

return dataHolder
