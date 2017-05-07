
function Client_PresentSettingsUI(rootParent)
	if(Mod.Settings.AllowAIDeclaration)then
		UI.CreateLabel(rootParent).SetText('AIs are allowed to declear war');
	else
		UI.CreateLabel(rootParent).SetText('AIs are not allowed to declear war');
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
	local ShowenIDs = {};
	for _, PID in pairs(AllPlayerIDs)do
		for _, PID2 in pairs(AllPlayerIDs)do
			if(War[PID][PID2] == true)then
				local Match = false;
				for _, SID in pairs(ShowenIDs)do
					if(SID == PID2)then
						Match = true;
					end
				end
				if(Match == false)then
					UI.CreateLabel(rootParent).SetText(PID .." is in war with " PID2);
				end
			end
		end
		ShowenIDs[tablelength(ShowenIDs)] = PID;
	end
end
function tablelength(T)
	local count = 0;
	for _,elem in pairs(T)do
		count = count + 1;
	end
	return count;
end
