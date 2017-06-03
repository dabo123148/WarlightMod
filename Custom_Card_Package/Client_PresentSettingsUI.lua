
function Client_PresentSettingsUI(rootParent)
	local vert = UI.CreateVerticalLayoutGroup(rootParent);
	
	UI.CreateLabel(vert).SetText('Pestilence Strength:' .. Mod.Settings.PestilenceStrength);
end

