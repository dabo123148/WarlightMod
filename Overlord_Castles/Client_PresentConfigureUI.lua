
function Client_PresentConfigureUI(rootParent)
	local initialValue1 = Mod.Settings.BonusValue;
	local initialValue2 = Mod.Settings.TroopValue;
	local initialValue3 = Mod.Settings.MaxBonus;
	local initialValue4 = Mod.Settings.Chance;
	local initialNegatives = Mod.Settings.AllowNegative;
	if initialValue1 == nil then initialValue1 = 50; end
	if initialValue2 == nil then initialValue2 = 100; end
	if initialValue3 == nil then initialValue3 = 1; end
	if initialValue4 == nil then initialValue4 = 30; end
	if initialNegatives == nil then initialNegatives = false; end
    
	local vert = UI.CreateVerticalLayoutGroup(rootParent);

    local horz1 = UI.CreateHorizontalLayoutGroup(vert);
	UI.CreateLabel(horz1).SetText('Overlord Castle Bonus Value');
    numberInputField1 = UI.CreateNumberInputField(horz1)
		.SetSliderMinValue(0)
		.SetSliderMaxValue(200)
		.SetValue(initialValue1);

	
    local horz2 = UI.CreateHorizontalLayoutGroup(vert);
	UI.CreateLabel(horz2).SetText('Overlord Castle Troop Value');
    numberInputField2 = UI.CreateNumberInputField(horz2)
		.SetSliderMinValue(0)
		.SetSliderMaxValue(200)
		.SetValue(initialValue2);

    local horz3 = UI.CreateHorizontalLayoutGroup(vert);
	UI.CreateLabel(horz3).SetText('Maximum Bonus Size');
    numberInputField3 = UI.CreateNumberInputField(horz3)
		.SetSliderMinValue(1)
		.SetSliderMaxValue(10)
		.SetValue(initialValue3);

	local horz4 = UI.CreateHorizontalLayoutGroup(vert);
	UI.CreateLabel(horz4).SetText('Chance of Small Bonuses turning into Overlord Castles (%)');
    numberInputField4 = UI.CreateNumberInputField(horz4)
		.SetSliderMinValue(0)
		.SetSliderMaxValue(100)
		.SetValue(initialValue4);

	UI.CreateLabel(vert).SetText("Normally, negative bonuses will not be modified.  However, you can check the \"Allow Negative Bonuses\" box to make this happen.");

	allowNegativeBonusesCheckBox = UI.CreateCheckBox(vert).SetText('Allow Negative Bonuses').SetIsChecked(initialNegatives);

end