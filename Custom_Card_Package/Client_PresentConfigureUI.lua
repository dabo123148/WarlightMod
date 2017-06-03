
function Client_PresentConfigureUI(rootParent)
	local initialValue1 = Mod.Settings.PestilenceStrength;
	if initialValue1 == nil then initialValue1 = 1; end
    

    local horz1 = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(horz1).SetText('Pestilence Card');
	PestCardCheckbox=horz1.CreateCheckBox;
	PestCardCheckbox.OnValueChanged=PestCardCheckBoxChanged;

end

function PestCardCheckBoxChanged(){

}