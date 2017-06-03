
function Client_PresentConfigureUI(rootParent)
    local PestCardIn=false;
    root=rootParent;
    local vert1 = UI.CreateVerticalLayoutGroup(rootParent);
    PestCardCheckbox=UI.CreateCheckBox(vert1).SetText('Include Pestilence Card').SetIsChecked(PestCardIn).SetOnValueChanged(PestCardCheckBoxChanged);

end

function PestCardCheckBoxChanged()
    local vert = UI.CreateVerticalLayoutGroup(root);
    local PestStrength=1;
    PestCardStrength=UI.CreateNumberInputField(vert).SetSliderMinValue(1).SetSliderMaxValue(3).SetValue(PestStrength);
	
end
