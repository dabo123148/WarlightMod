function Server_AdvanceTurn_Start (game,addNewOrder)
	playerGameData = Mod.PlayerGameData;
	publicGameData = Mod.PublicGameData;
	RemainingDeclerations = {};
	RemainingAllyCancels = {};
	local turn = game.Game.TurnNumber;
	local historyamount = tablelength(publicGameData.Historyorder);
	local number = 0;
	while(number<historyamount)do
		if(publicGameData.Historyorder ~= nil and  publicGameData.Historyorder[number] ~=nil)then
			local historyid = publicGameData.Historyorder[number].ID;
			if(publicGameData.Historyorder[number].Type == "Public")then
				addNewOrder(WL.GameOrderEvent.Create(publicGameData.History[historyid].By, publicGameData.History[historyid].Text, nil, nil, nil));
			else
				local spielerID = publicGameData.Historyorder[number].PlayerID;
				if(playerGameData[spielerID].PrivateHistory[historyid].By ~= spielerID)then
					addNewOrder(WL.GameOrderEvent.Create(playerGameData[spielerID].PrivateHistory[historyid].By, playerGameData[spielerID].PrivateHistory[historyid].Text, {spielerID}, nil, nil));
				end
			end
		end
		number = number+1;
	end
	publicGameData.Historyorder = {};
	--Writing Public History into the history
	--for _,data in pairs(publicGameData.History) do
	--	addNewOrder(WL.GameOrderEvent.Create(data.By, data.Text, nil, nil, nil));
	--end
	publicGameData.History = {};
	for _,pid in pairs(game.Game.PlayingPlayers) do
		--Writing Private History into the history
		if(pid.IsAI == false)then
			--for _,data in pairs(playerGameData[pid.ID].PrivateHistory) do
			--	if(data.By ~= pid.ID)then
			--		addNewOrder(WL.GameOrderEvent.Create(data.By, data.Text, {pid.ID}, nil, nil));
			--	end
			--end
			playerGameData[pid.ID].PrivateHistory = {};
			playerGameData[pid.ID].HasNewWar = false;
		end
		for _,pid2 in pairs(game.Game.PlayingPlayers) do
			if(pid ~= pid2)then
				if(InWar(pid2.ID,pid.ID) and  IsAlly(pid2.ID,pid.ID,game))then
					local remainingwar = {};
					for _,with in pairs(playerGameData[pid.ID].Allianzen)do
						if(with ~= pid2.ID)then
							remainingwar[tablelength(remainingwar)+1] = with;
						end
					end
					playerGameData[pid.ID].Allianzen = remainingwar;
					remainingwar = {};
					for _,with in pairs(playerGameData[pid2.ID].Allianzen)do
						if(with ~= pid.ID)then
							remainingwar[tablelength(remainingwar)+1] = with;
						end
					end
					playerGameData[pid2.ID].Allianzen = remainingwar;
				end
			end
		end
	end
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	if(order.proxyType == "GameOrderAttackTransfer")then
		--allows transfering
		if(result.IsAttack)then
			--owner of the target territory
			local toowner = game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID;
			-- allows attacking of neutral territories, and verification if order is not neutral required for compatibility with other mods
			if(toowner ~= WL.PlayerID.Neutral and order.PlayerID ~= WL.PlayerID.Neutral)then
				if(InWar(order.PlayerID,toowner) == false)then
					skipThisOrder(WL.ModOrderControl.Skip);
					--Decleare War for AI if AI(verification if settings allow it is in DeclareWar)
					if(game.ServerGame.Game.Players[order.PlayerID].IsAIOrHumanTurnedIntoAI == true)then
						DeclareWar(order.PlayerID,toowner,game);
					end
				end
			end
		end
	end
	if(order.proxyType == "GameOrderCustom")then
		--Alliance canceling
		if(check(order.Message,"Cancel Alliance with"))then
			local cancelwith = tonumber(order.Payload);
			local match = false;
			for _,canceldata in pairs(RemainingAllyCancels)do
				if(canceldata.S1 == order.PlayerID or canceldata.S1 == cancelwith)then
					if(canceldata.S2 == order.PlayerID or canceldata.S2 == cancelwith)then
						match = true;
					end
				end
			end
			if(match == false)then
				RemainingAllyCancels[tablelength(RemainingAllyCancels)+1] = {};
				RemainingAllyCancels[tablelength(RemainingAllyCancels)].S1 = order.PlayerID;
				RemainingAllyCancels[tablelength(RemainingAllyCancels)].S2 = cancelwith;
			end
		end
		--Player war declaration
		if(check(order.Message,"Declared war on"))then
			if(InWar(order.PlayerID,order.Payload) == false)then
				DeclareWar(order.PlayerID,tonumber(order.Payload),game);
			end
			--Skips order since it will be executed at the end of the turn(Server_AdvanceTurn_End)
			skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);
		end
	end
	--Card playing verification
	if(order.proxyType == "GameOrderPlayCardSanctions")then
		if(IsPlayable(order.PlayerID,order.SanctionedPlayerID,game,Mod.Settings.SanctionCardRequireWar,Mod.Settings.SanctionCardRequirePeace,Mod.Settings.SanctionCardRequireAlly) == false)then
			skipThisOrder(WL.ModOrderControl.Skip);
		end
	end
	if(order.proxyType == "GameOrderPlayCardBomb")then
		if(IsPlayable(order.PlayerID,game.ServerGame.LatestTurnStanding.Territories[order.TargetTerritoryID].OwnerPlayerID,game,Mod.Settings.BombCardRequireWar,Mod.Settings.BombCardRequirePeace,Mod.Settings.BombCardRequireAlly) == false)then
			skipThisOrder(WL.ModOrderControl.Skip);
		end
	end
	if(finished == nil)then
		if(order.proxyType == "GameOrderPlayCardSpy")then
			if(IsPlayable(order.PlayerID,order.TargetPlayerID,game,Mod.Settings.SpyCardRequireWar,Mod.Settings.SpyCardRequirePeace,Mod.Settings.SpyCardRequireAlly) == false)then
				skipThisOrder(WL.ModOrderControl.Skip);
			end
		end
	end
	if(order.proxyType == "GameOrderPlayCardGift")then
		if(IsPlayable(order.PlayerID,order.GiftTo,game,Mod.Settings.GiftCardRequireWar,Mod.Settings.GiftCardRequirePeace,Mod.Settings.GiftCardRequireAlly) == false)then
			skipThisOrder(WL.ModOrderControl.Skip);
		end
	end
