
function Client_PresentSettingsUI(rootParent)
	local vert = UI.CreateVerticalLayoutGroup(rootParent);
	
	UI.CreateLabel(vert).SetText('Overlord Castle Bonus Value:' .. Mod.Settings.BonusValue);
	UI.CreateLabel(vert).SetText('Overlord Castle Troop Value:' .. Mod.Settings.TroopValue);
	UI.CreateLabel(vert).SetText('Maximum Bonus Size:' .. Mod.Settings.MaxBonus);
	UI.CreateLabel(vert).SetText('Allow negative: ' .. tostring(Mod.Settings.AllowNegative));
end

