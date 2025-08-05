local unlock = {}
unlock.achievement = Isaac.GetAchievementIdByName("Red Bulb Unlock")


unlock.wasInDevil = nil
unlock.wasInAngel = nil

function unlock:resetOnNewRun(isContinued)
	if isContinued then
	return end

	unlock.wasInDevil = false
	unlock.wasInAngel = false
end

function unlock:checkRooms_unlock(index, dimension)
	if index ~= GridRooms.ROOM_DEVIL_IDX then
	return end
	if unlock.wasInDevil and unlock.wasInAngel then
	return end

	local roomDesc = Game():GetLevel():GetRoomByIdx(index, dimension)
	if not unlock.wasInDevil then
		if roomDesc.Data.Type == RoomType.ROOM_DEVIL then
			unlock.wasInDevil = true
	end end

	if not unlock.wasInAngel then
		if roomDesc.Data.Type == RoomType.ROOM_ANGEL then
			unlock.wasInAngel = true
	end end


	if unlock.wasInDevil and unlock.wasInAngel then
		Isaac.GetPersistentGameData():TryUnlock(unlock.achievement)
	end
end


return unlock