end
function Server_AdvanceTurn_End (game,addNewOrder)
	--Finishing war declaration
	for _,newwar in pairs(RemainingDeclerations)do
		--removes ally offers
		if(game.ServerGame.Game.Players[newwar.S1].IsAI == false)then
			playerGameData[newwar.S1].AllyOffers[newwar.S2] = nil;
			playerGameData[newwar.S1].HasNewWar = true;
		end
		if(game.ServerGame.Game.Players[newwar.S2].IsAI == false)then
			playerGameData[newwar.S2].AllyOffers[newwar.S1] = nil;
			playerGameData[newwar.S2].HasNewWar = true;
		end		
		--Sets diplomacy to war between the players
		publicGameData.War[newwar.S1][tablelength(publicGameData.War[newwar.S1])+1] = newwar.S2;
		publicGameData.War[newwar.S2][tablelength(publicGameData.War[newwar.S2])+1] = newwar.S1;
		--Writes event to history
		addNewOrder(WL.GameOrderEvent.Create(newwar.S1, "Decleared war on " .. toname(newwar.S2,game), nil, nil, nil) );
	end
	RemainingDeclerations = {};
	--Removing Allies, that got canceled
	for _,canceldata in pairs(RemainingAllyCancels)do
		local remainingally = {};
		for _,with in pairs(playerGameData[canceldata.S1].Allianzen)do
			if(with ~= canceldata.S2)then
				remainingally[tablelength(remainingally)+1] = with;
			end
		end
		playerGameData[canceldata.S1].Allianzen = remainingally;
		remainingally = {};
		for _,with in pairs(playerGameData[canceldata.S2].Allianzen)do
			if(with ~= canceldata.S1)then
				remainingally[tablelength(remainingally)+1] = with;
			end
		end
		playerGameData[canceldata.S2].Allianzen = remainingally;
		if(Mod.Settings.PublicAllies)then
			addNewOrder(WL.GameOrderEvent.Create(canceldata.S1, "Canceled the alliance with " .. toname(canceldata.S2,game), nil, nil, nil) );
		else
			addNewOrder(WL.GameOrderEvent.Create(canceldata.S1, "Canceled the alliance with " .. toname(canceldata.S2,game), {canceldata.S2}, nil, nil) );
		end
	end
	RemainingAllyCancels = {};
	--SeeAllyTerritories vision execution
	if(game.Settings.Cards[WL.CardID.Spy] ~= nil) then
		if(Mod.Settings.SeeAllyTerritories == true)then
			for _,pid in pairs(game.ServerGame.Game.PlayingPlayers)do
				if(pid.IsAI == false)then
					for _,pid2 in pairs(playerGameData[pid.ID].Allianzen) do
						local cardinstance = WL.NoParameterCardInstance.Create(WL.CardID.Spy);
						addNewOrder(WL.GameOrderReceiveCard.Create(pid.ID, {cardinstance}));
						addNewOrder(WL.GameOrderPlayCardSpy.Create(cardinstance.ID, pid.ID, pid2));
					end
				end
			end
		end
		if(Mod.Settings.SeePeaceTerritories ~= nil and Mod.Settings.SeePeaceTerritories == true)then
			for _,pid in pairs(game.ServerGame.Game.PlayingPlayers)do
				for _,pid2 in pairs(game.ServerGame.Game.PlayingPlayers)do
					if(pid.ID ~= pid2.ID and InWar(pid2.ID,pid.ID) ==false and IsAlly(pid.ID,pid2.ID) == false)then
						local cardinstance = WL.NoParameterCardInstance.Create(WL.CardID.Spy);
						addNewOrder(WL.GameOrderReceiveCard.Create(pid.ID, {cardinstance}));
						addNewOrder(WL.GameOrderPlayCardSpy.Create(cardinstance.ID, pid.ID, pid2));
					end
				end
			end
		end
	end
	--ensuring that the ally vision spy cards don't get prevented by preventing the playing of those on allies
	finished = true;
	Mod.PublicGameData = publicGameData;
	Mod.PlayerGameData = playerGameData;

