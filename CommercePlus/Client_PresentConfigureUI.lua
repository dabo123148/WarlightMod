
function Client_PresentConfigureUI(rootParent)
	rootParentobj = rootParent;
	MoneyPerTurninit = Mod.Settings.MoneyPerTurn;
	if(MoneyPerTurninit == nil)then
		MoneyPerTurninit = 5;
	end
	MoneyPerKilledArmyinit = Mod.Settings.MoneyPerKilledArmy;
	if(MoneyPerKilledArmyinit == nil)then
		MoneyPerKilledArmyinit = 1;
	end
	MoneyPerCapturedTerritoryinit = Mod.Settings.MoneyPerCapturedTerritory;
	if(MoneyPerCapturedTerritoryinit == nil)then
		MoneyPerCapturedTerritoryinit = 5;
	end
	MoneyPerCapturedBonusinit = Mod.Settings.MoneyPerCapturedBonus;
	if(MoneyPerCapturedBonusinit == nil)then
		MoneyPerCapturedBonusinit = 10;
	end
	ShowUI();
end
function ShowUI()
	horzlist = {};
	horzlist[1] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horzlist[1]).SetText('Money per killed army');
	inputMoneyPerKilledArmy = UI.CreateNumberInputField(horzlist[2]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(MoneyPerKilledArmyinit);
	horzlist[2] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horzlist[2]).SetText('Money per captured territory');
	inputMoneyPerCapturedTerritory = UI.CreateNumberInputField(horzlist[3]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(MoneyPerCapturedTerritoryinit);
	horzlist[3] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horzlist[3]).SetText('Money per captured bonus');
	inputMoneyPerCapturedBonus = UI.CreateNumberInputField(horzlist[4]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(MoneyPerCapturedBonusinit);
end