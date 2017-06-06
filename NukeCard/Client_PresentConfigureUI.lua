
function Client_PresentConfigureUI(rootParent)
	local initialValue1 = Mod.Settings.MainTerritoryDamage;
	if initialValue1 == nil then initialValue1 = 50; end
    

   	local horz1 = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(horz1).SetText('Main Territory Damage in %');
    	inputMainTerritoryDamage = UI.CreateNumberInputField(horz1)
		.SetSliderMinValue(0)
		.SetSliderMaxValue(100)
		.SetValue(initialValue1)
		.SetWholeNumbers(true);

	local initialValue2 = Mod.Settings.ConnectedTerritoryDamage;
	if initialValue2 == nil then initialValue2 = 25; end

	horz1 = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(horz1).SetText('Connected Territories Damage in %');
   	inputConnectedTerritoryDamage = UI.CreateNumberInputField(horz1)
		.SetSliderMinValue(0)
		.SetSliderMaxValue(100)
		.SetValue(initialValue2)
		.SetWholeNumbers(true);
	
	local initFriendlyfire = Mod.Settings.Friendlyfire;
	if initFriendlyfire == nil then initFriendlyfire = true; end
	
	horz1 = UI.CreateHorizontalLayoutGroup(rootParent);
  	InputFriendlyfire = UI.CreateCheckBox(horz1).SetText('Can harm yourself').SetIsChecked(initFriendlyfire);
	
	local initAfterDeployment = Mod.Settings.Friendlyfire;
	if initAfterDeployment == nil then initAfterDeployment = true; end
	
	horz1 = UI.CreateHorizontalLayoutGroup(rootParent);
  	InputAfterDeployment = UI.CreateCheckBox(horz1).SetText('After Deployment but before Gift Cards').SetOnValueChanged(OnClickAfterDeployment);
	horz1 = UI.CreateHorizontalLayoutGroup(rootParent);
  	InputBeforeDeployment = UI.CreateCheckBox(horz1).SetText('Before Deployment').SetOnValueChanged(OnClickBeforeDeployment);
	if(initAfterDeployment == true)then
		InputAfterDeployment.SetIsChecked(true);
		InputBeforeDeployment.SetIsChecked(false);
	else
		InputAfterDeployment.SetIsChecked(false);
		InputBeforeDeployment.SetIsChecked(true);
	end
end
function OnClickAfterDeployment()
	if(InputAfterDeployment.GetIsChecked())then
		InputBeforeDeployment.SetIsChecked(false);
	else
		InputBeforeDeployment.SetIsChecked(true);
	end
end
function OnClickBeforeDeployment()
	if(InputBeforeDeployment.GetIsChecked())then
		InputAfterDeployment.SetIsChecked(false);
	else
		InputAfterDeployment.SetIsChecked(true);
	end
end
