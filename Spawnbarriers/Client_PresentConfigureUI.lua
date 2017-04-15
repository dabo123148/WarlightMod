

function Client_PresentConfigureUI(rootParent)
	local initialValue = Mod.Settings.ConnectedArmyNumber;
	if initialValue == nil then
		initialValue = 5;
	end
    
    local horz = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(horz).SetText('Connected Starting Territory Armies ');
    InputConnectedArmyNum = UI.CreateNumberInputField(horz)
		.SetSliderMinValue(0)
		.SetSliderMaxValue(100)
		.SetValue(initialValue);
	local initialValue2 = Mod.Settings.Radius;
	if initialValue2 == nil then
		initialValue2 = 1;
	end
	local horz2 = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(horz2).SetText('Effect Radius ');
    InputRadius = UI.CreateNumberInputField(horz2)
		.SetSliderMinValue(1)
		.SetSliderMaxValue(3)
		.SetValue(initialValue2);
end
