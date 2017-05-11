
function Client_PresentConfigureUI(rootParent)
	local initialValue1 = Mod.Settings.MainTerritoryDamage;
	if initialValue1 == nil then initialValue1 = 0.5; end
    

    local horz1 = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(horz1).SetText('Main Territory Damage in %');
    inputMainTerritoryDamage = UI.CreateNumberInputField(horz1)
		.SetSliderMinValue(0)
		.SetSliderMaxValue(1)
		.SetValue(initialValue1)
		.SetWholeNumbers(false);

	local initialValue2 = Mod.Settings.ConnectedTerritoryDamage;
	if initialValue2 == nil then initialValue2 = 0.25; end

	horz1 = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(horz1).SetText('Connected Territory Damage in %');
    inputConnectedTerritoryDamage = UI.CreateNumberInputField(horz1)
		.SetSliderMinValue(0)
		.SetSliderMaxValue(1)
		.SetValue(initialValue2)
		.SetWholeNumbers(false);

end