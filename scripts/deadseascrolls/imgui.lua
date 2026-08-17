if not REPENTOGON then
	return
end

-- ImGui menu
if not ImGui.ElementExists("RestoredMods") then
	ImGui.CreateMenu("RestoredMods", "Restored Mods")
end

-- Restored Monsters menu
if not ImGui.ElementExists("rmRestoredMonsters") then
	ImGui.AddElement("RestoredMods", "rmRestoredMonsters", ImGuiElement.MenuItem, "Restored Monsters")
end

-- Restored Monsters window
if not ImGui.ElementExists("rmRestoredMonstersWindow") then
	ImGui.CreateWindow("rmRestoredMonstersWindow", "Restored Monsters")
end
ImGui.LinkWindowToElement("rmRestoredMonstersWindow", "rmRestoredMonsters")

local function UnLoad()
    ImGui.RemoveCallback("rmRestoredMonstersWindow", ImGuiCallback.Render)
    if ImGui.ElementExists("rmRestoredMonstersTabs") then
		ImGui.RemoveElement("rmRestoredMonstersTabs")
	end
    if not ImGui.ElementExists("rmRestoredMonstersNotice") then
        ImGui.AddText("rmRestoredMonstersWindow", "Settings are available only ingame.", false, "rmRestoredMonstersNotice")
    end
end

local function Load()
	-- Check for existing tab bar

    if ImGui.ElementExists("rmRestoredMonstersNotice") then
		ImGui.RemoveElement("rmRestoredMonstersNotice")
	end

	if ImGui.ElementExists("rmRestoredMonstersTabs") then
		ImGui.RemoveElement("rmRestoredMonstersTabs")
	end

	-- Restroed Monsters tab bar
	ImGui.AddTabBar("rmRestoredMonstersWindow", "rmRestoredMonstersTabs")

	-- Vessels tab
	ImGui.AddTab("rmRestoredMonstersTabs", "rmRestoredMonstersTabVessel", "Vessels")

	-- Vessel type
	ImGui.AddCombobox(
		"rmRestoredMonstersTabVessel",
		"rmRestoredMonstersTabVesselType",
		"Vessel type",
		function(index, str)
			RestoredMonsterPack:GetDSSData().vesselType = index + 1
			RestoredMonsterPack.SaveManager.Save()
		end,
		{ "Normal", "Legacy" },
		0,
		true
	)
	ImGui.SetHelpmarker(
		"rmRestoredMonstersTabVesselType",
		"Replaces vessels with their legacy version.\nDisabled by default."
	)

	ImGui.AddCallback("rmRestoredMonstersWindow", ImGuiCallback.Render, function()
		local dss = RestoredMonsterPack:GetDSSData()
		ImGui.UpdateData(
			"rmRestoredMonstersTabVesselType",
			ImGuiData.Value,
			(dss and dss.vesselType) and dss.vesselType - 1 or 1
		)
	end)
end

local InGame = false

local function UpdateImGuiOnRender()
	if not Isaac.IsInGame() and InGame then
		UnLoad()
		InGame = false
	elseif Isaac.IsInGame() and not InGame then
		Load()
		InGame = true
	end
end
RestoredMonsterPack:AddPriorityCallback(ModCallbacks.MC_POST_RENDER, CallbackPriority.LATE, UpdateImGuiOnRender)
RestoredMonsterPack:AddPriorityCallback(ModCallbacks.MC_MAIN_MENU_RENDER, CallbackPriority.LATE, UpdateImGuiOnRender)