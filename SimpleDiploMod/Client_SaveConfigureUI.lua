
function Client_SaveConfigureUI(alert)
  	Mod.Settings.AllowAIDeclaration = AIDeclerationcheckbox.GetIsChecked();
	if(Mod.Settings.AllowAIDeclaration == nil)then
		Mod.Settings.AllowAIDeclaration = true;
	end
	Mod.Settings.AIsdeclearAIs = AIsdeclearAIsinitcheckbox.GetIsChecked();
	if(Mod.Settings.AIsdeclearAIs == nil)then
		Mod.Settings.AIsdeclearAIs = true;
	end
	Mod.Settings.SeeAllyTerritories = SeeAllyTerritoriesCheckbox.GetIsChecked();
	if(Mod.Settings.SeeAllyTerritories == nil)then
		Mod.Settings.SeeAllyTerritories = true;
	end
	Mod.Settings.PublicAllies = PublicAlliesCheckbox.GetIsChecked();
	if(Mod.Settings.PublicAllies == nil)then
		Mod.Settings.PublicAllies = true;
	end
	Mod.Settings.StartMoney = inputStartMoney.GetValue();
	if(Mod.Settings.StartMoney == nil)then
		Mod.Settings.StartMoney = 100;
	end
	if(Mod.Settings.StartMoney >10000)then
		alert('Start Money is too high');
	end
end
