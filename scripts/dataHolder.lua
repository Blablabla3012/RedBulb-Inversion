--https://isaacblueprints.com/tutorials/concepts/entity_data/

local dataHolder = {}
dataHolder.Data = {}

local data = require("scripts.data")
local level = Game():GetLevel()


local function GetEntityData(entity)
	local ptrHash = GetPtrHash(entity)
	if not dataHolder.Data[ptrHash] then
		dataHolder.Data[ptrHash] = {}
		local entityData = dataHolder.Data[ptrHash]

		entityData.Pointer = EntityPtr(entity)
		entityData.touched = false
		entityData.position = nil
		entityData.brokenHearts = nil
		entityData.blockAngel = false
	end

	return dataHolder.Data[ptrHash]
end

function dataHolder:GetEntityData_demonicAngel()
	if not data.doInversion then
	return end

	local roomDescData = level:GetCurrentRoomDesc().Data
	if roomDescData.Type ~= data.rooms.demonicAngelType or roomDescData.Subtype ~= data.rooms.demonicAngelSubtype then
	return end

	for _, entity in ipairs(Isaac.GetRoomEntities()) do
		if entity.Type == 5 and entity.Variant == 100 then
			GetEntityData(entity)
		
			local ptrHash = GetPtrHash(entity)
			dataHolder.Data[ptrHash].position = entity.Position

			local itemConfig = Isaac.GetItemConfig()
			local itemConfig_Item = itemConfig:GetCollectible(entity.SubType)
			if itemConfig_Item.Quality >= 3 then
				dataHolder.Data[ptrHash].brokenHearts = 2
			else
				dataHolder.Data[ptrHash].brokenHearts = 1
			end
	end end
end

function dataHolder:GetEntityData_blockAngel()
	if not data.doInversion then
	return end

	local roomDesc = level:GetCurrentRoomDesc()
	if roomDesc.GridIndex ~= GridRooms.ROOM_DEVIL_IDX then
	return end
	if roomDesc.Data.Type == data.rooms.angelicDevilPortalType and roomDesc.Data.Variant == data.rooms.angelicDevilPortalVar then
	return end

	if not ((roomDesc.Data.Type == data.rooms.angelicDevilType and roomDesc.Data.Subtype == data.rooms.angelicDevilSubtype) or (roomDesc.Data.Type == data.rooms.angelicDevilNumberMagnetType and roomDesc.Data.Subtype == data.rooms.angelicDevilNumberMagnetSubtype)) then
	return end

	for i, entity in ipairs(Isaac.GetRoomEntities()) do
		if entity.Type == 5 and entity.Variant == 100 then
			GetEntityData(entity)
		
			local ptrHash = GetPtrHash(entity)
			dataHolder.Data[ptrHash].blockAngel = true
	end end
end


function dataHolder:ClearDataOfEntity(entity)
	local ptrHash = GetPtrHash(entity)
	dataHolder.Data[ptrHash] = nil
end

return dataHolder
