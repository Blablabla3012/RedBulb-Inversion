local sanguine = {}
local data = require("scripts.data")
local level = Game():GetLevel()


local sanguineBlocked = true
function sanguine:blockSanguineBond(index)
	if not data.doInversion then
	return end
	
	if index == GridRooms.ROOM_DEVIL_IDX then
		local players = PlayerManager.GetPlayers()
		for _, player in ipairs(players) do
			player:BlockCollectible(CollectibleType.COLLECTIBLE_SANGUINE_BOND)
		end
		sanguineBlocked = true
	elseif sanguineBlocked then
		local players = PlayerManager.GetPlayers()
		for _, player in ipairs(players) do
			player:UnblockCollectible(CollectibleType.COLLECTIBLE_SANGUINE_BOND)
		end
		sanguineBlocked = false
	end
end


return sanguine
