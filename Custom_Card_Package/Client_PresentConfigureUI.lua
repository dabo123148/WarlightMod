
function Client_PresentConfigureUI(rootParent)
    root=rootParent;
    
    PestCardIn=false;
    PestCardStrength=1;
    PestCardStrengthSlider=nil;
    PestCardPiecesNeeded=
    PestCardPiecesNeededBox=
    vertPest = UI.CreateVerticalLayoutGroup(rootParent);
    PestCardCheckbox=UI.CreateCheckBox(vertPest).SetText('Include Pestilence Card').SetIsChecked(PestCardIn).SetOnValueChanged(PestCardCheckBoxChanged);
    
end

function PestCardCheckBoxChanged()
    PestCardIn= not PestCardIn;
    if(PestCardIn) then
        PestCardStrengthSlider=UI.CreateNumberInputField(vertPest).SetSliderMinValue(1).SetSliderMaxValue(3).SetValue(PestCardStrength);
    else
	UI.Destroy(PestCardStrengthSlider);
    end
end
