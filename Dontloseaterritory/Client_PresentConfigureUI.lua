
function Client_PresentConfigureUI(rootParent)
	local initialValue = Mod.Settings.NoTerritory;
	if initialValue == nil then
		initialValue = false;
	end
    
    local horz = UI.CreateHorizontalLayoutGroup(rootParent);
  	  InputNoTerritory = UI.CreateCheckBox(horz)
		.SetText('Effect every territory.')
		.SetIsChecked(initialValue);
end
