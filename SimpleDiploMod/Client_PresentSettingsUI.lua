
function Client_PresentSettingsUI(rootParent)
	UI.CreateLabel(rootParent).SetText('AI Settings');
	UI.CreateLabel(rootParent).SetText('AIs are allowed to declare war on player : ' .. booltostring(Mod.Settings.AllowAIDeclaration));
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
	UI.CreateLabel(rootParent).SetText('Cards that require War');
	UI.CreateLabel(rootParent).SetText('Sanction Cards can only be played on players you are in war with : ' .. booltostring(Mod.Settings.SanctionCardRequireWar));
	UI.CreateLabel(rootParent).SetText('Bomb Cards can only be played on players you are in war with : ' .. booltostring(Mod.Settings.BombCardRequireWar));
	UI.CreateLabel(rootParent).SetText(' ');
	UI.CreateLabel(rootParent).SetText('Other Settings');
	UI.CreateLabel(rootParent).SetText('dabo1 has access to all data for fixing bugs and other diagnostic functions runtime : ' .. booltostring(Mod.Settings.AdminAccess));
end
function booltostring(variable)
	if(variable == nil)then
		return "No";
	end
	if(variable)then
		return "Yes";
	else
		return "No";
	end
end
