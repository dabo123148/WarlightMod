
function Client_SaveConfigureUI(alert)
    Mod.Settings.MaxDeploy = InputMaxDeploy.GetValue();
	if( Mod.Settings.MaxDeploy == nil)then
		Mod.Settings.MaxDeploy = 5;
	end
	if( Mod.Settings.MaxDeploy < 1)then
		alert('With this Settings, it is impossible to deploy armies.');
	end
	if( Mod.Settings.MaxDeploy > 100000)then
		alert('The number is too big.');
	end
end