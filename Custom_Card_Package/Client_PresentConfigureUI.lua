
function Client_PresentConfigureUI(rootParent)
    

    local horz1 = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(horz1).SetText('Pestilence Card');
	PestCardCheckbox=UI.CreateCheckBox(horz1);
	PestCardCheckbox.SetOnValueChanged(PestCardCheckBoxChanged);

end

function PestCardCheckBoxChanged()

end
