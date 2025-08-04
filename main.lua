local rbMod = RegisterMod("Red Bulb - Inversion", 1)
local data = require("scripts.data")


rbMod:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, data.functions.checkForRedBulb)
rbMod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, data.functions.checkForRedBulb)
rbMod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, data.functions.GetCustomRoomTypeIds)

local dataHolder = require("scripts.dataHolder")
rbMod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, dataHolder.GetEntityData_demonicAngel)
rbMod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, dataHolder.GetEntityData_blockAngel)
rbMod:AddCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, dataHolder.ClearDataOfEntity)

local roomF = require("scripts.roomF")
rbMod:AddCallback(ModCallbacks.MC_PRE_CHANGE_ROOM, roomF.swapRoomlayoutPools)
rbMod:AddCallback(ModCallbacks.MC_PRE_NEW_ROOM, roomF.swapItemRoomPools)
rbMod:AddCallback(ModCallbacks.MC_PRE_PLAYER_COLLISION, roomF.blockDemonicAngel)

local itemsF = require("scripts.itemsF")
rbMod:AddCallback(ModCallbacks.MC_POST_PICKUP_SELECTION, itemsF.devilFree)
rbMod:AddCallback(ModCallbacks.MC_PRE_PLAYER_COLLISION, itemsF.devilBrokenHearts)
rbMod:AddCallback(ModCallbacks.MC_POST_PICKUP_RENDER, itemsF.renderBrokenHeartsSprite)

local stairwayF = require("scripts.stairwayF")
rbMod:AddCallback(ModCallbacks.MC_PRE_CHANGE_ROOM, stairwayF.giveSanguine)
rbMod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, stairwayF.giveSanguineOnInit) -- AddInnateCollectible does not work if reentering run

local sanguineF = require("scripts.sanguineF")
rbMod:AddCallback(ModCallbacks.MC_PRE_CHANGE_ROOM, sanguineF.blockSanguineBond)
rbMod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, sanguineF.setSanguineBlockedVariable)
