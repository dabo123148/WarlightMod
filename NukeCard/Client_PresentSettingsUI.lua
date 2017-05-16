
function Client_PresentSettingsUI(rootParent)
	local vert = UI.CreateVerticalLayoutGroup(rootParent);
	if(Mod.Settings.MainTerritoryDamage ~= nil)then
		UI.CreateLabel(vert).SetText('Territorys hit by a nuke take ' .. (Mod.Settings.MainTerritoryDamage) .. '% Damage');
	else
		UI.CreateLabel(vert).SetText('Territorys hit by a nuke take 50% Damage');
	end
	vert = UI.CreateVerticalLayoutGroup(rootParent);
	if(Mod.Settings.ConnectedTerritoryDamage ~= nil)then
		UI.CreateLabel(vert).SetText('Connected Territorys to a nuke take ' .. (Mod.Settings.ConnectedTerritoryDamage) .. '% Damage');
	else
		UI.CreateLabel(vert).SetText('Connected Territorys to a nuke take 25% Damage');
	end
end

