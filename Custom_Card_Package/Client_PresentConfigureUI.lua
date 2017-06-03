
function Client_PresentConfigureUI(rootParent)
    root=rootParent;
    
    PestCardIn=false;
    Mod.Settings.PestCardIn=false;
	
    PestCardStrength=1;
    Mod.Settings.PestCardStrength=1;
    PestCardStrengthSlider=nil;
	
    PestCardPiecesNeeded=11;
    Mod.Settings.PestCardPiecesNeeded=11;
    PestCardPiecesNeededBox=nil;
	
    PestCardStartPieces=0;
    Mod.Settings.PestCardStartPieces=0;
    PestCardStartPiecesBox=nil;
    
    vertPest = UI.CreateVerticalLayoutGroup(rootParent);
    PestCardCheckbox=UI.CreateCheckBox(vertPest).SetText('Include Pestilence Card').SetIsChecked(PestCardIn).SetOnValueChanged(PestCardCheckBoxChanged);
    
end

function PestCardCheckBoxChanged()
    PestCardIn= not PestCardIn;
    if(PestCardIn) then
        PestCardStrengthSlider=UI.CreateNumberInputField(vertPest).SetSliderMinValue(1).SetSliderMaxValue(3).SetValue(PestCardStrength).SetText('Pestilence Card Strength');
	PestCardPiecesNeededBox=UI.CreateNumberInputField(vertPest).SetSliderMinValue(1).SetSliderMaxValue(20).SetValue(PestCardPiecesNeeded);
	PestCardStartPiecesBox=UI.CreateNumberInputField(vertPest).SetSliderMinValue(0).SetSliderMaxValue(20).SetValue(PestCardStartPieces);
	Mod.Settings.PestCardIn=true;
    else
	UI.Destroy(PestCardStrengthSlider);
	UI.Destroy(PestCardPiecesNeededBox);
	UI.Destroy(PestCardStartPiecesBox);
	Mod.Settings.PestCardIn=false;
    end
end
