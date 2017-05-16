
function Client_PresentSettingsUI(rootParent)
	local vert = UI.CreateVerticalLayoutGroup(rootParent);
	if(Mod.Settings.MainTerritoryDamage ~= nil)then
		UI.CreateLabel(vert).SetText('Territorys hit by a nuke take ' .. (Mod.Settings.MainTerritoryDamage*100) .. '% Damage');
	else
		UI.CreateLabel(vert).SetText('Territorys hit by a nuke take 50% Damage');
	end
	vert = UI.CreateVerticalLayoutGroup(rootParent);
	if(Mod.Settings.ConnectedTerritoryDamage ~= nil)then
		UI.CreateLabel(vert).SetText('Connected Territorys to a nuke take ' .. toString((Mod.Settings.ConnectedTerritoryDamage*100)) .. '% Damage');
	else
		UI.CreateLabel(vert).SetText('Connected Territorys to a nuke take 25% Damage');
	end
end

