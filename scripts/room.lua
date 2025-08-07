local room = {}
local data = require("scripts.data")
local dataHolder = require("scripts.dataHolder")
local game = Game()
local level = game:GetLevel()


function room:swapRoomlayoutPools(index, dimension)
    if (index ~= GridRooms.ROOM_DEVIL_IDX and index ~= GridRooms.ROOM_ANGEL_SHOP_IDX) or not data.doInversion then
    return end

    local roomDesc = level:GetRoomByIdx(index, dimension)
    local newRoomData = nil
    local rooms = data.rooms

    if roomDesc.Data.Type == RoomType.ROOM_DEVIL then
        if roomDesc.Data.Subtype == 0 then
            newRoomData = RoomConfigHolder.GetRandomRoom(
                roomDesc.SpawnSeed, false, StbType.SPECIAL_ROOMS,
                rooms.angelicDevilType, RoomShape.ROOMSHAPE_1x1,
                rooms.angelicDevilVarMin, rooms.angelicDevilVarMax,
                0,10,0,
                rooms.angelicDevilSubtype)
        elseif roomDesc.Data.Subtype == 1 then
            newRoomData = RoomConfigHolder.GetRandomRoom(
                roomDesc.SpawnSeed, false, StbType.SPECIAL_ROOMS,
                rooms.angelicDevilNumberMagnetType, RoomShape.ROOMSHAPE_1x1,
                rooms.angelicDevilNumberMagnetVarMin, rooms.angelicDevilNumberMagnetVarMax,
                0,10,0,
                rooms.angelicDevilNumberMagnetSubtype)
        elseif roomDesc.Data.Variant == 100 then
            newRoomData = RoomConfigHolder.GetRandomRoom(
                roomDesc.SpawnSeed, false, StbType.SPECIAL_ROOMS,
                rooms.angelicDevilPortalType, RoomShape.ROOMSHAPE_1x1,
                rooms.angelicDevilPortal, rooms.angelicDevilPortal,
                0,10,0,
                rooms.angelicDevilSubtype)
        end
    elseif roomDesc.Data.Type == RoomType.ROOM_ANGEL then
        if roomDesc.Data.Subtype == 0 then
            newRoomData = RoomConfigHolder.GetRandomRoom(
                roomDesc.SpawnSeed, false, StbType.SPECIAL_ROOMS,
                rooms.demonicAngelType, RoomShape.ROOMSHAPE_1x1,
                rooms.demonicAngelVarMin, rooms.demonicAngelVarMax,
                0,10,0,
                rooms.demonicAngelSubtype)
        elseif roomDesc.Data.Subtype == 1 then
            newRoomData = RoomConfigHolder.GetRandomRoom(
                roomDesc.SpawnSeed, false, StbType.SPECIAL_ROOMS,
                rooms.demonicAngelStairwayType, RoomShape.ROOMSHAPE_1x1,
                rooms.demonicAngelStairwayVarMin, rooms.demonicAngelStairwayVarMax,
                0,10,0,
                rooms.demonicAngelStairwaySubtype)
        elseif roomDesc.Data.Variant == 100 then
            newRoomData = RoomConfigHolder.GetRandomRoom(
                roomDesc.SpawnSeed, false, StbType.SPECIAL_ROOMS,
                rooms.demonicAngelPortalType, RoomShape.ROOMSHAPE_1x1,
                rooms.demonicAngelPortal, rooms.demonicAngelPortal,
                0,10,0,
                rooms.demonicAngelSubtype)
        end
    else return end

    roomDesc.Data = newRoomData or roomDesc.Data
end


function room:swapItemRoomPools(room, roomDesc)
    if not data.doInversion then
    return end
	local rooms = data.rooms

    if roomDesc.Data.Type == rooms.demonicAngelType and roomDesc.Data.Subtype == rooms.demonicAngelSubtype then
        room:SetItemPool(ItemPoolType.POOL_ANGEL)
	elseif roomDesc.Data.Type == rooms.demonicAngelStairwayType and roomDesc.Data.Subtype == rooms.demonicAngelStairwaySubtype then
        room:SetItemPool(ItemPoolType.POOL_ANGEL)
	elseif roomDesc.Data.Type == rooms.angelicDevilType and roomDesc.Data.Subtype == rooms.angelicDevilSubtype then
        room:SetItemPool(ItemPoolType.POOL_DEVIL)
	elseif roomDesc.Data.Type == rooms.angelicDevilNumberMagnetType and roomDesc.Data.Subtype == rooms.angelicDevilNumberMagnetSubtype then
        room:SetItemPool(ItemPoolType.POOL_DEVIL)
    end
end


function room:blockDemonicAngel(player, entity)
	if not data.doInversion or entity.Type ~= 5 or entity.Variant ~= 100 then
	return end

	local ptrHash = GetPtrHash(entity)
	local entityData = dataHolder.Data[ptrHash]
	if entityData == nil then
	return end
	if not entityData.blockAngel then
	return end

	game:AddDevilRoomDeal()
end


return room
