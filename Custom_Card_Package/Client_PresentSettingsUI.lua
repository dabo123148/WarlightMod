
function Client_PresentSettingsUI(rootParent)
	if(Mod.Settings.PestCardIn)then
		horz = UI.CreateHorizontalLayoutGroup(rootParent);
		UI.CreateLabel(horz).SetText('Pestilence Card Settings:');
		horz = UI.CreateHorizontalLayoutGroup(rootParent);
		UI.CreateLabel(horz).SetText('Strength: ' .. Mod.Settings.PestCardStrength);
		horz = UI.CreateHorizontalLayoutGroup(rootParent);
		UI.CreateLabel(horz).SetText('Card Pieces Needed: ' .. Mod.Settings.PestCardPiecesNeeded);
		horz = UI.CreateHorizontalLayoutGroup(rootParent);
		UI.CreateLabel(horz).SetText('Card Pieces Given in the beginning of the game: ' .. Mod.Settings.PestCardStartPieces);
		horz = UI.CreateHorizontalLayoutGroup(rootParent);
		UI.CreateLabel(horz).SetText(' ');
	end
	if(Mod.Settings.NukeCardIn ~= nil and Mod.Settings.NukeCardIn)then
		horz = UI.CreateHorizontalLayoutGroup(rootParent);
		UI.CreateLabel(horz).SetText('Nuke Card Settings:');
		horz = UI.CreateHorizontalLayoutGroup(rootParent);
		UI.CreateLabel(vert).SetText('Territories hit by a nuke take ' .. (Mod.Settings.NukeCardMainTerritoryDamage) .. '% Damage');
		horz = UI.CreateHorizontalLayoutGroup(rootParent);
		UI.CreateLabel(vert).SetText('Connected Territories to a nuke take ' .. (Mod.Settings.NukeCardConnectedTerritoryDamage) .. '% Damage');
		horz = UI.CreateHorizontalLayoutGroup(rootParent);
		UI.CreateLabel(vert).SetText('Players can harm themselves: ' .. booltostring(Mod.Settings.Friendlyfire));
		horz = UI.CreateHorizontalLayoutGroup(rootParent);
		if(Mod.Settings.AfterDeployment)then
			UI.CreateLabel(vert).SetText('Territories get nuked AFTER Deployment but before Gift and Blockade Cards take effect');
		else
			UI.CreateLabel(vert).SetText('Territories get nuked BEFORE Deployment');
		end
		horz = UI.CreateHorizontalLayoutGroup(rootParent);
		UI.CreateLabel(horz).SetText('Card Pieces Needed: ' .. Mod.Settings.NukeCardPiecesNeeded);
		horz = UI.CreateHorizontalLayoutGroup(rootParent);
		UI.CreateLabel(horz).SetText('Card Pieces Given in the beginning of the game: ' .. Mod.Settings.NukeCardStartPieces);
		
		horz = UI.CreateHorizontalLayoutGroup(rootParent);
	end
end
function booltostring(variable)
	if(variable)then
		return "Yes";
	else
		return "No";
	end
end
