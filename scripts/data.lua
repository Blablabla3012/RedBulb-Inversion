local data = {}
data.functions = {}
data.redBulb = Isaac.GetItemIdByName("Red Bulb")


data.doInversion = nil
function data.functions:checkForRedBulb()
    local numRb = PlayerManager.GetNumCollectibles(data.redBulb)

    data.doInversion = false
    if numRb%2 == 0 or numRb == 0 then
        data.doInversion = false
    else
        data.doInversion = true
    end
end


data.roomIds = {}
data.roomIds.angelicDevilIdMin = nil
data.roomIds.angelicDevilIdMax = nil
data.roomIds.angelicDevilSubtypeId = nil
data.roomIds.angelicDevilNumberMagnetIdMin = nil
data.roomIds.angelicDevilNumberMagnetIdMax = nil
data.roomIds.angelicDevilNumberMagnetSubtypeId = nil
data.roomIds.angelicDevilPortalId = nil
data.roomIds.demonicAngelIdMin = nil
data.roomIds.demonicAngelIdMax = nil
data.roomIds.demonicAngelSubtypeId = nil
data.roomIds.demonicAngelStairwayIdMin = nil
data.roomIds.demonicAngelStairwayIdMax = nil
data.roomIds.demonicAngelStairwaySubtypeId = nil
data.roomIds.demonicAngelPortalId = nil

function data.functions:GetCustomRoomTypeIds()
	local isGreedMode = 0
    if Game():IsGreedMode() then
    	isGreedMode = 1
    end

    local roomConfigSet = RoomConfig.GetStage(StbType.SPECIAL_ROOMS):GetRoomSet(isGreedMode)    -- 0 = not greed; 1 = greed

    for i = 0, roomConfigSet.Size - 1, 1 do
        local roomConfig = roomConfigSet:Get(i)
        local roomType = roomConfig.Type

        if roomType == RoomType.ROOM_DEVIL or roomType == RoomType.ROOM_ANGEL then

            local roomName = roomConfig.Name
            local roomVariant = roomConfig.Variant
            local roomSubtype = roomConfig.Subtype

            if roomType == RoomType.ROOM_ANGEL then
                if roomName == "Angelic Devil (s)" then
                    data.roomIds.angelicDevilIdMin = roomVariant
                elseif roomName == "Angelic Devil (copy) (e)" then
                    data.roomIds.angelicDevilIdMax = roomVariant
                    data.roomIds.angelicDevilSubtypeId = roomSubtype
                elseif roomName == "Angelic Devil (6 Room) (s)" then
                    data.roomIds.angelicDevilNumberMagnetIdMin = roomVariant
                elseif roomName == "Angelic Devil (6 Room) (copy) (e)" then
                    data.roomIds.angelicDevilNumberMagnetIdMax = roomVariant
                    data.roomIds.angelicDevilNumberMagnetSubtypeId = roomSubtype
                elseif roomName == "Angelic Devil (portal)" then
                    data.roomIds.angelicDevilPortalId = roomVariant
                end
            elseif roomType == RoomType.ROOM_DEVIL then
                if roomName == "Demonic Angel (shop) (s)" then
                    data.roomIds.demonicAngelIdMin = roomVariant
                elseif roomName == "Demonic Angel (shop) (copy) (e)" then
                    data.roomIds.demonicAngelIdMax = roomVariant
                    data.roomIds.demonicAngelSubtypeId = roomSubtype
                elseif roomName == "Demonic Stairway (s)" then
                    data.roomIds.demonicAngelStairwayIdMin = roomVariant
                elseif roomName == "Demonic Stairway (copy) (e)" then
                    data.roomIds.demonicAngelStairwayIdMax = roomVariant
                    data.roomIds.demonicAngelStairwaySubtypeId = roomSubtype
                elseif roomName == "Demonic Angel (portal)" then
                    data.roomIds.demonicAngelPortalId = roomVariant
        end end end
    end
end


return data
