
function Client_PresentSettingsUI(rootParent)
	root = rootParent;
	UI.CreateLabel(rootParent).SetText('AI Settings');
	CreateLine('AIs are allowed to declare war on player : ', Mod.Settings.AllowAIDeclaration,true,true);
	UI.CreateLabel(rootParent).SetText('AIs are allowed to declare war on AIs : ' .. booltostring(Mod.Settings.AIsdeclearAIs));
	UI.CreateLabel(rootParent).SetText(' ');
	UI.CreateLabel(rootParent).SetText('Alliance Settings - this system will come in a later version, but that would be a bigger change, so I added the settings for that already, but they have at the moment no effect');
	UI.CreateLabel(rootParent).SetText('Allied players can see your territories : ' .. booltostring(Mod.Settings.SeeAllyTerritories));
	UI.CreateLabel(rootParent).SetText('Allies are visible to everyone : ' .. booltostring(Mod.Settings.PublicAllies));
	UI.CreateLabel(rootParent).SetText(' ');
	UI.CreateLabel(rootParent).SetText('Tradement System');
	if(Mod.Settings.StartMoney ~= 0 or Mod.Settings.MoneyPerTurn ~= 0 or Mod.Settings.MoneyPerKilledArmy ~= 0 or Mod.Settings.MoneyPerCapturedTerritory ~= 0 or Mod.Settings.MoneyPerCapturedBonus ~= 0)then
		UI.CreateLabel(rootParent).SetText('Player starting money : ' .. Mod.Settings.StartMoney);
		UI.CreateLabel(rootParent).SetText('Extra money per turn : ' .. Mod.Settings.MoneyPerTurn);
		UI.CreateLabel(rootParent).SetText('Extra money per killed army : ' .. Mod.Settings.MoneyPerKilledArmy);
		UI.CreateLabel(rootParent).SetText('Extra money per captured territory : ' .. Mod.Settings.MoneyPerCapturedTerritory);
		UI.CreateLabel(rootParent).SetText('Extra money per captured bonus : ' .. Mod.Settings.MoneyPerCapturedBonus);
		UI.CreateLabel(rootParent).SetText('Price per army : ' .. Mod.Settings.MoneyPerBoughtArmy);
	else
		UI.CreateLabel(rootParent).SetText('The Trading System has been disabled');
	end
	UI.CreateLabel(rootParent).SetText(' ');
	UI.CreateLabel(rootParent).SetText('Card Settings');
	UI.CreateLabel(rootParent).SetText('Sanction Card');
	if(AlwaysPlayable(Mod.Settings.SanctionCardRequireWar,Mod.Settings.SanctionCardRequirePeace,Mod.Settings.SanctionCardRequireAlly))then
		UI.CreateLabel(rootParent).SetText('You can play a Sanction Card on everybody');
	else
		UI.CreateLabel(rootParent).SetText('Sanction Cards can be played on players you are in war with : ' .. booltostring(Mod.Settings.SanctionCardRequireWar));
		UI.CreateLabel(rootParent).SetText('Sanction Cards can be played on players you are in peace with : ' .. booltostring(Mod.Settings.SanctionCardRequirePeace,false));
		UI.CreateLabel(rootParent).SetText('Sanction Cards can be played on players you are allied with : ' .. booltostring(Mod.Settings.SanctionCardRequireAlly,false));
	end
	UI.CreateLabel(rootParent).SetText('Bomb Card');
	if(AlwaysPlayable(Mod.Settings.BombCardRequireWar,Mod.Settings.BombCardRequirePeace,Mod.Settings.BombCardRequireAlly))then
		UI.CreateLabel(rootParent).SetText('You can play a Bomb Card on everybody');
	else
		UI.CreateLabel(rootParent).SetText('Bomb Cards can be played on players you are in war with : ' .. booltostring(Mod.Settings.BombCardRequireWar));
		UI.CreateLabel(rootParent).SetText('Bomb Cards can be played on players you are in peace with : ' .. booltostring(Mod.Settings.BombCardRequirePeace,false));
		UI.CreateLabel(rootParent).SetText('Bomb Cards can be played on players you are allied with : ' .. booltostring(Mod.Settings.BombCardRequireAlly,false));
	end
	UI.CreateLabel(rootParent).SetText('Spy Card');
	if(AlwaysPlayable(Mod.Settings.SpyCardRequireWar,Mod.Settings.SpyCardRequirePeace,Mod.Settings.SpyCardRequireAlly))then
		UI.CreateLabel(rootParent).SetText('You can play a Spy Card on everybody');
	else
		UI.CreateLabel(rootParent).SetText('Spy Cards can be played on players you are in war with : ' .. booltostring(Mod.Settings.SpyCardRequireWar));
		UI.CreateLabel(rootParent).SetText('Spy Cards can be played on players you are in peace with : ' .. booltostring(Mod.Settings.SpyCardRequirePeace));
		UI.CreateLabel(rootParent).SetText('Spy Cards can be played on players you are allied with : ' .. booltostring(Mod.Settings.SpyCardRequireAlly));
	end
	UI.CreateLabel(rootParent).SetText('Gift Card');
	if(AlwaysPlayable(Mod.Settings.GiftCardRequireWar,Mod.Settings.GiftCardRequirePeace,Mod.Settings.GiftCardRequireAlly))then
		UI.CreateLabel(rootParent).SetText('You can play a Gift Card on everybody');
	else
		UI.CreateLabel(rootParent).SetText('Gift Cards can be played on players you are in war with : ' .. booltostring(Mod.Settings.GiftCardRequireWar));
		UI.CreateLabel(rootParent).SetText('Gift Cards can be played on players you are in peace with : ' .. booltostring(Mod.Settings.GiftCardRequirePeace));
		UI.CreateLabel(rootParent).SetText('Gift Cards can be played on players you are allied with : ' .. booltostring(Mod.Settings.GiftCardRequireAlly));
	end
	UI.CreateLabel(rootParent).SetText(' ');
	UI.CreateLabel(rootParent).SetText('Other Settings');
	UI.CreateLabel(rootParent).SetText('dabo1 has access to all data for fixing bugs and other diagnostic functions runtime : ' .. booltostring(Mod.Settings.AdminAccess,false));
end
function CreateLine(settingname,variable,default,important)
	local lab = UI.CreateLabel(root);
	if(variable == true or variable == false)then
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
