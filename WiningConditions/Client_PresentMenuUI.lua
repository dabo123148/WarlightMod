function Client_PresentMenuUI(rootParent, setMaxSize, setScrollable, game)
 	 root = rootParent;
 	 if (game.Us == nil) then
		UI.CreateLabel(rootParent).SetText("You have no progress since you aren't in the game");
		return;
	end
	setMaxSize(450, 350);
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
	if(Mod.Settings.terrcondition ~= nil)then
		local hasterr = false;
		for _,condition in pairs(Mod.Settings.terrcondition)do
			hasterr = true;
			if(Mod.PlayerGameData.HoldTerritories[getterrid(game,condition.Terrname)] ~= nil)then
				CreateLine('Hold the territory ' .. condition.Terrname ..  ' for this many turns : ',Mod.PlayerGameData.HoldTerritories[getterrid(game,condition.Terrname)], condition.Turnnum,-1);
			else
				CreateLine('Hold the territory ' .. condition.Terrname ..  ' for this many turns : ',"", condition.Turnnum,-1);
			end
		end
		if(hasterr == true)then
			UI.CreateLabel(rootParent).SetText("If you lose one of the territories, the condition restarts, when you get it again").SetColor('#FF0000');
		end
	end
end
function getterrid(game,name)
	for _,terr in pairs(game.Map.Territories)do
		if(terr.Name == name)then
			return terr.ID;
		end
	end
	return 0;
end
function CreateLine(settingname,completed,variable,default)
	local lab = UI.CreateLabel(root);
	if(completed == nil)then
		completed = 0;
	end
	if(variable == nil)then
		if(completed ~= "")then
			lab.SetText(settingname .. completed .. '/' .. default);
		else
			lab.SetText(settingname .. default);
		end
	else
		if(completed ~= "")then
			lab.SetText(settingname .. completed .. '/' .. variable);
		else
			lab.SetText(settingname .. variable);
		end
	end
	if(variable ~= default)then
		lab.SetColor('#FF0000');
	end
end
