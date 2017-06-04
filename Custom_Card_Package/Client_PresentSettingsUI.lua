
function Client_PresentSettingsUI(rootParent)
	if(Mod.Settings.PestCardIn)then
		local vertPest1 = UI.CreateVerticalLayoutGroup(rootParent);
		UI.CreateLabel(vertPest1).SetText('Pestilence Card Settings:');
		UI.CreateLabel(vertPest1).SetText('	Strength: ' .. Mod.Settings.PestCardStrength);
		UI.CreateLabel(vertPest1).SetText('	Card Pieces Needed: ' .. Mod.Settings.PestCardPiecesNeeded);
		UI.CreateLabel(vertPest1).SetText('	Card Pieces Given in the beginning of the game: ' .. Mod.Settings.PestCardStartPieces);
		
	end
end

