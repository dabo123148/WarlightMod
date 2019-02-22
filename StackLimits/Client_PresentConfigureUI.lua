
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
	local horz2 = UI.CreateHorizontalLayoutGroup(rootParent);
	EffectsNeutralCheckBox = UI.CreateCheckBox(horz2).SetText('Also apply stacklimit to neutral territories').SetIsChecked(EffectsNeutralinit);

end