
function Client_PresentConfigureUI(rootParent)
	local initialValue = Mod.Settings.NoTerritory;
	if initialValue == nil then
		initialValue = true;
	end
    
    local horz = UI.CreateHorizontalLayoutGroup(rootParent);
  	  InputNoTerritory = UI.CreateCheckBox(horz)
		.SetText('If this is disabled, a player has lost if a player takes one of his starting territories, else he has also lost if any of his territories is taken.')
		.SetIsChecked(initialValue);
end
