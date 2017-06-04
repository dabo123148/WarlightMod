
function Client_PresentSettingsUI(rootParent)
	if(Mod.Settings.PestCardIn)then
		local vertPest = UI.CreateVerticalLayoutGroup(rootParent);
		UI.CreateLabel(vertPest).SetText('Pestilence Card Settings:');
		UI.CreateLabel(vertPest).SetText('	Strength: ' .. Mod.Settings.PestCardStrength);
		UI.CreateLabel(vertPest).SetText('	Card Pieces Needed: ' .. Mod.Settings.PestCardPiecesNeeded);
		UI.CreateLabel(vertPest).SetText('	Card Pieces Given in the beginning of the game: ' .. Mod.Settings.PestCardStartPieces);
		
	end
end

