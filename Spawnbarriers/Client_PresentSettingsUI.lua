function Client_PresentSettingsUI(rootParent)
	UI.CreateLabel(rootParent)
		.SetText('Connected Starting Regions Armies: ' .. Mod.Settings.ConnectedArmyNumber);
	UI.CreateLabel(rootParent)
		.SetText('Effect Radius: ' .. Mod.Settings.Radius);
end

