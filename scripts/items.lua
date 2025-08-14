local items = {}
local data = require("scripts.data")
local dataHolder = require("scripts.dataHolder")
local game = Game()
local level = game:GetLevel()


function items:demonicAngelNoRedHearts(pickup, variant)
	if not data.doInversion then
	return end

	local roomDescData = level:GetCurrentRoomDesc().Data
	if roomDescData.Type ~= data.rooms.demonicAngelType or roomDescData.Subtype ~= data.rooms.demonicAngelSubtype then
	return end

	if variant ~= 100 or not (pickup.Price < 0 and pickup.Price > -10) then
	return end

	pickup.Price = 0
end


function items:demonicAngelBrokenHearts(player, entity)
	if not data.doInversion or entity.Type ~= 5 or entity.Variant ~= 100 then
	return end

	local ptrHash = GetPtrHash(entity)
	local entityData = dataHolder.Data[ptrHash]
	if entityData == nil then
	return end
	if entityData.blockAngel then
	return end
	
	if entityData.touched then
	return end
	
	dataHolder.Data[ptrHash].touched = true
	player:AddBrokenHearts(entityData.brokenHearts)
end


local brokenHeartSprite = Sprite()
brokenHeartSprite:Load("gfx/ui/ui_hearts.anm2", true)
brokenHeartSprite:Play("BrokenHeart", true)
function items:renderBrokenHeartsSprite()
	if not data.doInversion then
	return end

	local roomDescData = level:GetCurrentRoomDesc().Data
	if roomDescData.Type ~= data.rooms.demonicAngelType or roomDescData.Subtype ~= data.rooms.demonicAngelSubtype then
	return end

	for i, entity in ipairs(Isaac.GetRoomEntities()) do
		local ptrHash = GetPtrHash(entity)
		local entityData = dataHolder.Data[ptrHash]

		if entityData ~= nil then
			if entityData.touched == false then

				local screenPos = Isaac.WorldToScreen(entityData.position)
				local offset = {}
				offset.Y = -10
				offset.X = 3
				screenPos.Y = screenPos.Y + offset.Y
				screenPos.X = screenPos.X + offset.X

				brokenHeartSprite:Update()
				brokenHeartSprite:Render(screenPos)

				if entityData.brokenHearts == 2 then
					local secPos = screenPos
					local secOffset = {}
					secOffset.Y = 5
					secOffset.X = 3
					secPos.Y = secPos.Y + secOffset.Y
					secPos.X = secPos.X + secOffset.X

					brokenHeartSprite:Render(secPos)
				end
	end end end
end


function items:spawnKeyPieces(npcEntity)
	if not data.doInversion then
	return end

	local roomDesc = level:GetCurrentRoomDesc()
	if roomDesc.GridIndex ~= GridRooms.ROOM_DEVIL_IDX then
	return end
	if roomDesc.Data.Type ~= data.rooms.demonicAngelType or roomDesc.Data.Subtype ~= data.rooms.demonicAngelSubtype then
	return end
	if roomDesc.Data.Type == data.rooms.demonicAngelPortalType and roomDesc.Data.Subtype == data.rooms.demonicAngelPortalSubtype and roomDesc.Data.Variant == data.rooms.demonicAngelPortalVar then
	return end

	local hasKey1 = PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_1)
	local hasKey2 = PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_2)
	local hasFeather = PlayerManager.AnyoneHasTrinket(TrinketType.TRINKET_FILIGREE_FEATHERS)
	
	if hasFeather and (hasKey1 == hasKey2) then
		local itemPool = game:GetItemPool()
		local collectible = itemPool:GetCollectible(ItemPoolType.POOL_ANGEL, true --[[decrease]], npcEntity:GetDropRNG():GetSeed())
		game:Spawn(EntityType.ENTITY_PICKUP, 100 --[[Variant]], npcEntity.Position, Vector(0,0) --[[Velocity]], nil --[[parent]], collectible, game:GetRoom():GetSpawnSeed())
	else
		if hasKey1 and hasKey2 then
		return end

		if hasKey1 then
			game:Spawn(EntityType.ENTITY_PICKUP, 100 --[[Variant]], npcEntity.Position, Vector(0,0) --[[Velocity]], nil --[[parent]], CollectibleType.COLLECTIBLE_KEY_PIECE_2, game:GetRoom():GetSpawnSeed())
		elseif hasKey2 then
			game:Spawn(EntityType.ENTITY_PICKUP, 100 --[[Variant]], npcEntity.Position, Vector(0,0) --[[Velocity]], nil --[[parent]], CollectibleType.COLLECTIBLE_KEY_PIECE_1, game:GetRoom():GetSpawnSeed())
		else
			rng = npcEntity:GetDropRNG()
			if rng:RandomInt(2) == 0 then -- output is 0 and 1
				game:Spawn(EntityType.ENTITY_PICKUP, 100 --[[Variant]], npcEntity.Position, Vector(0,0) --[[Velocity]], nil --[[parent]], CollectibleType.COLLECTIBLE_KEY_PIECE_1, game:GetRoom():GetSpawnSeed())
			else
				game:Spawn(EntityType.ENTITY_PICKUP, 100 --[[Variant]], npcEntity.Position, Vector(0,0) --[[Velocity]], nil --[[parent]], CollectibleType.COLLECTIBLE_KEY_PIECE_2, game:GetRoom():GetSpawnSeed())
			end
		end
	end
end


return items
