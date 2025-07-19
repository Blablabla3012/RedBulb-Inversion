--https://isaacblueprints.com/tutorials/concepts/entity_data/

local dataHolder = {}
dataHolder.Data = {}


function dataHolder:GetEntityData(entity)
	local ptrHash = GetPtrHash(entity)
	if not dataHolder.Data[ptrHash] then
		dataHolder.Data[ptrHash] = {}
		local entityData = dataHolder.Data[ptrHash]

		entityData.Pointer = EntityPtr(entity)
		entityData.brokenHeartsPrice = 1
		entityData.touched = false
		entityData.position = nil
	end

	return dataHolder.Data[ptrHash]
end


function dataHolder:ClearDataOfEntity(entity)
	local ptrHash = GetPtrHash(entity)
	dataHolder.Data[ptrHash] = nil
end


return dataHolder
