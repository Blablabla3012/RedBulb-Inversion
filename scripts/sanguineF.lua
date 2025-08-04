local sanguineF = {}
local data = require("scripts.data")
local level = Game():GetLevel()

function sanguineF:blockSanguineBond(collectibleType, _, _, _, _, player)
	if not data.doInversion or collectibleType ~= CollectibleType.COLLECTIBLE_SANGUINE_BOND then
	return end

	player:BlockCollectible(CollectibleType.COLLECTIBLE_SANGUINE_BOND)
end

return sanguineF
