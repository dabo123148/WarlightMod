
function Client_PresentSettingsUI(rootParent)
	if(Mod.Settings.NoTerritory ~= nil)then
		if(Mod.Settings.NoTerritory)then
			UI.CreateLabel(rootParent)
			.SetText('If a player loses any territory, he has lost');
		else
			UI.CreateLabel(rootParent)
			.SetText('If a player loses a starting territory, he has lost');
		end
	else
		UI.CreateLabel(rootParent)
		.SetText('Cause this game runs with an old version of the Mod, no player is allowed to lose their starting regions');
	end
end

