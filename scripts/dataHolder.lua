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

	for i, entity in ipairs(Isaac.GetRoomEntities()) do
		if entity.Type == 5 and entity.Variant == 100 then
			GetEntityData(entity)
		
			local ptrHash = GetPtrHash(entity)
			dataHolder.Data[ptrHash].position = entity.Position
	end end
end

function dataHolder:GetEntityData_blockAngel()
	if not data.doInversion then
	return end

	local roomDescData = level:GetCurrentRoomDesc().Data
	--if roomDescData.Type ~= RoomType.ROOM_ANGEL or roomDescData.Subtype ~= data.rooms.angelicDevilSubtype then
	if not ((roomDescData.Type == data.rooms.angelicDevilType and roomDescData.Subtype == data.rooms.angelicDevilSubtype) or (roomDescData.Type == data.rooms.angelicDevilNumberMagnetType and roomDescData.Subtype == data.rooms.angelicDevilNumberMagnetSubtype)) then -- not ((angelicDevil) or (aDNumberMagnet))
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
