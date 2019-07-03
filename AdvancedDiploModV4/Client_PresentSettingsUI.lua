
function Client_PresentSettingsUI(rootParent)
	root = rootParent;
	UI.CreateLabel(rootParent).SetText('AI Settings');
	CreateLine('AIs are allowed to declare war on player : ', Mod.Settings.AllowAIDeclaration,false,true,'With this enabled, AIs will declare war on players(players turned into AI are excluded). This happens pretty much like they normaly attack --> they will declare war mainly on their surrounding players but also on those that they try to play cards on. If this is disabled and you are in war with an AI(e.g. since a player got booted and turned into AI, it will continue to fight you.');
	CreateLine('AIs are allowed to declare war on AIs : ', Mod.Settings.AIsdeclearAIs,true,true,'With this enabled, AIs will declare war on other AIs or players turned into AI. This happens pretty much like they normaly attack --> they will declare war mainly on their surrounding players but also on those that they try to play cards on.');
	UI.CreateLabel(rootParent).SetText(' ');
	UI.CreateLabel(rootParent).SetText('Alliance Settings');
	if(Mod.Settings.DisableAllies == nil or Mod.Settings.DisableAllies == false)then
		CreateLine('Allied players can see your territories(requires spycards to be in the game) : ', Mod.Settings.SeeAllyTerritories,true,true,"If spycards are in the game and this feature is enabled, the mod automaticaly plays a spycard on all your allies so you can see their territories, this does not effect the lower setting that effects the normal playing of spycards on allies. For that it will not use your spycards.);
		CreateLine('Allies are visible to everyone : ', Mod.Settings.PublicAllies,true,true,'This setting makes alliances be announced to everyone and visible in everyones history if set to true, otherwise it will only be visible for the players that made the alliance);
	else
		UI.CreateLabel(root).SetText("Alliances are disabled").SetColor('#FF0000');
	end
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
			if(Mod.Settings.DisableAllies == nil or Mod.Settings.DisableAllies == false)then
				CreateLine('Sanction Cards can be played on players you are allied with : ', Mod.Settings.SanctionCardRequireAlly,false,false);
			end
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
			if(Mod.Settings.DisableAllies == nil or Mod.Settings.DisableAllies == false)then
				CreateLine('Bomb Cards can be played on players you are allied with : ', Mod.Settings.BombCardRequireAlly,false,false);
			end
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
			if(Mod.Settings.DisableAllies == nil or Mod.Settings.DisableAllies == false)then
				CreateLine('Spy Cards can be played on players you are allied with : ', Mod.Settings.SpyCardRequireAlly,false,false);
			end	
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
			if(Mod.Settings.DisableAllies == nil or Mod.Settings.DisableAllies == false)then
				CreateLine('Gift Cards can be played on players you are allied with : ', Mod.Settings.GiftCardRequireAlly,true,false);
			end
		end
	end
end
function CreateLine(settingname,variable,default,important, help)
	local horz = UI.CreateHorizontalLayoutGroup(root);
	local lab = UI.CreateLabel(horz);
	if(default == true or default == false)then
		if(help ~= null)then
			lab.SetText(settingname);
			UI.CreateButton(horz).SetText('?').SetColor('#0080ff').SetOnClick(function() UI.Alert(help); end);
			lab = UI.CreateLabel(horz);
			lab.SetText(booltostring(variable,default));
		else
			lab.SetText(settingname .. booltostring(variable,default));
		end
	else
		if(variable == nil)then
			if(help ~= null)then
				lab.SetText(settingname);
				UI.CreateButton(horz).SetText('?').SetColor('#0080ff').SetOnClick(function() UI.Alert(help); end);
				lab = UI.CreateLabel(horz);
				lab.SetText(default);
			else
				lab.SetText(settingname .. default);
			end
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
	if(Mod.Settings.DisableAllies == nil or Mod.Settings.DisableAllies == false)then
		if(peacesetting == false and allysetting  == false and warsetting == false)then
			return true;
		end
	else
		if(peacesetting == false and warsetting == false)then
			return true;
		end
	end
	return false;
end
