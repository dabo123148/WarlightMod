
function Client_PresentConfigureUI(rootParent)
	local AIDeclerationinit = Mod.Settings.AllowAIDeclaration;
	if(AIDeclerationinit == nil)then
		AIDeclerationinit = true;
	end
	UI.CreateHorizontalLayoutGroup(rootParent).UI.CreateLabel.SetText('AI Settings');
    local horz = UI.CreateHorizontalLayoutGroup(rootParent);
	AIDeclerationcheckbox = UI.CreateCheckBox(horz).SetText('Are AIs allowed to declear war').SetIsChecked(AIDeclerationinit);
end