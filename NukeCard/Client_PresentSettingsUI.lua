
function Client_PresentSettingsUI(rootParent)
	local vert = UI.CreateVerticalLayoutGroup(rootParent);
	if(Mod.Settings.MainTerritoryDamage ~= nil)then
		UI.CreateLabel(vert).SetText('Territories hit by a nuke take ' .. (Mod.Settings.MainTerritoryDamage) .. '% Damage');
	else
		UI.CreateLabel(vert).SetText('Territories hit by a nuke take 50% Damage');
	end
	vert = UI.CreateVerticalLayoutGroup(rootParent);
	if(Mod.Settings.ConnectedTerritoryDamage ~= nil)then
		UI.CreateLabel(vert).SetText('Connected Territories to a nuke take ' .. (Mod.Settings.ConnectedTerritoryDamage) .. '% Damage');
	else
		UI.CreateLabel(vert).SetText('Connected Territories to a nuke take 25% Damage');
	end
	vert = UI.CreateVerticalLayoutGroup(rootParent);
	if(Mod.Settings.Friendlyfire ~= nil)then
		if(Mod.Settings.Friendlyfire)then
			UI.CreateLabel(vert).SetText('Players can harm themselves: Yes');
		else
			UI.CreateLabel(vert).SetText('Players can harm themselves: No');
		end
	else
		UI.CreateLabel(vert).SetText('Players can harm themselves: Yes');
	end
	vert = UI.CreateVerticalLayoutGroup(rootParent);
	if(Mod.Settings.AfterDeployment ~= nil)then
		if(Mod.Settings.AfterDeployment)then
			UI.CreateLabel(vert).SetText('Territories get nuked AFTER Deployment but before Gift Cards take effect');
		else
			UI.CreateLabel(vert).SetText('Territories get nuked BEFORE Deployment');
		end
	else
		UI.CreateLabel(vert).SetText('Territories get nuked BEFORE Deployment');
	end
end

