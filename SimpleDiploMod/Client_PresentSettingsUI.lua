
function Client_PresentSettingsUI(rootParent)
	if(Mod.Settings.AllowAIDeclaration)then
		UI.CreateLabel(rootParent).SetText('AIs are allowed to declare war');
	else
		UI.CreateLabel(rootParent).SetText('AIs are not allowed to declare war');
	end
	if(Mod.Settings.SeeAllyTerritories)then
		UI.CreateLabel(rootParent).SetText('Allied Players can see your territories');
	else
		UI.CreateLabel(rootParent).SetText('Allied Players can not see your territories');
	end
	if(Mod.Settings.PublicAllies)then
		UI.CreateLabel(rootParent).SetText('Allies are visible to everyone');
	else
		UI.CreateLabel(rootParent).SetText('Just you and your ally can see your allianze');
	end
	UI.CreateLabel(rootParent).SetText('Player start with ' .. Mod.Settings.StartMoney .. ' Money');
end
