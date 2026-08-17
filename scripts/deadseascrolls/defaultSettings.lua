local mod = RestoredMonsterPack

mod:AddCallback(mod.SaveManager.SaveCallbacks.PRE_DATA_LOAD, function(_, data, luaMod)
	if not luaMod then
		
        if data.file.deadSeaScrolls["vesselType"] == nil then
            data.file.deadSeaScrolls["vesselType"] = 1
        end
		
		return data
	end
end)