local rbMod = RegisterMod("Red Bulb - Inversion", 1)
local data = require("scripts.data")


rbMod:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, data.functions.checkForRedBulb)
rbMod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, data.functions.checkForRedBulb)
rbMod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, data.functions.GetCustomRoomTypeIds)

local dataHolder = require("scripts.dataHolder")
rbMod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, dataHolder.GetEntityData_demonicAngel)
rbMod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, dataHolder.GetEntityData_blockAngel)
rbMod:AddCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, dataHolder.ClearDataOfEntity)

local room = require("scripts.room")
rbMod:AddCallback(ModCallbacks.MC_PRE_CHANGE_ROOM, room.swapRoomlayoutPools)
rbMod:AddCallback(ModCallbacks.MC_PRE_NEW_ROOM, room.swapItemRoomPools)
rbMod:AddCallback(ModCallbacks.MC_PRE_PLAYER_COLLISION, room.blockDemonicAngel)

local items = require("scripts.items")
rbMod:AddCallback(ModCallbacks.MC_POST_PICKUP_SELECTION, items.devilFree)
rbMod:AddCallback(ModCallbacks.MC_PRE_PLAYER_COLLISION, items.devilBrokenHearts)
rbMod:AddCallback(ModCallbacks.MC_POST_PICKUP_RENDER, items.renderBrokenHeartsSprite)

--local stairway = require("scripts.stairway")
--rbMod:AddCallback(ModCallbacks.MC_PRE_CHANGE_ROOM, stairway.givePound)
--rbMod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, stairway.givePoundOnInit) -- AddInnateCollectible does not work after reentering run

local sanguine = require("scripts.sanguine")
rbMod:AddCallback(ModCallbacks.MC_PRE_CHANGE_ROOM, sanguine.blockSanguineBond)

local unlock = require("scripts.unlock")
if not Isaac.GetPersistentGameData():Unlocked(unlock.achievement) then
	rbMod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, unlock.resetOnNewRun)
	rbMod:AddCallback(ModCallbacks.MC_PRE_CHANGE_ROOM, unlock.checkRooms_unlock)
end
