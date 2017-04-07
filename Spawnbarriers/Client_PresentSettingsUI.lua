
function Client_PresentSettingsUI(rootParent)
	UI.CreateLabel(rootParent)
		.SetText('Connected Starting Regions Armies ' .. Mod.Settings.ConnectedArmyNumber);
end

