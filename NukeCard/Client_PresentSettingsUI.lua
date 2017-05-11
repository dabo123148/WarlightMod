
function Client_PresentSettingsUI(rootParent)
	local vert = UI.CreateVerticalLayoutGroup(rootParent);
	UI.CreateLabel(vert).SetText('Territorys hit by a nuke take ' .. toString((Mod.Settings.MainTerritoryDamage*100)) .. '% Damage');

	vert = UI.CreateVerticalLayoutGroup(rootParent);
	UI.CreateLabel(vert).SetText('Connected Territorys to a nuke take ' .. toString((Mod.Settings.ConnectedTerritoryDamage*100)) .. '% Damage');
end

