SaveManager = include("scripts.deadseascrolls.save_manager")
SaveManager.Init(RestoredMonsterPackJF)
SaveManager.Load()

RestoredMonsterPackJF.DSSavedata = SaveManager.GetDeadSeaScrollsSave()

include("scripts.deadseascrolls.defaultSettings")

RestoredMonsterPackJF:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, function()
	Isaac.DebugString("PREGAMEEXITPRESAVE")
    SaveManager.Save()
	Isaac.DebugString("PREGAMEEXITPOSTSAVE")
    RestoredMonsterPackJF.gamestarted = false
end)

RestoredMonsterPackJF:AddCallback(ModCallbacks.MC_POST_GAME_END, function()
    RestoredMonsterPackJF.gamestarted = false
end)

RestoredMonsterPackJF:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, function()
    if RestoredMonsterPackJF.gamestarted then
        SaveManager.Save()
    end
end)