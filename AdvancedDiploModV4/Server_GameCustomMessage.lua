function Server_GameCustomMessage(game, playerID, payload, setReturnTable)
	publicGameData = Mod.PublicGameData;
	playerGameData = Mod.PlayerGameData;
	local rg = {};
	if(payload.Message == "Accept Allianze" or payload.Message == "Deny Allianze")then
		if(playerGameData[playerID].AllyOffers[payload.OfferedBy] == nil)then
			--offer doesn't exist any longer
			rg.Message = "The Ally offer doesn't exist, maybe you already accepted or declined it. The next time you reload the game, it shouldn't be shown there.";
			setReturnTable(rg);
		else
			playerGameData[playerID].AllyOffers[payload.OfferedBy] = nil;
			if(payload.Message == "Accept Allianze")then
			--incase both send each other a ally offer, the offer of the other player is getting deleted
				playerGameData[payload.OfferedBy].AllyOffers[playerID] = nil;
				playerGameData[playerID].Allianzen[tablelength(playerGameData[playerID].Allianzen)+1] = payload.OfferedBy;
				playerGameData[payload.OfferedBy].Allianzen[tablelength(playerGameData[payload.OfferedBy].Allianzen)+1] = playerID;
				--accept ally message
				local message = {};
				message.By = playerID;
				message.Text = " accepted the alliance with " .. toname(payload.OfferedBy,game);
				if(Mod.Settings.PublicAllies == true)then
					local newhistoryid = tablelength(publicGameData.History);
					local additionalhistorydata = {};
					additionalhistorydata.Type = "Public";
					additionalhistorydata.ID = newhistoryid;
					publicGameData.Historyorder[tablelength(publicGameData.Historyorder)] = additionalhistorydata;
					publicGameData.History[newhistoryid] = message;
				else
					local newhistoryid = tablelength(playerGameData[playerID].PrivateHistory);
					local additionalhistorydata = {};
					additionalhistorydata.Type = "Private";
					additionalhistorydata.ID = newhistoryid;
					additionalhistorydata.PlayerID = playerID;
					publicGameData.Historyorder[tablelength(publicGameData.Historyorder)] = additionalhistorydata;
					playerGameData[playerID].PrivateHistory[newhistoryid] = message;
					newhistoryid = tablelength(playerGameData[payload.OfferedBy].PrivateHistory);
					additionalhistorydata = {};
					additionalhistorydata.Type = "Private";
					additionalhistorydata.ID = newhistoryid;
					additionalhistorydata.PlayerID = payload.OfferedBy;
					publicGameData.Historyorder[tablelength(publicGameData.Historyorder)] = additionalhistorydata;
					playerGameData[payload.OfferedBy].PrivateHistory[newhistoryid] = message;
				end
				Mod.PublicGameData = publicGameData;
				Mod.PlayerGameData = playerGameData;
				rg.Message = "You successfuly accepted the ally offer.";
				setReturnTable(rg);
			else
				--declined ally message
				local message = {};
				message.By = playerID;
				message.Text = " declined the alliance offer of " .. toname(payload.OfferedBy,game);
				playerGameData[playerID].PrivateHistory[tablelength(playerGameData[playerID].PrivateHistory)] = message;
				local newhistoryid = tablelength(playerGameData[payload.OfferedBy].PrivateHistory);
				local additionalhistorydata = {};
				additionalhistorydata.Type = "Private";
				additionalhistorydata.ID = newhistoryid;
				additionalhistorydata.PlayerID = payload.OfferedBy;
				publicGameData.Historyorder[tablelength(publicGameData.Historyorder)] = additionalhistorydata;
				playerGameData[payload.OfferedBy].PrivateHistory[newhistoryid] = message;
				Mod.PublicGameData = publicGameData;
				Mod.PlayerGameData = playerGameData;
				rg.Message = "You successfuly declined the ally offer.";
				setReturnTable(rg);
			end
		end	
	end
	if(payload.Message == "Offer Allianze")then
		local target = tonumber(payload.TargetPlayerID);
		if(playerGameData[target].AllyOffers[playerID] == nil)then
			playerGameData[target].AllyOffers[playerID] = {};
			playerGameData[target].AllyOffers[playerID].OfferedBy = playerID;
			playerGameData[target].AllyOffers[playerID].OfferedInTurn = game.Game.NumberOfTurns;
			local message = {};
			message.By = playerID;
			message.Text = " offered an alliance to " .. toname(target,game);
			playerGameData[playerID].PrivateHistory[tablelength(playerGameData[playerID].PrivateHistory)] = message;
			local newhistoryid = tablelength(playerGameData[target].PrivateHistory);
			local additionalhistorydata = {};
			additionalhistorydata.Type = "Private";
			additionalhistorydata.ID = newhistoryid;
			additionalhistorydata.PlayerID = target;
			publicGameData.Historyorder[tablelength(publicGameData.Historyorder)] = additionalhistorydata;
			playerGameData[target].PrivateHistory[newhistoryid] = message;
			Mod.PlayerGameData = playerGameData;
			Mod.PublicGameData = publicGameData;
			rg.Message = "The Player recieved the ally offer";
			setReturnTable(rg);
		else
			rg.Message = "The Player has already a pending ally offer by you";
			setReturnTable(rg);
		end
	end
 	if(payload.Message == "Peace")then
		local player = payload.TargetPlayerID;
		if(game.ServerGame.Game.Players[player].IsAIOrHumanTurnedIntoAI == false)then
			if(playerGameData[player].Peaceoffers[playerID] ~= nil)then
				rg.Message = "The Player has already a pending peace offer by you";
				setReturnTable(rg);
			else
				playerGameData[player].Peaceoffers[playerID] = {};
				playerGameData[player].Peaceoffers[playerID].Offerby = playerID;
				local message = {};
				message.By = playerID;
				message.Text = " Offered peace to " .. toname(player,game);
				playerGameData[playerID].PrivateHistory[tablelength(playerGameData[playerID].PrivateHistory)] = message;
				local newhistoryid = tablelength(playerGameData[player].PrivateHistory);
				local additionalhistorydata = {};
				additionalhistorydata.Type = "Private";
				additionalhistorydata.ID = newhistoryid;
				additionalhistorydata.PlayerID = player;
				publicGameData.Historyorder[tablelength(publicGameData.Historyorder)] = additionalhistorydata;
				playerGameData[player].PrivateHistory[newhistoryid] = message;
				Mod.PublicGameData = publicGameData;
				Mod.PlayerGameData = playerGameData;
				rg.Message = "The Offer has been submitted";
				setReturnTable(rg);
			end
		else
			if(game.ServerGame.Game.Players[player].IsAI == false)then
				--since human ais can have peaceoffers, before the turn into ai, this removes the old offers
				playerGameData[playerID].Peaceoffers[player] = nil;
			end
			local message = {};
			message.By = playerID;
			message.Text = " Accepted the peace with " .. toname(player,game);
			local newhistoryid = tablelength(publicGameData.History);
			local additionalhistorydata = {};
			additionalhistorydata.Type = "Public";
			additionalhistorydata.ID = newhistoryid;
			publicGameData.History[newhistoryid] = message;
			Mod.PlayerGameData=playerGameData;
			local remainingwar = {};
			for _,with in pairs(publicGameData.War[player]) do
				if(with~=playerID)then
					remainingwar[tablelength(remainingwar)+1] = with;
				end
			end
			publicGameData.War[player] = remainingwar;
			remainingwar = {};
			for _,with in pairs(publicGameData.War[playerID]) do
				if(with~=player)then
					remainingwar[tablelength(remainingwar)+1] = with;
				end
			end
			publicGameData.War[playerID] = remainingwar;
			Mod.PublicGameData = publicGameData;
			Mod.PlayerGameData = playerGameData;
			rg.Message = 'The AI accepted your offer';
			setReturnTable(rg);
		end
	end
	if(payload.Message == "Accept Peace" or payload.Message == "Decline Peace")then
		local player = tonumber(payload.TargetPlayerID);
		if(playerGameData[playerID].Peaceoffers[player] == nil)then
			rg.Message = "The Peace Offer doesn't exist, maybe you already accepted or declined it. The next time you reload the game, it shouldn't be shown there.";
			setReturnTable(rg);
		else
			if(payload.Message == "Accept Peace")then
				local remainingwar = {};
				publicGameData = Mod.PublicGameData;
				for _,with in pairs(publicGameData.War[player]) do
					if(with~=playerID)then
						remainingwar[tablelength(remainingwar)+1] = with;
					end
				end
				publicGameData.War[player] = remainingwar;
				remainingwar = {};
				for _,with in pairs(publicGameData.War[playerID]) do
					if(with~=player)then
						remainingwar[tablelength(remainingwar)+1] = with;
					end
				end
				publicGameData.War[playerID] = remainingwar;
				local message = {};
				message.By = playerID;
				message.Text = " Accepted the peace with " .. toname(player,game);
				local newhistoryid = tablelength(publicGameData.History);
				local additionalhistorydata = {};
				additionalhistorydata.Type = "Public";
				additionalhistorydata.ID = newhistoryid;
				publicGameData.History[newhistoryid] = message;
				playerGameData[playerID].Peaceoffers[player] = nil
				playerGameData[player].Peaceoffers[playerID] = nil
				Mod.PublicGameData = publicGameData;
				Mod.PlayerGameData = playerGameData;
				rg.Message = "The Peace Offer has been accepted.";
				setReturnTable(rg);
			else
				local message = {};
				message.By = playerID;
				message.Text = " Declined the peace with " .. toname(player,game);
				playerGameData[playerID].PrivateHistory[tablelength(playerGameData[playerID].PrivateHistory)] = message;
				local newhistoryid = tablelength(playerGameData[player].PrivateHistory);
				local additionalhistorydata = {};
				additionalhistorydata.Type = "Private";
				additionalhistorydata.ID = newhistoryid;
				additionalhistorydata.PlayerID = player;
				publicGameData.Historyorder[tablelength(publicGameData.Historyorder)] = additionalhistorydata;
				playerGameData[player].PrivateHistory[newhistoryid] = message;
				playerGameData[playerID].Peaceoffers[player] = nil
				Mod.PublicGameData = publicGameData;
				Mod.PlayerGameData = playerGameData;
				rg.Message = "The Peace Offer has been declined.";
				setReturnTable(rg);
			end
		end
	end
end
function toname(playerid,game)
	return game.ServerGame.Game.Players[playerid].DisplayName(nil, false);
end
function tablelength(T)
	local count = 0;
	for _,elem in pairs(T)do
		count = count + 1;
	end
	return count;
end
function GetOffer(offertype,spieler1,spieler2,terr)
	if(offertype ~= nil)then
		if(offertype[spieler1] ~= nil)then
			if(offertype[spieler1][spieler2] ~= nil)then
				if(terr ~= nil)then
					if(offertype[spieler1][spieler2][terr] ~= nil)then
						return offertype[spieler1][spieler2][terr];
					end
				else
					return offertype[spieler1][spieler2];
				end
			end
		end
	end
	return nil;
end
