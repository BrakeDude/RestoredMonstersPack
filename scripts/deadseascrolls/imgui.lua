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
	if ImGui.ElementExists("rmRestoredMonstersNotice") then
		ImGui.RemoveElement("rmRestoredMonstersNotice")
	end

	ImGui.AddText("rmRestoredMonstersWindow", "Settings are available only ingame.", false, "rmRestoredMonstersNotice")
end

UnLoad()

local function Load()
	if ImGui.ElementExists("rmRestoredMonstersNotice") then
		ImGui.RemoveElement("rmRestoredMonstersNotice")
	end

	-- Check for existing tab bar
	if ImGui.ElementExists("rmRestoredMonstersTabs") then
		ImGui.RemoveElement("rmRestoredMonstersTabs")
	end

	-- Restred Monsters tab bar
	ImGui.AddTabBar("rmRestoredMonstersWindow", "rmRestoredMonstersTabs")

	-- Vessels tab
	ImGui.AddTab("rmRestoredMonstersTabs", "rmRestoredMonstersTabVessel", "Vessels")

	-- Vessel type
	ImGui.AddCombobox(
		"rmRestoredMonstersTabVessel",
		"rmRestoredMonstersTabVesselType",
		"Vessel type",
		function(index, str)
			RestoredMonsterPackJF:GetDSSData().vesselType = index + 1
			RestoredMonsterPackJF.SaveManager.Save()
		end,
		{ "Normal", "Legacy" },
		0,
		true
	)
	ImGui.SetHelpmarker(
		"rmRestoredMonstersTabVesselType",
		"Replaces vessels with their legacy version.\nDisabled by default."
	)

	-- Echo bats tab
	ImGui.AddTab("rmRestoredMonstersTabs", "rmRestoredMonstersTabBlindBat", "Echo bats")

	ImGui.AddSliderInteger(
		"rmRestoredMonstersTabBlindBat",
		"rmRestoredMonstersTabBlindBatScream",
		"Scream effect",
		function(val)
			RestoredMonsterPackJF:GetDSSData().blindBatScreamInc = val
			RestoredMonsterPackJF.SaveManager.Save()
		end,
		3,
		1,
		5
	)

	ImGui.SetHelpmarker(
		"rmRestoredMonstersTabBlindBatScream",
		"Changes how strong the blind bat effect is.\nAt 3 by default."
	)

	ImGui.AddCallback("rmRestoredMonstersWindow", ImGuiCallback.Render, function()
		local dss = RestoredMonsterPackJF:GetDSSData()
		ImGui.UpdateData(
			"rmRestoredMonstersTabVesselType",
			ImGuiData.Value,
			(dss and dss.vesselType) and dss.vesselType - 1 or 1
		)
		ImGui.UpdateData(
			"rmRestoredMonstersTabBlindBatScream",
			ImGuiData.Value,
			(dss and dss.blindBatScreamInc) and dss.blindBatScreamInc or 3
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
RestoredMonsterPackJF:AddPriorityCallback(ModCallbacks.MC_POST_RENDER, CallbackPriority.LATE, UpdateImGuiOnRender)
RestoredMonsterPackJF:AddPriorityCallback(ModCallbacks.MC_MAIN_MENU_RENDER, CallbackPriority.LATE, UpdateImGuiOnRender)
