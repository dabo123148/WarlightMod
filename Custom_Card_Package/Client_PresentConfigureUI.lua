
function Client_PresentConfigureUI(rootParent)
   	root=rootParent;
   	 
   	local PestCardIninit=false;
	if(Mod.Settings.PestCardIn ~= nil)then
   		PestCardIninit=Mod.Settings.PestCardIn;
	end
    	local PestCardStrengthinit=1;
	if(Mod.Settings.PestCardStrength ~= nil)then
   		PestCardStrengthinit=Mod.Settings.PestCardStrength;
	end
	local PestCardPiecesNeededinit=11;
	if(Mod.Settings.PestCardPiecesNeeded ~= nil)then
   		PestCardPiecesNeededinit=Mod.Settings.PestCardPiecesNeeded;
	end
	local PestCardStartPiecesinit=11;
	if(Mod.Settings.PestCardStartPieces ~= nil)then
   		PestCardStartPiecesinit=Mod.Settings.PestCardStartPieces;
	end
	local horzlist = {};
	local horzlist[0] = UI.CreateHorizontalLayoutGroup(rootParent);
	PestCardCheckbox=UI.CreateCheckBox(horzlist[0]).SetText('Include Pestilence Card').SetIsChecked(PestCardIn).SetOnValueChanged(function() 
			UI.CreateLabel(horzlist[1]).SetText('Pestilence Card Strength:');
			PestCardStrengthSlider = UI.CreateNumberInputField(horzlist[1]).SetSliderMinValue(1).SetSliderMaxValue(3).SetValue(PestCardStrengthinit);
			UI.CreateLabel(horzlist[2]).SetText('Card Pieces Needed:');
			PestCardPiecesNeededBox=UI.CreateNumberInputField(horzlist[2]).SetSliderMinValue(1).SetSliderMaxValue(20).SetValue(PestCardPiecesNeeded);
			UI.CreateLabel(horzlist[3]).SetText('Card Pieces given at the beginning of the game:');
			PestCardStartPiecesBox=UI.CreateNumberInputField(horzlist[3]).SetSliderMinValue(0).SetSliderMaxValue(20).SetValue(PestCardStartPieces);
		end);
	local horzlist[1] = UI.CreateHorizontalLayoutGroup(rootParent);
	local horzlist[2] = UI.CreateHorizontalLayoutGroup(rootParent);
	local horzlist[3] = UI.CreateHorizontalLayoutGroup(rootParent);
	local horzlist[4] = UI.CreateHorizontalLayoutGroup(rootParent);
	--PestCardCheckbox=UI.CreateCheckBox(horzlist[0]).SetText('Include Nuke Card').SetIsChecked(PestCardIn).SetOnValueChanged(PestCardCheckBoxChanged);
end

function PestCardCheckBoxChanged()
	--PestCardStrength=1;
   	-- Mod.Settings.PestCardStrength=1;
   	-- PestCardStrengthSlider=nil;
		
   	-- PestCardPiecesNeeded=11;
   	-- Mod.Settings.PestCardPiecesNeeded=11;
   	-- PestCardPiecesNeededBox=nil;
		
   	-- PestCardStartPieces=0;
    	--Mod.Settings.PestCardStartPieces=0;
    	--PestCardStartPiecesBox=nil;
	--PestCardIn= not PestCardIn;
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
