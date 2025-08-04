local stairwayF = {}
local data = require("scripts.data")
local level = Game():GetLevel()


local AddedSanguine = true
function stairwayF:giveSanguine(index, dimension)
	if not data.doInversion then
	return end

	if index == GridRooms.ROOM_ANGEL_SHOP_IDX then
		local player = Isaac.GetPlayer() --not PlayerManager.GetPlayers(), one instant of Sanguine Bond is enough
		player:AddInnateCollectible(CollectibleType.COLLECTIBLE_SANGUINE_BOND, 1) -- 1 = Amount
		AddedSanguine = true
	elseif AddedSanguine then
		local player = Isaac.GetPlayer()
		player:AddInnateCollectible(CollectibleType.COLLECTIBLE_SANGUINE_BOND, -1)
		AddedSanguine = false
	end
end

function stairwayF:giveSanguineOnInit()
	if not data.doInversion then
	return end

	AddedSanguine = false

	local roomDesc = level:GetCurrentRoomDesc()
	if roomDesc.GridIndex ~= GridRooms.ROOM_ANGEL_SHOP_IDX then
	return end

	local player = Isaac.GetPlayer()
	player:AddInnateCollectible(CollectibleType.COLLECTIBLE_SANGUINE_BOND, 1)
	AddedSanguine = true
end


return stairwayF
