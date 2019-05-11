
function Client_PresentSettingsUI(rootParent)
	root = rootParent;
	UI.CreateLabel(rootParent).SetText('AI Settings');
	CreateLine('AIs are allowed to declare war on player : ', Mod.Settings.AllowAIDeclaration,false,true);
	CreateLine('AIs are allowed to declare war on AIs : ', Mod.Settings.AIsdeclearAIs,true,true);
	UI.CreateLabel(rootParent).SetText(' ');
	UI.CreateLabel(rootParent).SetText('Alliance Settings');
	CreateLine('Allied players can see your territories : ', Mod.Settings.SeeAllyTerritories,true,true);
	CreateLine('Allies are visible to everyone : ', Mod.Settings.PublicAllies,true,true);
	UI.CreateLabel(rootParent).SetText(' ');
	UI.CreateLabel(rootParent).SetText('Card Settings');
	UI.CreateLabel(rootParent).SetText('Sanction Card');
	if(AlwaysPlayable(Mod.Settings.SanctionCardRequireWar,Mod.Settings.SanctionCardRequirePeace,Mod.Settings.SanctionCardRequireAlly))then
		UI.CreateLabel(rootParent).SetText('You can play a Sanction Card on everybody').SetColor('#FF0000');
	else
		if(NeverPlayable(Mod.Settings.SanctionCardRequireWar,Mod.Settings.SanctionCardRequirePeace,Mod.Settings.SanctionCardRequireAlly))then
			UI.CreateLabel(rootParent).SetText('Sanction Cards are unplayable').SetColor('#FF0000');
		else
			CreateLine('Sanction Cards can be played on players you are in war with : ', Mod.Settings.SanctionCardRequireWar,true,false);
			CreateLine('Sanction Cards can be played on players you are in peace with : ', Mod.Settings.SanctionCardRequirePeace,false,false);
			CreateLine('Sanction Cards can be played on players you are allied with : ', Mod.Settings.SanctionCardRequireAlly,false,false);
		end
	end
	UI.CreateLabel(rootParent).SetText('Bomb Card');
	if(AlwaysPlayable(Mod.Settings.BombCardRequireWar,Mod.Settings.BombCardRequirePeace,Mod.Settings.BombCardRequireAlly))then
		UI.CreateLabel(rootParent).SetText('You can play a Bomb Card on everybody').SetColor('#FF0000');
	else
		if(NeverPlayable(Mod.Settings.BombCardRequireWar,Mod.Settings.BombCardRequirePeace,Mod.Settings.BombCardRequireAlly))then
			UI.CreateLabel(rootParent).SetText('Bomb Cards are unplayable').SetColor('#FF0000');
		else
			CreateLine('Bomb Cards can be played on players you are in war with : ', Mod.Settings.BombCardRequireWar,true,false);
			CreateLine('Bomb Cards can be played on players you are in peace with : ', Mod.Settings.BombCardRequirePeace,false,false);
			CreateLine('Bomb Cards can be played on players you are allied with : ', Mod.Settings.BombCardRequireAlly,false,false);
		end
	end
	UI.CreateLabel(rootParent).SetText('Spy Card');
	if(AlwaysPlayable(Mod.Settings.SpyCardRequireWar,Mod.Settings.SpyCardRequirePeace,Mod.Settings.SpyCardRequireAlly))then
		UI.CreateLabel(rootParent).SetText('You can play a Spy Card on everybody').SetColor('#FF0000');
	else
		if(NeverPlayable(Mod.Settings.SpyCardRequireWar,Mod.Settings.SpyCardRequirePeace,Mod.Settings.SpyCardRequireAlly))then
			UI.CreateLabel(rootParent).SetText('Spy Cards are unplayable').SetColor('#FF0000');
		else
			CreateLine('Spy Cards can be played on players you are in war with : ', Mod.Settings.SpyCardRequireWar,true,false);
			CreateLine('Spy Cards can be played on players you are in peace with : ', Mod.Settings.SpyCardRequirePeace,false,false);
			CreateLine('Spy Cards can be played on players you are allied with : ', Mod.Settings.SpyCardRequireAlly,false,false);
		end
	end
	UI.CreateLabel(rootParent).SetText('Gift Card');
	if(AlwaysPlayable(Mod.Settings.GiftCardRequireWar,Mod.Settings.GiftCardRequirePeace,Mod.Settings.GiftCardRequireAlly))then
		UI.CreateLabel(rootParent).SetText('You can play a Gift Card on everybody').SetColor('#FF0000');
	else
		if(NeverPlayable(Mod.Settings.GiftCardRequireWar,Mod.Settings.GiftCardRequirePeace,Mod.Settings.GiftCardRequireAlly))then
			UI.CreateLabel(rootParent).SetText('Gift Cards are unplayable').SetColor('#FF0000');
		else
			CreateLine('Gift Cards can be played on players you are in war with : ', Mod.Settings.GiftCardRequireWar,false,false);
			CreateLine('Gift Cards can be played on players you are in peace with : ', Mod.Settings.GiftCardRequirePeace,true,false);
			CreateLine('Gift Cards can be played on players you are allied with : ', Mod.Settings.GiftCardRequireAlly,true,false);
		end
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
function NeverPlayable(warsetting,peacesetting,allysetting)
	if(peacesetting == nil and allysetting == nil)then
		return false;
	end
	if(peacesetting == false and allysetting  == false and warsetting == false)then
		return true;
	end
	return false;
end
