
function Client_SaveConfigureUI(alert)
    Mod.Settings.AllowAIDeclaration = AIDeclerationcheckbox.GetIsChecked();
	if(Mod.Settings.AllowAIDeclaration == nil)then
		Mod.Settings.AllowAIDeclaration = true;
	end
end