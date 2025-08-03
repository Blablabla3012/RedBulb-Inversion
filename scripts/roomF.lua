local roomF = {}
local data = require("scripts.data")
local dataHolder = require("scripts.dataHolder")
local game = Game()
local level = game:GetLevel()


function roomF:swapRoomlayoutPools(index, dimension)
    if (index ~= GridRooms.ROOM_DEVIL_IDX and index ~= GridRooms.ROOM_ANGEL_SHOP_IDX) or not data.doInversion then
    return end

    local roomDesc = level:GetRoomByIdx(index, dimension)
    local newRoomData = nil
    local roomIds = data.roomIds

    if roomDesc.Data.Type == RoomType.ROOM_DEVIL then
        if roomDesc.Data.Subtype == 0 then
            newRoomData = RoomConfigHolder.GetRandomRoom(
                roomDesc.SpawnSeed, false, StbType.SPECIAL_ROOMS,
                RoomType.ROOM_ANGEL, RoomShape.ROOMSHAPE_1x1,
                roomIds.angelicDevilIdMin, roomIds.angelicDevilIdMax,
                0,10,0,
                roomIds.angelicDevilSubtypeId)
        elseif roomDesc.Data.Subtype == 1 then
            newRoomData = RoomConfigHolder.GetRandomRoom(
                roomDesc.SpawnSeed, false, StbType.SPECIAL_ROOMS,
                RoomType.ROOM_ANGEL, RoomShape.ROOMSHAPE_1x1,
                roomIds.angelicDevilNumberMagnetIdMin, roomIds.angelicDevilNumberMagnetIdMax,
                0,10,0,
                roomIds.angelicDevilNumberMagnetSubtypeId)
        elseif roomDesc.Data.Variant == 100 then
            newRoomData = RoomConfigHolder.GetRandomRoom(
                roomDesc.SpawnSeed, false, StbType.SPECIAL_ROOMS,
                RoomType.ROOM_ANGEL, RoomShape.ROOMSHAPE_1x1,
                roomIds.angelicDevilPortalId, roomIds.angelicDevilPortalId,
                0,10,0,
                roomIds.angelicDevilSubtypeId)
        end
    elseif roomDesc.Data.Type == RoomType.ROOM_ANGEL then
        if roomDesc.Data.Subtype == 0 then
            newRoomData = RoomConfigHolder.GetRandomRoom(
                roomDesc.SpawnSeed, false, StbType.SPECIAL_ROOMS,
                RoomType.ROOM_DEVIL, RoomShape.ROOMSHAPE_1x1,
                roomIds.demonicAngelIdMin, roomIds.demonicAngelIdMax,
                0,10,0,
                roomIds.demonicAngelSubtypeId)
        elseif roomDesc.Data.Subtype == 1 then
            newRoomData = RoomConfigHolder.GetRandomRoom(
                roomDesc.SpawnSeed, false, StbType.SPECIAL_ROOMS,
                RoomType.ROOM_DEVIL, RoomShape.ROOMSHAPE_1x1,
                roomIds.demonicAngelStairwayIdMin, roomIds.demonicAngelStairwayIdMax,
                0,10,0,
                roomIds.demonicAngelStairwaySubtypeId)
        elseif roomDesc.Data.Variant == 100 then
            newRoomData = RoomConfigHolder.GetRandomRoom(
                roomDesc.SpawnSeed, false, StbType.SPECIAL_ROOMS,
                RoomType.ROOM_DEVIL, RoomShape.ROOMSHAPE_1x1,
                roomIds.demonicAngelPortalId, roomIds.demonicAngelPortalId,
                0,10,0,
                roomIds.demonicAngelSubtypeId)
        end
    else return end

    roomDesc.Data = newRoomData or roomDesc.Data
end


function roomF:swapItemRoomPools(room, roomDesc)
    if not data.doInversion then
    return end

    if roomDesc.Data.Type == RoomType.ROOM_DEVIL then
        room:SetItemPool(ItemPoolType.POOL_ANGEL)
    elseif roomDesc.Data.Type == RoomType.ROOM_ANGEL then
        room:SetItemPool(ItemPoolType.POOL_DEVIL)
    end
end


function roomF:blockDemonicAngel(player, entity)
	if not data.doInversion or entity.Type ~= 5 or entity.Variant ~= 100 then
	return end

	local roomDescData = level:GetCurrentRoomDesc().Data
	if roomDescData.Type ~= RoomType.ROOM_ANGEL or roomDescData.Subtype ~= data.roomIds.angelicDevilSubtypeId then
	return end

	local ptrHash = GetPtrHash(entity)
	local entityData = dataHolder.Data[ptrHash]
	if entityData == nil then
	return end
	if not entityData.blockAngel then
	return end

	game:AddDevilRoomDeal()
end


return roomF
