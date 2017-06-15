
function Client_SaveConfigureUI(alert)
   	Mod.Settings.MainTerritoryDamage = inputMainTerritoryDamage.GetValue();
	Mod.Settings.ConnectedTerritoryDamage = inputConnectedTerritoryDamage.GetValue();
	Mod.Settings.Friendlyfire = InputFriendlyfire.GetIsChecked();
	Mod.Settings.AfterDeployment = InputAfterDeployment.GetIsChecked();
	if(Mod.Settings.MainTerritoryDamage > 100 or Mod.Settings.ConnectedTerritoryDamage>100)then
		alert('More than 100% Damage is impossible')
	end
	if(Mod.Settings.MainTerritoryDamage < 0 or Mod.Settings.ConnectedTerritoryDamage<0)then
		alert('To be fair, I deactivate negative Damage')
	end
	if(Mod.Settings.Alertshown==nil)then
		alert('This Mod has been Moved to the Mod custom card package. If you still want to create a game with this version, simply repress the submit button');
	end
	Mod.Settings.Alertshown = true;
end
