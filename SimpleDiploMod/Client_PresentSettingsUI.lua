
function Client_PresentSettingsUI(rootParent)
	UI.CreateLabel(rootParent).SetText('AI Settings');
	if(Mod.Settings.AllowAIDeclaration)then
		UI.CreateLabel(rootParent).SetText('AIs are allowed to declare war on Player');
	else
		UI.CreateLabel(rootParent).SetText('AIs are not allowed to declare war on Player');
	end
	if(Mod.Settings.AIsdeclearAIs)then
		UI.CreateLabel(rootParent).SetText('AIs are allowed to declare war on AIs');
	else
		UI.CreateLabel(rootParent).SetText('AIs are not allowed to declare war AIs');
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
