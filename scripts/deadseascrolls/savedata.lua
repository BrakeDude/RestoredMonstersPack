RestoredMonsterPackJF.SaveManager = include("scripts.deadseascrolls.save_manager")
RestoredMonsterPackJF.SaveManager.Init(RestoredMonsterPackJF)

include("scripts.deadseascrolls.defaultSettings")

function RestoredMonsterPackJF:GetDSSData()
    return RestoredMonsterPackJF.SaveManager.GetDeadSeaScrollsSave()
end