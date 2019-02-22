
function Client_PresentConfigureUI(rootParent)
	local Stacklimitsizeinit = Mod.Settings.StackLimit;
	if Stacklimitsizeinit == nil then Stacklimitsizeinit = 20; end
    EffectsNeutralinit = Mod.Settings.EffectsNeutralinit;
	if(EffectsNeutralinit == nil)then
		EffectsNeutralinit = true;
	end

    local horz1 = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(horz1).SetText('Max Stack Size:');
    StackLimitInputfield = UI.CreateNumberInputField(horz1)
		.SetSliderMinValue(2)
		.SetSliderMaxValue(100)
		.SetValue(Stacklimitsizeinit);
	EffectsNeutralCheckBox = UI.CreateCheckBox(horz1).SetText('Also apply stacklimit to neutral territories').SetIsChecked(EffectsNeutralinit);

end