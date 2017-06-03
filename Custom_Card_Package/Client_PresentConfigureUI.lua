
function Client_PresentConfigureUI(rootParent)
    local PestCardIn=false;

    local vert1 = UI.CreateVerticalLayoutGroup(rootParent);
    PestCardCheckbox=UI.CreateCheckBox(horz1).SetText('Include Pestilence Card').SetIsChecked(PestCardIn).SetOnValueChanged(PestCardCheckBoxChanged(rootParent));

end

function PestCardCheckBoxChanged(rootParent)
    local vert = UI.CreateVerticalLayoutGroup(rootParent);
    local PestStrength=1;
    PestCardStrength=UI.CreateNumberInputField(vert).SetSliderMinValue(1).SetSliderMaxValue(3).SetValue(PestStrength);
	
end
