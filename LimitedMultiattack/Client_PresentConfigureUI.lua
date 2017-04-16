
function Client_PresentConfigureUI(rootParent)
	local initialValue = Mod.Settings.MaxAttacks;
	if initialValue == nil then
		initialValue = 5;
	end
    
    local horz = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(horz).SetText('Attacks per Multiattack ');
    InputMaxAttacks = UI.CreateNumberInputField(horz)
		.SetSliderMinValue(1)
		.SetSliderMaxValue(100)
		.SetValue(initialValue);

end