
function Client_PresentConfigureUI(rootParent)
	local initialValue = Mod.Settings.NoTerritory;
	if initialValue == nil then
		initialValue = true;
	end
    
    local horz = UI.CreateHorizontalLayoutGroup(rootParent);
  	  InputNoTerritory = UI.CreateCheckBox(horz)
		.SetText('If this is disabled, you lose the game once you lose any of your starting territories. If enabled, you lose the game if ANY of yours territories are taken.')
		.SetIsChecked(initialValue);
end
