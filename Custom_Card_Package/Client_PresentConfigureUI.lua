
function Client_PresentConfigureUI(rootParent)
    local PestCardIn=false;

    local horz1 = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(horz1).SetText('Pestilence Card');
	PestCardCheckbox=UI.CreateCheckBox(horz1).SetText('Include Pestilence Card').SetIsChecked(PestCardIn).SetOnValueChanged(PestCardCheckBoxChanged);

end

function PestCardCheckBoxChanged()

end
