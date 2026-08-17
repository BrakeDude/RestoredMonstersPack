local mod = RestoredMonsterPackJF


local default = {
    vesselType = 1,
    blindBatScreamInc = 3
}

mod:AddCallback(mod.SaveManager.SaveCallbacks.PRE_DATA_LOAD, function(_, data, luaMod)
	if not luaMod then
		
        for setting, value in pairs(default) do
            if data.file.deadSeaScrolls[setting] == nil then
                data.file.deadSeaScrolls[setting] = value
            end
        end
		
		return data
	end
end)