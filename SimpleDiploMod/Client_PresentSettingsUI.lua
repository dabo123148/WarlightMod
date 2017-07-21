
function Client_PresentSettingsUI(rootParent)
	root = rootParent;
	UI.CreateLabel(rootParent).SetText('AI Settings');
	CreateLine('AIs are allowed to declare war on player : ', Mod.Settings.AllowAIDeclaration,true,true);
	CreateLine('AIs are allowed to declare war on AIs : ', Mod.Settings.AIsdeclearAIs,true,true);
	UI.CreateLabel(rootParent).SetText(' ');
	UI.CreateLabel(rootParent).SetText('Alliance Settings - this system will come in a later version, but that would be a bigger change, so I added the settings for that already, but they have at the moment no effect');
	CreateLine('Allied players can see your territories : ', Mod.Settings.SeeAllyTerritories,true,true);
	CreateLine('Allies are visible to everyone : ', Mod.Settings.PublicAllies,true,true);
	UI.CreateLabel(rootParent).SetText(' ');
	UI.CreateLabel(rootParent).SetText('Tradement System');
	if(Mod.Settings.StartMoney ~= 0 or Mod.Settings.MoneyPerTurn ~= 0 or Mod.Settings.MoneyPerKilledArmy ~= 0 or Mod.Settings.MoneyPerCapturedTerritory ~= 0 or Mod.Settings.MoneyPerCapturedBonus ~= 0)then
		CreateLine('Player starting money : ', Mod.Settings.StartMoney,100,false);
		CreateLine('Extra money per turn : ', Mod.Settings.MoneyPerTurn,5,false);
		CreateLine('Extra money per killed army : ', Mod.Settings.MoneyPerKilledArmy,1,false);
		CreateLine('Extra money per captured territory : ', Mod.Settings.MoneyPerCapturedTerritory,5,false);
		CreateLine('Extra money per captured bonus : ', Mod.Settings.MoneyPerCapturedBonus,10,false);
		CreateLine('Price per army : ', Mod.Settings.MoneyPerBoughtArmy,2,false);
	else
		UI.CreateLabel(rootParent).SetText('The Trading System has been disabled').SetColor('#FF0000');
	end
	UI.CreateLabel(rootParent).SetText(' ');
	UI.CreateLabel(rootParent).SetText('Card Settings');
	UI.CreateLabel(rootParent).SetText('Sanction Card');
	if(AlwaysPlayable(Mod.Settings.SanctionCardRequireWar,Mod.Settings.SanctionCardRequirePeace,Mod.Settings.SanctionCardRequireAlly))then
		UI.CreateLabel(rootParent).SetText('You can play a Sanction Card on everybody').SetColor('#FF0000');
	else
		CreateLine('Sanction Cards can be played on players you are in war with : ', Mod.Settings.SanctionCardRequireWar,true,false);
		CreateLine('Sanction Cards can be played on players you are in peace with : ', Mod.Settings.SanctionCardRequirePeace,false,false);
		CreateLine('Sanction Cards can be played on players you are allied with : ', Mod.Settings.SanctionCardRequireAlly,false,false);
	end
	UI.CreateLabel(rootParent).SetText('Bomb Card');
	if(AlwaysPlayable(Mod.Settings.BombCardRequireWar,Mod.Settings.BombCardRequirePeace,Mod.Settings.BombCardRequireAlly))then
		UI.CreateLabel(rootParent).SetText('You can play a Bomb Card on everybody').SetColor('#FF0000');
	else
		CreateLine('Bomb Cards can be played on players you are in war with : ', Mod.Settings.BombCardRequireWar,true,false);
		CreateLine('Bomb Cards can be played on players you are in peace with : ', Mod.Settings.BombCardRequirePeace,false,false);
		CreateLine('Bomb Cards can be played on players you are allied with : ', Mod.Settings.BombCardRequireAlly,false,false);
	end
	UI.CreateLabel(rootParent).SetText('Spy Card');
	if(AlwaysPlayable(Mod.Settings.SpyCardRequireWar,Mod.Settings.SpyCardRequirePeace,Mod.Settings.SpyCardRequireAlly))then
		UI.CreateLabel(rootParent).SetText('You can play a Spy Card on everybody').SetColor('#FF0000');
	else
		CreateLine('Spy Cards can be played on players you are in war with : ', Mod.Settings.SpyCardRequireWar,true,false);
		CreateLine('Spy Cards can be played on players you are in peace with : ', Mod.Settings.SpyCardRequirePeace,false,false);
		CreateLine('Spy Cards can be played on players you are allied with : ', Mod.Settings.SpyCardRequireAlly,false,false);
	end
	UI.CreateLabel(rootParent).SetText('Gift Card');
	if(AlwaysPlayable(Mod.Settings.GiftCardRequireWar,Mod.Settings.GiftCardRequirePeace,Mod.Settings.GiftCardRequireAlly))then
		UI.CreateLabel(rootParent).SetText('You can play a Gift Card on everybody').SetColor('#FF0000');
	else
		CreateLine('Gift Cards can be played on players you are in war with : ', Mod.Settings.GiftCardRequireWar,false,false);
		CreateLine('Gift Cards can be played on players you are in peace with : ', Mod.Settings.GiftCardRequirePeace,false,false);
		CreateLine('Gift Cards can be played on players you are allied with : ', Mod.Settings.GiftCardRequireAlly,true,false);
	end
	UI.CreateLabel(rootParent).SetText(' ');
	UI.CreateLabel(rootParent).SetText('Other Settings');
	CreateLine('dabo1 has access to all data for fixing bugs and other diagnostic functions runtime : ', Mod.Settings.AdminAccess,false,true);
end
function CreateLine(settingname,variable,default,important)
	local lab = UI.CreateLabel(root);
	if(variable == true or variable == false or variable == nil)then
		lab.SetText(settingname .. booltostring(variable,default));
	else
		lab.SetText(settingname .. variable);
	end
	if(variable ~= default)then
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
function AlwaysPlayable(warsetting,peacesetting,allysetting)
	if(peacesetting == nil and allysetting == nil)then
		if(warsetting == nil)then
			return true;
		else
			if(warsetting)then
				return false;
			else
				return true;
			end
		end
	end
	if(peacesetting and allysetting and warsetting)then
		return true;
	end
	return false;
end
