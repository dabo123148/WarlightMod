
function Client_PresentConfigureUI(rootParent)
	--Mod Pestilence
	local PestilenceInit = Mod.Settings.HasPestilence;
    local horz = UI.CreateHorizontalLayoutGroup(rootParent);
	PestilenceEnabled = UI.CreateCheckBox(horz).SetText('Support for Mod Pestilence(made by melwei [PG]) enabled').SetIsChecked(PestilenceInit);
	--Pestilence Settings
	local initialValue1 = Mod.Settings.PestilenceStrength;
	if initialValue1 == nil then initialValue1 = 1; end
    local horz1 = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(horz1).SetText('Pestilence Strength');
    numberInputField1 = UI.CreateNumberInputField(horz1)
		.SetSliderMinValue(1)
		.SetSliderMaxValue(5)
		.SetValue(initialValue1);
end