
function Client_PresentSettingsUI(rootParent)
	UI.CreateLabel(rootParent)
		.SetText('Commanderplayer StartArmies: ' .. Mod.Settings.StartArmies);
end

