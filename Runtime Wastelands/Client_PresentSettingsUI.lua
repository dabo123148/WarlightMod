
function Client_PresentSettingsUI(rootParent)
	local vert = UI.CreateVerticalLayoutGroup(rootParent);
	
	UI.CreateLabel(vert).SetText('Wastelands per Turn:' .. Mod.Settings.WastelandsPerTurn);
end

