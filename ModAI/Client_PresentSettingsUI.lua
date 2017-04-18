
function Client_PresentSettingsUI(rootParent)
	if(Mod.Settings.HasPestilence)then
		UI.CreateLabel(rootParent).SetText('AI supports Mod Pestilence (Made by melwei [PG])');
		UI.CreateLabel(rootParent).SetText('  Pestilence Strength: ' .. Mod.Settings.PestilenceStrength);
	end
end

