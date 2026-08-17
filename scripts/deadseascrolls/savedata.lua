RestoredMonsterPack.SaveManager = include("scripts.deadseascrolls.save_manager")
RestoredMonsterPack.SaveManager.Init(RestoredMonsterPack)

function RestoredMonsterPack:GetDSSData()
    return RestoredMonsterPack.SaveManager.GetDeadSeaScrollsSave()
end