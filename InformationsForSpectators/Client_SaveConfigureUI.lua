
function Client_SaveConfigureUI(alert)
  	Mod.Settings.JustSpectator = inputJustSpectator.GetIsChecked();
	if(Mod.Settings.JustSpectator == nil)then
		Mod.Settings.JustSpectator = true;
	end
end
