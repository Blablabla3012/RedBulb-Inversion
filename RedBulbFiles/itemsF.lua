local itemsF = {}
local data = require("RedBulbFiles.data")
local dataHolder = require("RedBulbFiles.dataHolder")
local level = Game():GetLevel()


function itemsF:devilFree(pickup, variant)
	if not data.doInversion then
	return end

	local roomDescData = level:GetCurrentRoomDesc().Data
	if roomDescData.Type ~= RoomType.ROOM_DEVIL or roomDescData.Subtype ~= data.roomIds.demonicAngelSubtypeId then
	return end

	if variant ~= 100 or not (pickup.Price < 0 and pickup.Price > -10) then
	return end


	dataHolder:GetEntityData(pickup)

	local price = pickup.Price
	local bHPrice = 1
	if price == -1 then
		bHPrice = 1
	elseif price == -2 then
		bHPrice = 2
	elseif price == -3 then
		bHPrice = 2
	elseif price == -4 then
		bHPrice = 2
	elseif price == -5 then --spikes -> "A pound of flesh" collectible
		bHPrice = 0
	elseif price == -6 then -- soul -> "your soul" trinket
		bHPrice = 0
	elseif price == -7 then
		bHPrice = 1
	elseif price == -8 then
		bHPrice = 2
	elseif price == -9 then
		bHPrice = 2
	end	

	local ptrHash = GetPtrHash(pickup)
	dataHolder.Data[ptrHash].brokenHeartsPrice = bHPrice
	pickup.Price = 0

	dataHolder.Data[ptrHash].position = pickup.Position
end


function itemsF:devilBrokenHearts(player, entity)
	if not data.doInversion or entity.Type ~= 5 or entity.Variant ~= 100 then
	return end

	local ptrHash = GetPtrHash(entity)
	local entityData = dataHolder.Data[ptrHash]
	if entityData == nil then
	return end
	
	--[[
	local pickup = entity:ToPickup()
	if pickup.Touched then	--always false for some reason -> making own touched variable via dataHolder
	return end
	]]
	
	if entityData.touched then
	return end
	
	dataHolder.Data[ptrHash].touched = true
	player:AddBrokenHearts(entityData.brokenHeartsPrice)
end


local brokenHeartSprite = Sprite()
brokenHeartSprite:Load("gfx/ui/ui_hearts.anm2", true)
brokenHeartSprite:Play("BrokenHeart", true)
function itemsF:renderBrokenHeartsSprite()
	if not data.doInversion then
	return end
	print("----------------")
	print (data.doInversion)

	local roomDescData = level:GetCurrentRoomDesc().Data
	if roomDescData.Type ~= RoomType.ROOM_DEVIL or roomDescData.Subtype ~= data.roomIds.demonicAngelSubtypeId then
	return end
	print("pre for loop")

	for i, entity in ipairs(Isaac.GetRoomEntities()) do
		local ptrHash = GetPtrHash(entity)
		local entityData = dataHolder.Data[ptrHash]

		print(entityData)
		if entityData ~= nil then
			print("entityData not nil")

			local screenPosition = Isaac.WorldToScreen(entityData.position)
			screenPosition.Y = screenPosition.Y - 10

			brokenHeartSprite:Update()
			brokenHeartSprite:Render(screenPosition)

	end end
end

--[[ For discord?:
i have this code for rendering a broken heart for items in specific rooms similar to the hearts befre devil deals. 
```
local brokenHeartSprite = Sprite()
brokenHeartSprite:Load("gfx/ui/ui_hearts.anm2", true)
brokenHeartSprite:Play("BrokenHeart", true)
function itemsF:renderBrokenHeartsSprite()
    if not data.doInversion then
    return end
    print("----------------")
    print (data.doInversion)

    local roomDescData = level:GetCurrentRoomDesc().Data
    if roomDescData.Type ~= RoomType.ROOM_DEVIL or roomDescData.Subtype ~= data.roomIds.                    demonicAngelSubtypeId then
    return end
    print("pre for loop")

    for i, entity in ipairs(Isaac.GetRoomEntities()) do
        local ptrHash = GetPtrHash(entity)
        local entityData = dataHolder.Data[ptrHash]

        if entityData ~= nil then
            print("entityData not nil")

            local screenPosition = Isaac.WorldToScreen(entityData.position)
            screenPosition.Y = screenPosition.Y - 10

            brokenHeartSprite:Update()
            brokenHeartSprite:Render(screenPosition)

    end end
end
rbMod:AddCallback(ModCallbacks.MC_POST_RENDER, itemsF.renderBrokenHeartsSprite)
```
but for some reason entityData (line 16) becomes nil after leaving and reentering the room.
--]]

return itemsF
