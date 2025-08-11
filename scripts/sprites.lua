local metaSprites = {}
local data = require("scripts.data")
local game = Game()
local level = game:GetLevel()


local function getNeededEntities(room)
	local entities = {}
	entities.rocks = {}
	entities.devilStatuesEffects = {}
	entities.angelStatuesEffects = {}

	--[[ FUCK YOU STATUES!!!! ]]--
	local roomEntities = Isaac.GetRoomEntities()
	for _, entity in ipairs(roomEntities) do
		if entity.Type == EntityType.ENTITY_EFFECT then
			local gridEntity = room:GetGridEntityFromPos(entity.Position)
			if gridEntity ~= nil then
				local gridEntityDesc = gridEntity:GetSaveState()	
				if gridEntityDesc.Type == GridEntityType.GRID_STATUE then
					if gridEntityDesc.Variant == 0 then -- 0 == devil
						entities.devilStatuesEffects[#entities.devilStatuesEffects +1] = entity
					elseif gridEntityDesc.Variant == 1 then -- 1 == angel
						entities.angelStatuesEffects[#entities.angelStatuesEffects +1] = entity
	end end end end end

	for index = 0, 134, 1 do -- grid index of 1x1 room: min == 0, max == 134
		local gridEntity = room:GetGridEntity(index)
		if gridEntity ~= nil then
			local sprite = gridEntity:GetSprite()
			if sprite:GetFilename() == "gfx/grid/grid_rock.anm2" then
				entities.rocks[#entities.rocks + 1] = gridEntity
			end
	end end


	return entities
end


function metaSprites:checkRoom()
	if not data.doInversion then
	return end

	local roomDesc = level:GetCurrentRoomDesc()

	--[[ ANGELIC DEVIL ]]--
	if roomDesc.Data.Type == data.rooms.angelicDevilPortalType and roomDesc.Data.Subtype == data.rooms.angelicDevilPortalSubtype and roomDesc.Data.Variant == data.rooms.angelicDevilPortalVar then
		local entities = getNeededEntities(level:GetCurrentRoom())
		for _, entity in ipairs(entities.rocks) do
			local sprite = entity:GetSprite()
			sprite:ReplaceSpritesheet(0, "gfx/grid/rocks_angelicDevil.png", true)
		end
		for _, entity in ipairs(entities.devilStatuesEffects) do
			local sprite = entity:GetSprite()
			sprite:ReplaceSpritesheet(0, "gfx/statues/angelicDevilStatue.png" ,true)
		end

	elseif roomDesc.Data.Type == data.rooms.angelicDevilType and 
		roomDesc.Data.Subtype == data.rooms.angelicDevilSubtype then
		local entities = getNeededEntities(level:GetCurrentRoom())
		for _, entity in ipairs(entities.rocks) do
			local sprite = entity:GetSprite()
			sprite:ReplaceSpritesheet(0, "gfx/grid/rocks_angelicDevil.png", true)
		end
		for _, entity in ipairs(entities.devilStatuesEffects) do
			local sprite = entity:GetSprite()
			sprite:ReplaceSpritesheet(0, "gfx/statues/angelicDevilStatue.png" ,true)
		end

	elseif roomDesc.Data.Type == data.rooms.angelicDevilNumberMagnetType and roomDesc.Data.Subtype == data.rooms.angelicDevilNumberMagnetSubtype then
		local entities = getNeededEntities(level:GetCurrentRoom())
		for _, entity in ipairs(entities.rocks) do
			local sprite = entity:GetSprite()
			sprite:ReplaceSpritesheet(0, "gfx/grid/rocks_angelicDevil.png", true)
		end
		for _, entity in ipairs(entities.devilStatuesEffects) do
			local sprite = entity:GetSprite()
			sprite:ReplaceSpritesheet(0, "gfx/statues/angelicDevilStatue.png" ,true)
		end


	--[[ DEMONIC ANGEL ]]--
	elseif roomDesc.Data.Type == data.rooms.demonicAngelPortalType and roomDesc.Data.Subtype == data.rooms.demonicAngelPortalSubtype and roomDesc.Data.Variant == data.rooms.demonicAngelPortalVar then
		local entities = getNeededEntities(level:GetCurrentRoom())
		for _, entity in ipairs(entities.rocks) do
			local sprite = entity:GetSprite()
			sprite:ReplaceSpritesheet(0, "gfx/grid/rocks_angelicDevil.png", true)
		end
		for _, entity in ipairs(entities.angelStatuesEffects) do
			local sprite = entity:GetSprite()
			sprite:ReplaceSpritesheet(0, "gfx/statues/demonicAngelStatue.png" ,true)
		end

	elseif roomDesc.Data.Type == data.rooms.demonicAngelType and 
		roomDesc.Data.Subtype == data.rooms.demonicAngelSubtype then
		local entities = getNeededEntities(level:GetCurrentRoom())
		for _, entity in ipairs(entities.rocks) do
			local sprite = entity:GetSprite()
			sprite:ReplaceSpritesheet(0, "gfx/grid/rocks_angelicDevil.png", true)
		end
		for _, entity in ipairs(entities.angelStatuesEffects) do
			local sprite = entity:GetSprite()
			sprite:ReplaceSpritesheet(0, "gfx/statues/demonicAngelStatue.png" ,true)
		end

	elseif roomDesc.Data.Type == data.rooms.demonicAngelStairwayType and roomDesc.Data.Subtype == data.rooms.demonicAngelStairwaySubtype then
		local entities = getNeededEntities(level:GetCurrentRoom())
		for _, entity in ipairs(entities.rocks) do
			local sprite = entity:GetSprite()
			sprite:ReplaceSpritesheet(0, "gfx/grid/rocks_angelicDevil.png", true)
		end
		for _, entity in ipairs(entities.angelStatuesEffects) do
			local sprite = entity:GetSprite()
			sprite:ReplaceSpritesheet(0, "gfx/statues/demonicAngelStatue.png" ,true)
		end
	end
end


return metaSprites
