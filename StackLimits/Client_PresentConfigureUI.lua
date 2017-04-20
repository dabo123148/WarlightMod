
function Client_PresentConfigureUI(rootParent)
	local initialValue1 = Mod.Settings.StackLimit;
	if initialValue1 == nil then initialValue1 = 1; end
    

    local horz1 = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(horz1).SetText('Max Stack Size:');
    numberInputField1 = UI.CreateNumberInputField(horz1)
		.SetSliderMinValue(2)
		.SetSliderMaxValue(100)
		.SetValue(initialValue1);


end