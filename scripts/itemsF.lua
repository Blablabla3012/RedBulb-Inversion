local itemsF = {}
local data = require("scripts.data")
local dataHolder = require("scripts.dataHolder")
local level = Game():GetLevel()


function itemsF:devilFree(pickup, variant)
	if not data.doInversion then
	return end

	local roomDescData = level:GetCurrentRoomDesc().Data
	if roomDescData.Type ~= RoomType.ROOM_DEVIL or roomDescData.Subtype ~= data.roomIds.demonicAngelSubtypeId then
	return end

	if variant ~= 100 or not (pickup.Price < 0 and pickup.Price > -10) then
	return end

	pickup.Price = 0
end


function itemsF:devilBrokenHearts(player, entity)
	if not data.doInversion or entity.Type ~= 5 or entity.Variant ~= 100 then
	return end

	local ptrHash = GetPtrHash(entity)
	local entityData = dataHolder.Data[ptrHash]
	if entityData == nil then
	return end
	
	if entityData.touched then
	return end
	
	dataHolder.Data[ptrHash].touched = true
	player:AddBrokenHearts(1)
end


local brokenHeartSprite = Sprite()
brokenHeartSprite:Load("gfx/ui/ui_hearts.anm2", true)
brokenHeartSprite:Play("BrokenHeart", true)
function itemsF:renderBrokenHeartsSprite()
	if not data.doInversion then
	return end

	local roomDescData = level:GetCurrentRoomDesc().Data
	if roomDescData.Type ~= RoomType.ROOM_DEVIL or roomDescData.Subtype ~= data.roomIds.demonicAngelSubtypeId then
	return end

	for i, entity in ipairs(Isaac.GetRoomEntities()) do
		local ptrHash = GetPtrHash(entity)
		local entityData = dataHolder.Data[ptrHash]

		if entityData ~= nil then
			if entityData.touched == false then

				local screenPosition = Isaac.WorldToScreen(entityData.position)
				local offset = {}
				offset.Y = -10
				offset.X = 3
				screenPosition.Y = screenPosition.Y + offset.Y
				screenPosition.X = screenPosition.X + offset.X

				brokenHeartSprite:Update()
				brokenHeartSprite:Render(screenPosition)

	end end end
end


return itemsF
