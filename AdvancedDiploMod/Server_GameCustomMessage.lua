require('Money');
function Server_GameCustomMessage(game, playerID, payload, setReturnTable)
	playerGameData = Mod.PlayerGameData;
	local rg = {};
	if(payload.Message == "Offer Allianze")then
		local target = tonumber(payload.TargetPlayerID);
		local preis = tonumber(payload.Wert);
		for _,pid in pairs(game.Game.Players)do
			if(pid.IsAI == true)then
				if(Mod.Settings.PublicAllies == true or (pid.ID == playerID or pid.ID == target))then
					local playerGameData = Mod.PlayerGameData;
					if(playerGameData[pid.ID].PendingAllianzes == nil)then
						playerGameData[pid.ID].PendingAllianzes = ",";
					end
					playerGameData[pid.ID].PendingAllianzes = playerGameData[pid.ID].PendingAllianzes .. playerID .. "," .. target .. "," .. preis .. ",";
					Mod.PlayerGameData = playerGameData;
					--addmessagecustom(playerID .. ",12,".. tostring(game.Game.NumberOfTurns+1) .. "," .. tostring(payload.Wert) .. ",",target);
				end
			end
		end
	end
	if(payload.Message == "Read")then
		playerGameData[playerID].NeueNachrichten = {};
		Mod.PlayerGameData=playerGameData;
	end
	if(payload.Message == "Gift Money")then
		local target = tonumber(payload.TargetPlayerID);
		Pay(target,playerID,payload.Wert,playerGameData)
		Mod.PlayerGameData = playerGameData;
		local message = {};
		message.Spender = playerID;
		message.Nehmer = target;
		message.Turn = game.Game.NumberOfTurns;
		message.Type = 11;
		message.Menge = payload.Wert;
		addmessagecustom(message,playerID);
		addmessagecustom(message,target);
		rg.Message = "The Money has been gifted.";
		setReturnTable(rg);
	end
 	if(payload.Message == "Peace")then
		local player = payload.TargetPlayerID;
		local preis = payload.Preis;
		local dauer = payload.duration;
		if(dauer > 10)then
			rg.Message = "To prevent this game from stucking, I limited the max duration of peace to 10turns";
			setReturnTable(rg);
		end
		if(game.ServerGame.Game.Players[player].IsAIOrHumanTurnedIntoAI == false)then
			if(playerGameData[player].Peaceoffers[playerID] ~= nil)then
				rg.Message = "The Player has already a pending peace offer by you";
				setReturnTable(rg);
			else
				playerGameData[player].Peaceoffers[playerID] = {};
				playerGameData[player].Peaceoffers[playerID].Duration = dauer;
				playerGameData[player].Peaceoffers[playerID].Preis = preis;
				playerGameData[player].Peaceoffers[playerID].Offerby = playerID;
				Mod.PlayerGameData=playerGameData;
				rg.Message = "The Offer has been submitted";
				setReturnTable(rg);
			end
		else
			if(preis ~= 0)then
				rg.Message = "AIs don't accept offers that include money";
				setReturnTable(rg);
			else
				if(game.ServerGame.Game.Players[player].IsAI == false)then
					
					local message = {};
					message.Von = player;
					message.Acceptor = playerID;
					message.Dauer = dauer;
					message.Turn = game.Game.NumberOfTurns;
					message.Type = 10;
					message.Preis = 0;
					addmessagecustom(message,playerID);
					addmessagecustom(message,player);
					message = {};
					message.Von = player;
					message.Acceptor = playerID;
					message.Dauer = dauer;
					message.Turn = game.Game.NumberOfTurns;
					message.Type = 10;
					for _,pid in pairs(game.ServerGame.Game.Players)do
						if(pid.IsAI == false and pid.ID ~= player and pid.ID ~= playerID)then
							addmessagecustom(message,pid.ID);
						end
					end
					playerGameData[playerID].Peaceoffers[player] = nil;
					Mod.PlayerGameData=playerGameData;
				end
				publicGameData = Mod.PublicGameData;
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
				publicGameData.CantDeclare[player][playerID] = dauer;
				publicGameData.CantDeclare[playerID][player] = dauer;
				Mod.PublicGameData = publicGameData;
				rg.Message = 'The AI accepted your offer';
				setReturnTable(rg);
			end
		end
	end
	if(payload.Message == "Accept Peace" or payload.Message == "Decline Peace")then
		local player = payload.TargetPlayerID;
		if(playerGameData[playerID].Peaceoffers[player] == nil)then
			rg.Message = "The Peace Offer doesn't exist, maybe you already accepted or declined it. The next time you reload the game, it shouldn't be shown there.";
			setReturnTable(rg);
		end
		if(payload.Message == "Accept Peace")then
			local preis = playerGameData[playerID].Peaceoffers[player].Preis;
			local dauer = playerGameData[playerID].Peaceoffers[player].Duration;
			Pay(player,playerID,preis,playerGameData)
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
			publicGameData.CantDeclare[player][playerID] = dauer;
			publicGameData.CantDeclare[playerID][player] = dauer;
			Mod.PublicGameData = publicGameData;
			local message = {};
			message.Von = player;
			message.Acceptor = playerID;
			message.Dauer = dauer;
			message.Turn = game.Game.NumberOfTurns;
			message.Type = 10;
			message.Preis = preis;
			addmessagecustom(message,playerID);
			addmessagecustom(message,player);
			message = {};
			message.Von = player;
			message.Acceptor = playerID;
			message.Dauer = dauer;
			message.Turn = game.Game.NumberOfTurns;
			message.Type = 10;
			for _,pid in pairs(game.ServerGame.Game.Players)do
				if(pid.IsAI == false and pid.ID ~= player and pid.ID ~= playerID)then
					addmessagecustom(message,pid.ID);
				end
			end
			playerGameData[playerID].Peaceoffers[player] = nil
			Mod.PlayerGameData=playerGameData;
			rg.Message = "The Peace Offer has been accepted.";
			setReturnTable(rg);
		else
			Mod.PlayerGameData=playerGameData;
			local message = {};
			message.Von = player;
			message.DeclinedBy = playerID;
			message.Dauer = playerGameData[playerID].Peaceoffers[player].Duration;
			message.Turn = game.Game.NumberOfTurns;
			message.Type = 11;
			message.Preis = playerGameData[playerID].Peaceoffers[player].Preis;
			addmessagecustom(message,playerID);
			addmessagecustom(message,player);
			playerGameData[playerID].Peaceoffers[player] = nil
			Mod.PlayerGameData=playerGameData;
			rg.Message = "The Peace Offer has been declined.";
			setReturnTable(rg);
		end
	end
	if(payload.Message == "Territory Sell")then
		local target = tonumber(payload.TargetPlayerID);--target == 0 = everyone
		local Preis = payload.Preis;
		local targetterr = tonumber(payload.TargetTerritoryID);
		if(target == 0)then
			--option everyone
			local addedoffers = 0;
			local alreadyoffered = 0;
			for _,pid in pairs(game.ServerGame.Game.Players)do
				if(pid.IsAI == false and pid.ID ~= playerID)then
					if(playerGameData[pid.ID].TerritorySellOffers[playerID] == nil)then
						playerGameData[pid.ID].TerritorySellOffers[playerID] = {};
					end
					if(playerGameData[pid.ID].TerritorySellOffers[playerID][targetterr] == nil)then
						playerGameData[pid.ID].TerritorySellOffers[playerID][targetterr] = {};
						playerGameData[pid.ID].TerritorySellOffers[playerID][targetterr].Preis = Preis;
						playerGameData[pid.ID].TerritorySellOffers[playerID][targetterr].terrID = targetterr;
						playerGameData[pid.ID].TerritorySellOffers[playerID][targetterr].OfferedInTurn = game.Game.NumberOfTurns;
						addedoffers = addedoffers + 1;
					else
						 alreadyoffered = alreadyoffered + 1;
					end
				end
			end
			if(addedoffers==0)then
				Mod.PlayerGameData = playerGameData;
				rg.Message ='Everyone has already a pending territory sell offer for that territoy by you.';
				setReturnTable(rg);
			else
				if(alreadyoffered > 0)then
					rg.Message ='You successfully added ' .. tostring(addedoffers) .. ' Territory Sell Offers ' .. '\n' .. tostring(alreadyoffered) .. ' players had already a territory sell offer for that territory';
				else
					rg.Message ='You successfully added ' .. tostring(addedoffers) .. ' Territory Sell Offers';
				end
				Mod.PlayerGameData = playerGameData;
				setReturnTable(rg);
			end
		else
			if(playerGameData[target].TerritorySellOffers[playerID] == nil)then
				playerGameData[target].TerritorySellOffers[playerID] = {};
			end
			if(playerGameData[target].TerritorySellOffers[playerID][targetterr] ~= nil)then
				rg.Message ='The player has already a pending territory sell offer by you for that territory.';
				setReturnTable(rg);
			else
				playerGameData[target].TerritorySellOffers[playerID][targetterr] = {};
				playerGameData[target].TerritorySellOffers[playerID][targetterr].Preis = Preis;
				playerGameData[target].TerritorySellOffers[playerID][targetterr].Player = playerID;
				playerGameData[target].TerritorySellOffers[playerID][targetterr].terrID = targetterr;
				playerGameData[target].TerritorySellOffers[playerID][targetterr].OfferedInTurn = game.Game.NumberOfTurns;
				Mod.PlayerGameData = playerGameData;
				rg.Message ='The player recieved the offer.';
				setReturnTable(rg);
			end
		end
	end
	if(payload.Message == "Deny Territory Sell")then
		local von = tonumber(payload.TargetPlayerID);
		local terr = tonumber(payload.TargetTerritoryID);
		playerGameData[playerID].TerritorySellOffers[von][terr] = nil;
		if(tablelength(playerGameData[playerID].TerritorySellOffers[von]) == 0)then
			playerGameData[playerID].TerritorySellOffers[von] = nil;
		end
		local message = {};
		message.Von = von;
		message.TerrID = terr;
		message.Turn = game.Game.NumberOfTurns;
		message.Type = 8;
		addmessagecustom(message,playerID);
		message = {};
		message.Revoker = playerID;
		message.TerrID = terr;
		message.Turn = game.Game.NumberOfTurns;
		message.Type = 9;
		addmessagecustom(message,von);
		Mod.PlayerGameData = playerGameData;
	end
end
function tablelength(T)
	local count = 0;
	for _,elem in pairs(T)do
		count = count + 1;
	end
	return count;
end
function addmessagecustom(message,spieler)
	playerGameData[spieler].Nachrichten[tablelength(playerGameData[spieler].Nachrichten)+1] = message;
	playerGameData[spieler].NeueNachrichten[tablelength(playerGameData[spieler].NeueNachrichten)+1] = message;
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
