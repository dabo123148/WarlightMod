
function Client_SaveConfigureUI(alert)
    Mod.Settings.HasPestilence = PestilenceEnabled.GetIsChecked();
	if(Mod.Settings.HasPestilence == nil)then
		Mod.Settings.HasPestilence = false;
	end
	if(Mod.Settings.HasPestilence)then
		Mod.Settings.PestilenceStrength = numberInputField1.GetValue();
		if(Mod.Settings.PestilenceStrength == nil)then
			Mod.Settings.PestilenceStrength = 1;
		end
		if(Mod.Settings.PestilenceStrength <1)then
			Mod.Settings.PestilenceStrength = 1;
		end
		if(Mod.Settings.PestilenceStrength >100000)then
			Mod.Settings.PestilenceStrength = 100000;
		end
		print(Mod.Settings.PestilenceStrength);
	end
end