end
--translates playerid to playername, which is required for history, since it is not userfriendly to show the id, but also results in static playernames and does not addapt to playername changes
function toname(playerid,game)
	return game.ServerGame.Game.Players[playerid].DisplayName(nil, false);
end
--Verifies if cards can be played
function IsPlayable(Player1,Player2,game,requirewarsetting,requirepeacesetting,requireallysetting)
	--Does not prevent other mods from playing cards(unsure if possible for those to play cards as neutral)
	if(Player1 == WL.PlayerID.Neutral)then
		return true;
	end
	--Does not prevent cards on Neutral
	if(Player2 == WL.PlayerID.Neutral)then
		return true;
	end
	--Verifies peace
	if(requirepeacesetting == true and InWar(Player1,Player2) == false and IsAlly(Player1,Player2,game) == false)then
		return true;
	end
	if(requireallysetting == true and IsAlly(Player1,Player2,game) == true)then
		return true;
	end
	if(requirewarsetting == true)then
		if(InWar(Player1,Player2) == true)then
			return true;
		else
			--Decleare War for AI(verification if settings allow it is in DeclareWar)
			if(game.ServerGame.Game.Players[Player1].IsAIOrHumanTurnedIntoAI == true)then
				DeclareWar(Player1,Player2,game);
			end
			return false;
		end
	end
	return false;
