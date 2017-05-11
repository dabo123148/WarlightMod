
function Client_SaveConfigureUI(alert)
    Mod.Settings.MainTerritoryDamage = inputMainTerritoryDamage.GetValue();
	Mod.Settings.ConnectedTerritoryDamage = inputConnectedTerritoryDamage.GetValue();
	if(Mod.Settings.MainTerritoryDamage > 1 or Mod.Settings.ConnectedTerritoryDamage>1)then
		alert('More than 100% Damage is impossible')
	end
	if(Mod.Settings.MainTerritoryDamage < 0 or Mod.Settings.ConnectedTerritoryDamage<0)then
		alert('To be fair, I deactivate negative Damage')
	end
end
