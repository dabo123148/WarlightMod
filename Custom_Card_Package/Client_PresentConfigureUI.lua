
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
	lab1=UI.CreateLabel(vertPest).SetText('Pestilence Card Strength:');
        PestCardStrengthSlider=UI.CreateNumberInputField(vertPest).SetSliderMinValue(1).SetSliderMaxValue(3).SetValue(PestCardStrength);
	
	lab2=UI.CreateLabel(vertPest).SetText('Card Pieces Needed:');
	PestCardPiecesNeededBox=UI.CreateNumberInputField(vertPest).SetSliderMinValue(1).SetSliderMaxValue(20).SetValue(PestCardPiecesNeeded);
	
	lab3=UI.CreateLabel(vertPest).SetText('Card Pieces given at the beginning of the game:');
	PestCardStartPiecesBox=UI.CreateNumberInputField(vertPest).SetSliderMinValue(0).SetSliderMaxValue(20).SetValue(PestCardStartPieces);
	Mod.Settings.PestCardIn=true;
    else
	UI.Destroy(PestCardStrengthSlider);
	UI.Destroy(PestCardPiecesNeededBox);
	UI.Destroy(PestCardStartPiecesBox);
	UI.Destroy(lab1);
	UI.Destroy(lab2);
	UI.Destroy(lab3);
	Mod.Settings.PestCardIn=false;
    end
end
