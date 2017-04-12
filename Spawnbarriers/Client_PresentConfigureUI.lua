
function Client_PresentConfigureUI(rootParent)
	local initialValue = Mod.Settings.ConnectedArmyNumber;
	if initialValue == nil then
		initialValue = 5;
	end
    
    local horz = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(horz).SetText('Connected Starting Regions Armies ');
    InputConnectedArmyNum = UI.CreateNumberInputField(horz)
		.SetSliderMinValue(0)
		.SetSliderMaxValue(100)
		.SetValue(initialValue);

end
