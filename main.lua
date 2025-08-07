local rbMod = RegisterMod("Red Bulb - Inversion", 1)

--[[ DATA ]]--
local data = require("scripts.data")
rbMod:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, data.functions.checkForRedBulb)
rbMod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, data.functions.checkForRedBulb)
rbMod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, data.functions.GetCustomRoomTypeIds)

local dataHolder = require("scripts.dataHolder")
rbMod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, dataHolder.GetEntityData_demonicAngel)
rbMod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, dataHolder.GetEntityData_blockAngel)
rbMod:AddCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, dataHolder.ClearDataOfEntity)

--[[ RED BULB ]]--
local room = require("scripts.room")
rbMod:AddCallback(ModCallbacks.MC_PRE_CHANGE_ROOM, room.swapRoomlayoutPools)
rbMod:AddCallback(ModCallbacks.MC_PRE_NEW_ROOM, room.swapItemRoomPools)
rbMod:AddCallback(ModCallbacks.MC_PRE_PLAYER_COLLISION, room.blockDemonicAngel)

local items = require("scripts.items")
rbMod:AddCallback(ModCallbacks.MC_POST_PICKUP_SELECTION, items.devilFree)
rbMod:AddCallback(ModCallbacks.MC_PRE_PLAYER_COLLISION, items.devilBrokenHearts)
rbMod:AddCallback(ModCallbacks.MC_POST_PICKUP_RENDER, items.renderBrokenHeartsSprite)

local unlock = require("scripts.unlock")
rbMod:AddCallback(ModCallbacks.MC_POST_SAVESLOT_LOAD, unlock.isUnlocked) -- GetPersistentGameData() shall not be called outside of Callbacks
rbMod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, unlock.resetOnNewRun)
rbMod:AddCallback(ModCallbacks.MC_PRE_CHANGE_ROOM, unlock.checkRooms_unlock)

--[[ SYNERGIES ]]--
local stairway = require("scripts.stairway")
rbMod:AddCallback(ModCallbacks.MC_PRE_CHANGE_ROOM, stairway.givePound)
rbMod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, stairway.givePoundOnInit) -- AddInnateCollectible does not work after reentering run

local sanguine = require("scripts.sanguine")
rbMod:AddCallback(ModCallbacks.MC_PRE_CHANGE_ROOM, sanguine.blockSanguineBond)
rbMod:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, sanguine.checkForSanguine)
rbMod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, sanguine.checkForSanguine)
rbMod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, sanguine.spawnConfessional)
