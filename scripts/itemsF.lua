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
	print("first conditions met")

	local ptrHash = GetPtrHash(entity)
	local entityData = dataHolder.Data[ptrHash]
	if entityData == nil then
	return end
	print("entityData not nil")
	
	if entityData.touched then
	return end
	print("entityData.touched not true")
	
	dataHolder.Data[ptrHash].touched = true
	player:AddBrokenHearts(1)
end


local brokenHeartSprite = Sprite()
brokenHeartSprite:Load("gfx/ui/ui_hearts.anm2", true)
brokenHeartSprite:Play("BrokenHeart", true)
function itemsF:renderBrokenHeartsSprite()
	if not data.doInversion then
	return end
	--print("----------------")
	--print (data.doInversion)

	local roomDescData = level:GetCurrentRoomDesc().Data
	if roomDescData.Type ~= RoomType.ROOM_DEVIL or roomDescData.Subtype ~= data.roomIds.demonicAngelSubtypeId then
	return end
	--print("pre for loop")

	for i, entity in ipairs(Isaac.GetRoomEntities()) do
		local ptrHash = GetPtrHash(entity)
		local entityData = dataHolder.Data[ptrHash]

		print(entityData)
		if entityData ~= nil then
			--print("entityData not nil")

			local screenPosition = Isaac.WorldToScreen(entityData.position)
			screenPosition.Y = screenPosition.Y - 10

			brokenHeartSprite:Update()
			brokenHeartSprite:Render(screenPosition)

	end end
end


return itemsF
