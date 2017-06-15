
function Client_PresentConfigureUI(rootParent)
   	root=rootParent;
   	PestCardIninit=false;
	if(Mod.Settings.PestCardIn ~= nil)then
   		PestCardIninit=Mod.Settings.PestCardIn;
	end
    	PestCardStrengthinit=1;
	if(Mod.Settings.PestCardStrength ~= nil)then
   		PestCardStrengthinit=Mod.Settings.PestCardStrength;
	end
	PestCardPiecesNeededinit=11;
	if(Mod.Settings.PestCardPiecesNeeded ~= nil)then
   		PestCardPiecesNeededinit=Mod.Settings.PestCardPiecesNeeded;
	end
	PestCardStartPiecesinit=11;
	if(Mod.Settings.PestCardStartPieces ~= nil)then
   		PestCardStartPiecesinit=Mod.Settings.PestCardStartPieces;
	end
	horzlist = {};
	horzlist[0] = UI.CreateHorizontalLayoutGroup(rootParent);
	PestCardCheckbox=UI.CreateCheckBox(horzlist[0]).SetText('Include Pestilence Card').SetIsChecked(PestCardIninit).SetOnValueChanged(IncludeExcludePestilenzCard);
	horzlist[1] = UI.CreateHorizontalLayoutGroup(rootParent);
	horzlist[2] = UI.CreateHorizontalLayoutGroup(rootParent);
	horzlist[3] = UI.CreateHorizontalLayoutGroup(rootParent);
	horzlist[4] = UI.CreateHorizontalLayoutGroup(rootParent);
	if(PestCardIninit == true)then
		IncludeExcludePestilenzCard();
	end
	NukeCardIninit=false;
	if(Mod.Settings.NukeCardIn ~= nil)then
   		NukeCardIninit=Mod.Settings.NukeCardIn;
	end
	Friendlyfireinit=true;
	if(Mod.Settings.Friendlyfire ~= nil)then
   		Friendlyfireinit=Mod.Settings.Friendlyfire;
	end
	NukeCardPiecesNeededinit=11;
	if(Mod.Settings.NukeCardPiecesNeeded ~= nil)then
   		PestCardPiecesNeededinit=Mod.Settings.NukeCardPiecesNeeded;
	end
	NukeCardStartPiecesinit=11;
	if(Mod.Settings.NukeCardStartPieces ~= nil)then
   		PestCardStartPiecesinit=Mod.Settings.NukeCardStartPieces;
	end
	NukeCardMainTerritoryDamageinit=50;
	if(Mod.Settings.NukeCardMainTerritoryDamage ~= nil)then
   		NukeCardMainTerritoryDamageinit=Mod.Settings.NukeCardMainTerritoryDamage;
	end
	NukeCardConnectedTerritoryDamageinit=25;
	if(Mod.Settings.NukeCardConnectedTerritoryDamage ~= nil)then
   		NukeCardConnectedTerritoryDamageinit=Mod.Settings.NukeCardConnectedTerritoryDamage;
	end
	NukeCardCheckbox=UI.CreateCheckBox(horzlist[4]).SetText('Include Nuke Card - not included yet').SetIsChecked(NukeCardIninit).SetOnValueChanged(IncludeExcludeNukeCard);
	horzlist[5] = UI.CreateHorizontalLayoutGroup(rootParent);
	horzlist[6] = UI.CreateHorizontalLayoutGroup(rootParent);
	horzlist[7] = UI.CreateHorizontalLayoutGroup(rootParent);
	horzlist[8] = UI.CreateHorizontalLayoutGroup(rootParent);
	horzlist[9] = UI.CreateHorizontalLayoutGroup(rootParent);
	horzlist[10] = UI.CreateHorizontalLayoutGroup(rootParent);
	horzlist[11] = UI.CreateHorizontalLayoutGroup(rootParent);
	if(NukeCardIn==true)then
		IncludeExcludeNukeCard();
		if(Mod.Settings.AfterDeployment==true)then
			AfterDeploymentToggle.SetIsChecked(true);
			BeforeDeploymentToggle.SetIsChecked(false);
		else
			AfterDeploymentToggle.SetIsChecked(false);
			BeforeDeploymentToggle.SetIsChecked(true);
		end
	end
