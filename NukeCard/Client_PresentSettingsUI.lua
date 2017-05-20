
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
	if(Mod.Settings.Friendlyfire ~= nil)then
		if(Mod.Settings.Friendlyfire)then
			UI.CreateLabel(vert).SetText('Player can harm themself: Yes');
		else
			UI.CreateLabel(vert).SetText('Player can harm themself: No');
		end
	else
		UI.CreateLabel(vert).SetText('Player can harm themself: Yes');
	end
end