end
function DeclareWar(Player1,Player2,game)
	if(Player1 == Player2)then
		return;
	end
	if(IsAlly(Player1,Player2,game)==false and InWar(Player1,Player2) == false)then
		if(game.ServerGame.Game.Players[Player1].IsAIOrHumanTurnedIntoAI == true)then
			if(game.ServerGame.Game.Players[Player2].IsAIOrHumanTurnedIntoAI == false and Mod.Settings.AllowAIDeclaration == false)then
				return;
			end
			if(game.ServerGame.Game.Players[Player2].IsAIOrHumanTurnedIntoAI == true and Mod.Settings.AIsdeclearAIs == false)then
				return;
			end
		end
		for _,newwar in pairs(RemainingDeclerations)do
			local P1 = newwar.S1;
			local P2 = newwar.S2;
			if(P1 == Player1 or P1 == Player2)then
				if(P2 == Player1 or P2 == Player2)then
					--declaration is already pending
					return;
				end
			end
		end
		RemainingDeclerations[tablelength(RemainingDeclerations)+1] = {};
		RemainingDeclerations[tablelength(RemainingDeclerations)].S1 = Player1;
		RemainingDeclerations[tablelength(RemainingDeclerations)].S2 = Player2;
	end
end
function InWar(Player1,Player2)	
	for _,pID in pairs(Mod.PublicGameData.War[Player1])do
		if(pID == Player2)then
			--both players are in war
			return true;
		end
	end
	return false;
end
function IsAlly(Player1,Player2,game)
	if(game.ServerGame.Game.Players[Player1].IsAI == false)then
		for _,pID in pairs(playerGameData[Player1].Allianzen)do
			if(pID == Player2)then
				--both players are allied
				return true;
			end
		end
	end
	return false;
end
function tablelength(T)
	local count = 0;
	for _,elem in pairs(T)do
		count = count + 1;
	end
	return count;
end
function stringtochararray(variable)
	chartable = {};
	while(string.len(variable)>0)do
		chartable[tablelength(chartable)] = string.sub(variable, 1 , 1);
		variable = string.sub(variable, 2);
	end
	return chartable;
end
function stringtotable(variable)
	chartable = {};
	while(string.len(variable)>0)do
		chartable[tablelength(chartable)] = string.sub(variable, 1 , 1);
		variable = string.sub(variable, 2);
	end
	local newtable = {};
	local tablepos = 0;
	local executed = false;
	for _, elem in pairs(chartable)do
		if(elem == ",")then
			tablepos = tablepos + 1;
			newtable[tablepos] = "";
			executed = true;
		else
			if(executed == false)then
				tablepos = tablepos + 1;
				newtable[tablepos] = "";
				executed = true;
			end
			if(newtable[tablepos] == nil)then
				newtable[tablepos] = elem;
			else
				newtable[tablepos] = newtable[tablepos] .. elem;
			end
		end
	end
	return newtable;
end
function check(message,variable)
	local match = true;
	local mess = stringtochararray(message);
	local varchararray = stringtochararray(variable);
	local num = 0;
	while(varchararray[num] ~= nil)do
		if(mess[num] ~= varchararray[num])then
			return false;
		end
		num = num + 1;
	end
	return match;
end
function GetOffer(offerType,spieler2,terr)
	if(offerType ~= nil)then
		if(offerType[spieler2] ~= nil)then
			if(terr ~= nil)then
				if(offerType[spieler2][terr] ~= nil)then
					return offerType[spieler2][terr];
				end
			else
				return offerType[spieler2];
			end
		end
	end
	return nil;
end
