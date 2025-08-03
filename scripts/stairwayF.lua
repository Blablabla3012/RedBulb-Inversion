local stairwayF = {}
local data = require("scripts.data")
local level = Game():GetLevel()


function stairwayF:giveSanguineBondEffect(index, dimension)
	if index ~= -18 or not data.doInversion then
	return end

	local roomDesc = level:GetRoomByIdx(index, dimension)
	if roomDesc.Data.Type ~= RoomType.ROOM_ANGEL or roomDesc.Data.Subtype ~= data.roomIds.angelicDevilSubtypeId then
	return end

	local player = Isaac.GetPlayer()
	player:AddInnateCollectible(CollectibleType.COLLECTIBLE_SANGUINE_BOND, 1) -- 1 = Amount
	--works?
end


return stairwayF
