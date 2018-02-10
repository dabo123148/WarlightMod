
function Client_PresentSettingsUI(rootParent)
	root = rootParent;
	if(Mod.Settings.PestCardIn)then
		UI.CreateLabel(rootParent).SetText('Pestilence Card Settings:');
		CreateLine('Card Pieces Needed : ', Mod.Settings.PestCardPiecesNeeded,11,false);
		CreateLine('Card Pieces Given in the beginning of the game : ', Mod.Settings.PestCardStartPieces,11,false);
		CreateLine('Strength : ', Mod.Settings.PestCardStrength,1,false);
		UI.CreateLabel(rootParent).SetText(' ');
	end
	if(Mod.Settings.NukeCardIn ~= nil and Mod.Settings.NukeCardIn)then
		UI.CreateLabel(rootParent).SetText('Nuke Card Settings:');
		CreateLine('Strength : ', Mod.Settings.PestCardStrength,1,false);
		CreateLine('Card Pieces Needed : ', Mod.Settings.NukeCardPiecesNeeded,11,false);
		CreateLine('Card Pieces Given in the beginning of the game : ', Mod.Settings.NukeCardStartPieces,11,false);
		CreateLine('Territories hit by a nuke take that much damage : ', Mod.Settings.NukeCardMainTerritoryDamage,50,false);
		CreateLine('Connected Territories to a nuke take that much damage : ', Mod.Settings.NukeCardConnectedTerritoryDamage,25,false);
		CreateLine('Connected Territories to a nuke take that much damage : ', Mod.Settings.Friendlyfire,true,true);
		if(Mod.Settings.AfterDeployment)then
			UI.CreateLabel(rootParent).SetText('Territories get nuked AFTER Deployment but before Gift and Blockade Cards take effect').SetColor('#FF0000');
		else
			UI.CreateLabel(rootParent).SetText('Territories get nuked BEFORE Deployment').SetColor('#FF0000');
		end
		UI.CreateLabel(rootParent).SetText(' ');
	end
	if(Mod.Settings.IsolationCardIninit ~= nil and Mod.Settings.IsolationCardIninit)then
		UI.CreateLabel(rootParent).SetText('Isolation Card Settings:');
		CreateLine('Card Pieces Needed : ', Mod.Settings.IsolationCardPiecesNeeded,4,false);
		CreateLine('Card Pieces Given in the beginning of the game : ', Mod.Settings.IsolationCardStartPieces,4,false);
		CreateLine('Card duration : ', Mod.Settings.IsolationCardDuration,1,false);
		UI.CreateLabel(rootParent).SetText(' ');
	end
end
function booltostring(variable)
	if(variable)then
		return "Yes";
	else
		return "No";
	end
end
function CreateLine(settingname,variable,default,important)
	local lab = UI.CreateLabel(root);
	if(default == true or default == false)then
		lab.SetText(settingname .. booltostring(variable,default));
	else
		if(variable == nil)then
			lab.SetText(settingname .. default);
		else
			lab.SetText(settingname .. variable);
		end
	end
	if(variable ~= nil and variable ~= default)then
		if(important == true)then
			lab.SetColor('#FF0000');
		else
			lab.SetColor('#FFFF00');
		end
	end
end
function booltostring(variable,default)
	if(variable == nil)then
		if(default)then
			return "Yes";
		else
			return "No";
		end
	end
	if(variable)then
		return "Yes";
	else
		return "No";
	end
end
