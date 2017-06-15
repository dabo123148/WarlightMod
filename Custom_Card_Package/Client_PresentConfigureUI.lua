
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
	horzlist[0] = UI.CreateHorizontalLayoutGroup(rootParent);
	PestCardCheckbox=UI.CreateCheckBox(horzlist[0]).SetText('Include Pestilence Card').SetIsChecked(PestCardIn).SetOnValueChanged(function() 
			if(PestCardStrengthSlider ~= nil)then
				UI.Destroy(text1);
				UI.Destroy(PestCardStrengthSlider);
				UI.Destroy(text2);
				UI.Destroy(PestCardPiecesNeededBox);
				UI.Destroy(text3);
				UI.Destroy(PestCardStartPiecesBox);
				PestCardStrengthSlider = nil;
			else
				text1 = UI.CreateLabel(horzlist[1]).SetText('Pestilence Card Strength:');
				PestCardStrengthSlider = UI.CreateNumberInputField(horzlist[1]).SetSliderMinValue(1).SetSliderMaxValue(3).SetValue(PestCardStrengthinit);
				text2 = UI.CreateLabel(horzlist[2]).SetText('Card Pieces Needed:');
				PestCardPiecesNeededBox=UI.CreateNumberInputField(horzlist[2]).SetSliderMinValue(1).SetSliderMaxValue(20).SetValue(PestCardPiecesNeeded);
				text3 = UI.CreateLabel(horzlist[3]).SetText('Card Pieces given at the beginning of the game:');
				PestCardStartPiecesBox=UI.CreateNumberInputField(horzlist[3]).SetSliderMinValue(0).SetSliderMaxValue(20).SetValue(PestCardStartPieces);
			end
		end);
	horzlist[1] = UI.CreateHorizontalLayoutGroup(rootParent);
	horzlist[2] = UI.CreateHorizontalLayoutGroup(rootParent);
	horzlist[3] = UI.CreateHorizontalLayoutGroup(rootParent);
	horzlist[4] = UI.CreateHorizontalLayoutGroup(rootParent);
	--PestCardCheckbox=UI.CreateCheckBox(horzlist[0]).SetText('Include Nuke Card').SetIsChecked(PestCardIn).SetOnValueChanged(PestCardCheckBoxChanged);
end
