local stairwayF = {}
local data = require("scripts.data")
local level = Game():GetLevel()

local hasSanguine = false
function stairwayF:giveSanguineBondEffect(index, dimension)
	if not data.doInversion then
	return end

	local player = Isaac.GetPlayer()
	hasSanguine = false

	if index == GridRooms.ROOM_ANGEL_SHOP_IDX then
		player:AddInnateCollectible(CollectibleType.COLLECTIBLE_SANGUINE_BOND, 1) -- 1 = Amount
		hasSanguine = true
	elseif hasSanguine then
		player:AddInnateCollectible(CollectibleType.COLLECTIBLE_SANGUINE_BOND, -1)
		hasSanguine = false
	return end
end

function stairwayF:giveSanguineOnInit()
	if not data.doInversion then
	return end

	hasSanguine = false

	local roomDesc = level:GetCurrentRoomDesc()
	if roomDesc.ListIndex ~= GridRooms.ROOM_ANGEL_SHOP_IDX then
	return end

	local player = Isaac.GetPlayer()
	player:AddInnateCollectible(CollectibleType.COLLECTIBLE_SANGUINE_BOND, 1)
	hasSanguine = true
end


return stairwayF
