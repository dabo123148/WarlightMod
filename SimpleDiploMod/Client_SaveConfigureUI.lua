
function Client_SaveConfigureUI(alert)
  	Mod.Settings.AllowAIDeclaration = AIDeclerationcheckbox.GetIsChecked();
	if(Mod.Settings.AllowAIDeclaration == nil)then
		Mod.Settings.AllowAIDeclaration = true;
	end
	Mod.Settings.SeeAllyTerritories = SeeAllyTerritoriesCheckbox.GetIsChecked();
	if(Mod.Settings.SeeAllyTerritories == nil)then
		Mod.Settings.SeeAllyTerritories = true;
	end
	Mod.Settings.PublicAllies = PublicAlliesCheckbox.GetIsChecked();
	if(Mod.Settings.PublicAllies == nil)then
		Mod.Settings.PublicAllies = true;
	end
end
