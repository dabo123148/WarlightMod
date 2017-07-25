
function Client_PresentSettingsUI(rootParent)
	root = rootParent;
	UI.CreateLabel(rootParent).SetText('To view your progress go under menu').SetColor('#FF0000');
	UI.CreateLabel(rootParent).SetText('To win, you need to complete ' .. Mod.Settings.Conditionsrequiredforwin .. ' of this red conditions').SetColor('#FF0000');
	CreateLine('Captured this many territories : ',Mod.PlayerGameData.Capturedterritories, Mod.Settings.Capturedterritories,0);
	CreateLine('Lost this many territories : ',Mod.PlayerGameData.Lostterritories, Mod.Settings.Lostterritories,0);
	CreateLine('Owns this many territories : ',Mod.PlayerGameData.Ownedterritories, Mod.Settings.Ownedterritories,0);
	CreateLine('Captured this many bonuses : ',Mod.PlayerGameData.Capturedbonuses, Mod.Settings.Capturedbonuses,0);
	CreateLine('Lost this many bonuses : ',Mod.PlayerGameData.Lostbonuses, Mod.Settings.Lostbonuses,0);
	CreateLine('Owns this many bonuses : ',Mod.PlayerGameData.Ownedbonuses, Mod.Settings.Ownedbonuses,0);
	CreateLine('Killed this many armies : ',Mod.PlayerGameData.Killedarmies, Mod.Settings.Killedarmies,0);
	CreateLine('Lost this many armies : ',Mod.PlayerGameData.Lostarmies, Mod.Settings.Lostarmies,0);
	CreateLine('Owns this many armies : ',Mod.PlayerGameData.Ownedarmies, Mod.Settings.Ownedarmies,0);
	CreateLine('Eliminated this many AIs : ',Mod.PlayerGameData.Eleminateais, Mod.Settings.Eleminateais,0);
	CreateLine('Eliminated this many players : ',Mod.PlayerGameData.Eleminateplayers, Mod.Settings.Eleminateplayers,0);
	CreateLine('Eliminated this many AIs and players : ',Mod.PlayerGameData.Eleminateaisandplayers, Mod.Settings.Eleminateaisandplayers,0);
end
function CreateLine(settingname,completed,variable,default)
	local lab = UI.CreateLabel(root);
	if(completed == nil)then
		completed = -1;
	end
	if(variable == nil)then
		--lab.SetText(settingname .. completed .. '/' .. default);
		lab.SetText(settingname .. default);
	else
		--lab.SetText(settingname .. completed .. '/' .. variable);
		lab.SetText(settingname .. variable);
	end
	if(variable ~= default)then
		lab.SetColor('#FF0000');
	end
end