end
function IncludeExcludePestilenzCard()
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
		PestCardPiecesNeededBox=UI.CreateNumberInputField(horzlist[2]).SetSliderMinValue(1).SetSliderMaxValue(20).SetValue(PestCardPiecesNeededinit);
		text3 = UI.CreateLabel(horzlist[3]).SetText('Card Pieces given at the beginning of the game:');
		PestCardStartPiecesBox=UI.CreateNumberInputField(horzlist[3]).SetSliderMinValue(0).SetSliderMaxValue(20).SetValue(PestCardStartPiecesinit);
	end
end
function IncludeExcludeNukeCard()
	if(NukeCardMainTerritoryDamageSlider ~= nil)then
		UI.Destroy(text4);
		UI.Destroy(NukeCardMainTerritoryDamageSlider);
		UI.Destroy(NukeCardConnectedTerritoryDamageSlider);
		UI.Destroy(FriendlyfireToggle);
		UI.Destroy(AfterDeploymentToggle);
		UI.Destroy(BeforeDeploymentToggle);
		UI.Destroy(text5);
		UI.Destroy(NukeCardPiecesNeededBox);
		UI.Destroy(text6);
		UI.Destroy(NukeCardStartPiecesBox);
		UI.Destroy(text7);
		NukeCardMainTerritoryDamageSlider = nil;
	else
		text4 = UI.CreateLabel(horzlist[5]).SetText('Main Territory Damage in %:');
		NukeCardMainTerritoryDamageSlider = UI.CreateNumberInputField(horzlist[5]).SetSliderMinValue(1).SetSliderMaxValue(3).SetValue(NukeCardMainTerritoryDamageinit).SetWholeNumbers(true);
		text5 = UI.CreateLabel(horzlist[6]).SetText('Connected Territories Damage in %');
		NukeCardConnectedTerritoryDamageSlider = UI.CreateNumberInputField(horzlist[6]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(NukeCardConnectedTerritoryDamageinit).SetWholeNumbers(true);
		FriendlyfireToggle = UI.CreateCheckBox(horzlist[7]).SetText('Can harm yourself').SetIsChecked(Friendlyfireinit);
		AfterDeploymentToggle = UI.CreateCheckBox(horzlist[8]).SetText('After Deployment but before Gift and Blockade Cards').SetOnValueChanged(OnClickAfterDeployment);
		BeforeDeploymentToggle = UI.CreateCheckBox(horzlist[9]).SetText('Before Deployment').SetOnValueChanged(OnClickBeforeDeployment);
		text6 = UI.CreateLabel(horzlist[10]).SetText('Card Pieces Needed:');
		NukeCardPiecesNeededBox=UI.CreateNumberInputField(horzlist[10]).SetSliderMinValue(1).SetSliderMaxValue(20).SetValue(NukeCardPiecesNeededinit);
		text7 = UI.CreateLabel(horzlist[11]).SetText('Card Pieces given at the beginning of the game:');
		NukeCardStartPiecesBox=UI.CreateNumberInputField(horzlist[11]).SetSliderMinValue(0).SetSliderMaxValue(20).SetValue(NukeCardStartPiecesinit);
		if(Mod.Settings.AfterDeployment==nil)then
			AfterDeploymentToggle.SetIsChecked(true);
			BeforeDeploymentToggle.SetIsChecked(false);
		end
	end
end
function OnClickAfterDeployment()
	if(AfterDeploymentToggle.GetIsChecked())then
		BeforeDeploymentToggle.SetIsChecked(false);
	else
		BeforeDeploymentToggle.SetIsChecked(true);
	end
end
function OnClickBeforeDeployment()
	if(BeforeDeploymentToggle.GetIsChecked())then
		AfterDeploymentToggle.SetIsChecked(false);
	else
		AfterDeploymentToggle.SetIsChecked(true);
	end
end
