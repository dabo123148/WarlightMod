
function Client_PresentConfigureUI(rootParent)
	local initialValue1 = Mod.Settings.PestilenceStrength;
	if initialValue1 == nil then initialValue1 = 1; end
    

    local horz1 = UI.CreateHorizontalLayoutGroup(vert);
	UI.CreateLabel(horz1).SetText('Pestilence Strength');
    numberInputField1 = UI.CreateNumberInputField(horz1)
		.SetSliderMinValue(0)
		.SetSliderMaxValue(200)
		.SetValue(initialValue1);


end