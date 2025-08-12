local metaSprites = {}
local data = require("scripts.data")
local game = Game()
local level = game:GetLevel()


local currentRoom = nil
function metaSprites:checkRoom(_, roomDesc)
	if not data.doInversion then 
	return end

	if roomDesc.GridIndex ~= GridRooms.ROOM_DEVIL_IDX and roomDesc.GridIndex ~= GridRooms.ROOM_ANGEL_SHOP_IDX then
		currentRoom = nil
	return end
	
	--[[ DEMONIC ANGEL ]]--
	if roomDesc.Data.Type == data.rooms.demonicAngelPortalType and roomDesc.Data.Subtype == data.rooms.demonicAngelPortalSubtype and roomDesc.Data.Variant == data.rooms.demonicAngelPortalVar then
		currentRoom = "demonicAngelPortal"
	elseif roomDesc.Data.Type == data.rooms.demonicAngelType and roomDesc.Data.Subtype == data.rooms.demonicAngelSubtype then
		currentRoom = "demonicAngel"
	elseif roomDesc.Data.Type == data.rooms.demonicAngelStairwayType and roomDesc.Data.Subtype == data.rooms.demonicAngelStairwaySubtype then
		currentRoom = "demonicAngelStairway"

	--[[ ANGELIC DEVIL ]]--
	elseif roomDesc.Data.Type == data.rooms.angelicDevilPortalType and roomDesc.Data.Subtype == data.rooms.angelicDevilPortalSubtype and roomDesc.Data.Variant == data.rooms.angelicDevilPortalVar then
		currentRoom = "angelicDevilPortal"
	elseif roomDesc.Data.Type == data.rooms.angelicDevilType and roomDesc.Data.Subtype == data.rooms.angelicDevilSubtype then
		currentRoom = "angelicDevil"
	elseif roomDesc.Data.Type == data.rooms.angelicDevilNumberMagnetType and roomDesc.Data.Subtype == data.rooms.angelicDevilNumberMagnetSubtype then
		currentRoom = "angelicDevilNumberMagnet"
	else currentRoom = nil
    end
end

function metaSprites:changeBackdrop()
	if not data.doInversion then
	return end

	--[[ ANGELIC DEVIL ]]--
	if currentRoom == "demonicAngelPortal" then
		return data.backdrops.demonicAngel
	elseif currentRoom == "demonicAngel" then
		return data.backdrops.demonicAngel
	elseif currentRoom == "demonicAngelStairway" then
		return data.backdrops.demonicAngelStairway

	--[[ DEMONIC ANGEL ]]--
	elseif currentRoom == "angelicDevilPortal" then
		return data.backdrops.angelicDevil
	elseif currentRoom == "angelicDevil" then
		return data.backdrops.angelicDevil
	elseif currentRoom == "angelicDevilNumberMagnet" then
		return data.backdrops.angelicDevil
	end
end


local function getStatueEffects(room)
	local statueEffects = {}
	statueEffects.devil = {}
	statueEffects.angel = {}

	local roomEntities = Isaac.GetRoomEntities()
	for _, entity in ipairs(roomEntities) do
		if entity.Type == EntityType.ENTITY_EFFECT then
			local gridEntity = room:GetGridEntityFromPos(entity.Position)
			if gridEntity ~= nil then
				local gridEntityDesc = gridEntity:GetSaveState()	
				if gridEntityDesc.Type == GridEntityType.GRID_STATUE then
					if gridEntityDesc.Variant == 0 then -- 0 == devil
						statueEffects.devil[#statueEffects.devil +1] = entity
					elseif gridEntityDesc.Variant == 1 then -- 1 == angel
						statueEffects.angel[#statueEffects.angel +1] = entity
	end end end end end

	return statueEffects
end

function metaSprites:changeStatues()
	if not data.doInversion then
	return end

	local roomDesc = level:GetCurrentRoomDesc()
	if roomDesc.GridIndex ~= GridRooms.ROOM_DEVIL_IDX and roomDesc.GridIndex ~= GridRooms.ROOM_ANGEL_SHOP_IDX then
	return end
	
	local room = level:GetCurrentRoom()
	local pathStatueDemonicAngel = "gfx/statues/demonicAngelStatue.png"
	local pathStatueAngelicDevil = "gfx/statues/angelicDevilStatue.png"


	--[[ DEMONIC ANGEL ]]--
	if roomDesc.Data.Type == data.rooms.demonicAngelPortalType and roomDesc.Data.Subtype == data.rooms.demonicAngelPortalSubtype and roomDesc.Data.Variant == data.rooms.demonicAngelPortalVar then
		local statueEffects = getStatueEffects(room)
		for _, effect in ipairs(statueEffects.angel) do
			local sprite = effect:GetSprite()
			sprite:ReplaceSpritesheet(0, pathStatueDemonicAngel, true)
		end
	
	elseif roomDesc.Data.Type == data.rooms.demonicAngelType and roomDesc.Data.Subtype == data.rooms.demonicAngelSubtype then
		local statueEffects = getStatueEffects(room)
		for _, effect in ipairs(statueEffects.angel) do
			local sprite = effect:GetSprite()
			sprite:ReplaceSpritesheet(0, pathStatueDemonicAngel, true)
		end
	
	elseif roomDesc.Data.Type == data.rooms.demonicAngelStairwayType and roomDesc.Data.Subtype == data.rooms.demonicAngelStairwaySubtype then
		local statueEffects = getStatueEffects(room)
		for _, effect in ipairs(statueEffects.angel) do
			local sprite = effect:GetSprite()
			sprite:ReplaceSpritesheet(0, pathStatueDemonicAngel, true)
		end


	--[[ ANGELIC DEVIL ]]--
	elseif roomDesc.Data.Type == data.rooms.angelicDevilPortalType and roomDesc.Data.Subtype == data.rooms.angelicDevilPortalSubtype and roomDesc.Data.Variant == data.rooms.angelicDevilPortalVar then
		local statueEffects = getStatueEffects(room)
		for _, effect in ipairs(statueEffects.devil) do
			local sprite = effect:GetSprite()
			sprite:ReplaceSpritesheet(0, pathStatueAngelicDevil, true)
		end
	
	elseif roomDesc.Data.Type == data.rooms.angelicDevilType and roomDesc.Data.Subtype == data.rooms.angelicDevilSubtype then
		local statueEffects = getStatueEffects(room)
		for _, effect in ipairs(statueEffects.devil) do
			local sprite = effect:GetSprite()
			sprite:ReplaceSpritesheet(0, pathStatueAngelicDevil, true)
		end
	
	elseif roomDesc.Data.Type == data.rooms.angelicDevilNumberMagnetType and roomDesc.Data.Subtype == data.rooms.angelicDevilNumberMagnetSubtype then
		local statueEffects = getStatueEffects(room)
		for _, effect in ipairs(statueEffects.devil) do
			local sprite = effect:GetSprite()
			sprite:ReplaceSpritesheet(0, pathStatueAngelicDevil, true)
		end
	
    end
end


return metaSprites
