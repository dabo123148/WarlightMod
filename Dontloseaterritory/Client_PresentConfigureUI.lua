
function Client_PresentConfigureUI(rootParent)
	local initialValue = Mod.Settings.NoTerritory;
	if initialValue == nil then
		initialValue = true;
	end
    
    local horz = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(horz).SetText('No Territory. If it is set to false, a player has lost if he loses a starting region else, he has lost, when he lost any territory');
  	  InputNoTerritory = UI.CreateCheckBox(horz)
		.SetIsChecked(initialValue);
end
