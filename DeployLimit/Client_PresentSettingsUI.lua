
function Client_PresentSettingsUI(rootParent)
	UI.CreateLabel(rootParent)
		.SetText('Max Deployment per territoriy ' .. Mod.Settings.MaxDeploy);
end

