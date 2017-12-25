function Server_AdvanceTurn_Start (game,addNewOrder)
	playerGameData = Mod.PlayerGameData;
	RemainingDeclerations = {};
	RemainingAllyCancels = {};
	local turn = game.Game.TurnNumber;
	for _,pid in pairs(game.Game.PlayingPlayers) do
		if(pid.IsAI == false)then
			local history = playerGameData[pid.ID].NeueNachrichten;
			local newhistory = {};
			local num = 1;
			for _,hist in pairs(history) do
				if(hist.Turn >= turn-2)then
					newhistory[num] = hist;
					num=num+1;
				end
			end
			playerGameData[pid.ID].NeueNachrichten = newhistory;
		end
	end
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	if(order.proxyType == "GameOrderAttackTransfer")then
		if(result.IsAttack)then
			local toowner = game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID;
			if(toowner ~= WL.PlayerID.Neutral and order.PlayerID ~= WL.PlayerID.Neutral)then
				if(InWar(order.PlayerID,toowner) == false)then
					skipThisOrder(WL.ModOrderControl.Skip);
					if(game.ServerGame.Game.Players[order.PlayerID].IsAIOrHumanTurnedIntoAI == true)then
						DeclareWar(order.PlayerID,toowner,game);
					end
				end
			end
		end
	end
	if(order.proxyType == "GameOrderCustom")then
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
		if(check(order.Message,"Declared war on"))then
			if(InWar(order.PlayerID,order.Payload) == false)then
				DeclareWar(order.PlayerID,tonumber(order.Payload),game);
				if(game.ServerGame.Game.Players[tonumber(order.Payload)].IsAI == false)then
					for _,with in pairs(playerGameData[tonumber(order.Payload)].Allianzen)do
						DeclareWar(with,order.PlayerID,game);
					end
				end
			end
		end
		if(check(order.Message,"Buy Territory"))then
			local payloadsplit = stringtotable(order.Payload);
			local von = tonumber(payloadsplit[1]);
			local terrid = tonumber(payloadsplit[2]);
			if(game.ServerGame.LatestTurnStanding.Territories[terrid].OwnerPlayerID == von)then
				local Terrselloffer = GetOffer(playerGameData[order.PlayerID].TerritorySellOffers,von,terrid);
				if(Terrselloffer == nil)then
					--Terrselloffer doesn't exist anylonger
					local message = {};
					message.Type = 12;
					message.Von = von;
					message.terrid = terrid;
					message.Turn = game.Game.NumberOfTurns;
					addmessage(message,order.PlayerID);
				else
					local Preis = Terrselloffer.Preis;
					if(order.CostOpt ~= nil)then
						if(Preis ~= order.CostOpt[WL.ResourceType.Gold])then--securation that the price is right
							skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);
							return;
						end
					end
					--buying the territory now
					local effect = WL.TerritoryModification.Create(terrid);
					effect.SetOwnerOpt = order.PlayerID;
					local costopt = {};
					costopt[WL.ResourceType.Gold] = offer.Preis;
					addNewOrder(WL.GameOrderEvent.Create(order.PlayerID, "Bought " .. game.Map.Territories[terrid].Name, {}, {effect},costopt));
					local message = {};
					message.Type = 6;
					message.Von = von;
					message.buyer = order.PlayerID;
					message.Preis = Preis;
					message.terrid = terrid;
					message.Turn = game.Game.NumberOfTurns;
					addmessage(message,order.PlayerID);
					addmessage(message,von);
					--this is the message all other players can see(price is removed)
					for _,pid in pairs(game.ServerGame.Game.Players)do
						if(pid.IsAI == false)then
							if(playerGameData[pid.ID].TerritorySellOffers[von] ~= nil)then
								playerGameData[pid.ID].TerritorySellOffers[von][terrid] = nil;
								if(tablelength(playerGameData[pid.ID].TerritorySellOffers[von]) == 0)then
									playerGameData[pid.ID].TerritorySellOffers[von] = nil;
								end
							end
							if(pid.ID ~= order.PlayerID and pid.ID ~= von)then
								message = {};
								message.Type = 6;
								message.Von = von;
								message.buyer = order.PlayerID;
								message.terrid = terrid;
								message.Turn = game.Game.NumberOfTurns;
								addmessage(message,pid.ID);
							end
						end
					end
				end
			else
				--This is the error code, that the person you are trying to buy the territory from, doesn't own the territory at the moment, you are trying to buy it
				local message = {};
				message.Type = 2;
				message.Von = von;
				message.terrid = terrid;
				message.Turn = game.Game.NumberOfTurns;
				addmessage(message,order.PlayerID);
				--This is the error code, that order.PlayerID was unable to buy terrid, since von didn't own it
				message = {};
				message.Type = 3;
				message.Player = order.PlayerID;
				message.terrid = terrid;
				message.Turn = game.Game.NumberOfTurns;
				addmessage(message,von);
			end
		end
		skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);
	end
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
	--add new war Declaretions
	local publicGameData = Mod.PublicGameData;
	for _,newwar in pairs(RemainingDeclerations)do
		publicGameData.War[newwar.S1][tablelength(publicGameData.War[newwar.S1])+1] = newwar.S2;
		publicGameData.War[newwar.S2][tablelength(publicGameData.War[newwar.S2])+1] = newwar.S1;
		local message = {};
		message.Type = 1;
		message.S1 = newwar.S1;
		message.S2 = newwar.S2;
		message.Turn = game.Game.NumberOfTurns;
		for _,pid in pairs(game.ServerGame.Game.Players)do
			if(pid.IsAI == false)then
				addmessage(message,pid.ID);
			end
		end
		--Removing all territory sell offers
		if(game.ServerGame.Game.Players[newwar.S1].IsAI == false)then
			playerGameData[newwar.S1].TerritorySellOffers[newwar.S2] = nil;
		end
		if(game.ServerGame.Game.Players[newwar.S2].IsAI == false)then
			playerGameData[newwar.S2].TerritorySellOffers[newwar.S1] = nil;
		end
	end
	RemainingDeclerations = {};
	for _,canceldata in pairs(RemainingAllyCancels)do
		local remainingwar = {};
		for _,with in pairs(playerGameData[canceldata.S1].Allianzen)do
			if(with ~= canceldata.S2)then
				remainingwar[tablelength(remainingwar)+1] = with;
			end
		end
		playerGameData[canceldata.S1].Allianzen = remainingwar;
		remainingwar = {};
		for _,with in pairs(playerGameData[canceldata.S2].Allianzen)do
			if(with ~= canceldata.S1)then
				remainingwar[tablelength(remainingwar)+1] = with;
			end
		end
		playerGameData[canceldata.S2].Allianzen = remainingwar;
		local message = {};
		message.Type = 18;
		message.S1 = canceldata.S1;
		message.S2 = canceldata.S2;
		message.Turn = game.Game.NumberOfTurns;
		if(Mod.Settings.PublicAllies)then
			for _,pd in pairs(game.ServerGame.Game.Players)do
				if(pd.IsAI == false)then
					addmessage(message,pd.ID);
				end
			end
		else
			addmessage(message,canceldata.S1);
			addmessage(message,canceldata.S2);
		end
	end
	RemainingAllyCancels = {};
	--reducing the number of turns a player cant declare war on an other
	for _,pid in pairs(game.ServerGame.Game.PlayingPlayers)do
		if(game.Settings.Cards[WL.CardID.Spy] ~= nil and Mod.Settings.SeeAllyTerritories == true)then
			if(pid.IsAI == false)then
				for _,pid2 in pairs(playerGameData[pid.ID].Allianzen) do
					local cardinstance = WL.NoParameterCardInstance.Create(WL.CardID.Spy);
					addNewOrder(WL.GameOrderReceiveCard.Create(pid.ID, {cardinstance}));
					addNewOrder(WL.GameOrderPlayCardSpy.Create(cardinstance.ID, pid.ID, pid2));
				end
			end
		end
		for _,pid2 in pairs(game.ServerGame.Game.PlayingPlayers)do
			if(pid.ID ~= pid2.ID)then
				if(publicGameData.CantDeclare[pid.ID][pid2.ID] ~= nil)then
					publicGameData.CantDeclare[pid.ID][pid2.ID] = publicGameData.CantDeclare[pid.ID][pid2.ID] - 1;
					if(publicGameData.CantDeclare[pid.ID][pid2.ID] == 0)then
						publicGameData.CantDeclare[pid.ID][pid2.ID] = nil;
					end
				end
			end
		end
	end
	finished = true;
	Mod.PublicGameData = publicGameData;
	Mod.PlayerGameData = playerGameData;

end
function ownsbonus(game,bonusid,ignorterrid,playerID)
	for _,terrid in pairs(game.Map.Bonuses[bonusid].Territories)do
		if(terrid ~= ignorterrid)then
			if(game.ServerGame.LatestTurnStanding.Territories[terrid].OwnerPlayerID ~= playerID)then
				return false;
			end
		end
	end
	return true;
end
function toname(playerid,game)
	return game.ServerGame.Game.Players[playerid].DisplayName(nil, false);
end
function IsPlayable(Player1,Player2,game,requirewarsetting,requirepeacesetting,requireallysetting)
	if(Player2 == WL.PlayerID.Neutral)then
		return true;
	end
	if(requirepeacesetting == nil and requireallysetting == nil)then
		if(InWar(Player1,Player2)==false and requirewarsetting == true)then
			--Declare war
			if(game.ServerGame.Game.Players[Player1].IsAIOrHumanTurnedIntoAI == true)then
				if(Mod.Settings.AllowAIDeclaration == true and game.ServerGame.Game.Players[Player2].IsAIOrHumanTurnedIntoAI == false)then
					DeclareWar(Player1,Player2,game);
				end
				if(Mod.Settings.AIsDeclareAIs == true and game.ServerGame.Game.Players[Player2].IsAIOrHumanTurnedIntoAI == true)then
					DeclareWar(Player1,Player2,game);
				end
			else
				DeclareWar(Player1,Player2,game);
			end
			return false;
		else
			return true;
		end
	else
		if(requirepeacesetting == true and InWar(Player1,Player2) == false and IsAlly(Player1,Player2) == false)then
			return true;
		end
		if(requireallysetting == true and IsAlly(Player1,Player2) == true)then
			return true;
		end
		if(requirewarsetting == true)then
			if(InWar(Player1,Player2) == true)then
				return true;
			else
				--Declare war
				if(game.ServerGame.Game.Players[Player1].IsAIOrHumanTurnedIntoAI == true)then
					if(Mod.Settings.AllowAIDeclaration == true and game.ServerGame.Game.Players[Player2].IsAIOrHumanTurnedIntoAI == false)then
						DeclareWar(Player1,Player2,game);
					end
					if(Mod.Settings.AIsDeclareAIs == true and game.ServerGame.Game.Players[Player2].IsAIOrHumanTurnedIntoAI == true)then
						DeclareWar(Player1,Player2,game);
					end
				else
					DeclareWar(Player1,Player2,game);
				end
				return false;
			end
		end
		return false;
	end
end
function DeclareWar(Player1,Player2,game,hasrevenge)
	if(Player1 == Player2)then
		return;
	end
	if(IsAlly(Player1,Player2,game)==false and InWar(Player1,Player2) == false)then
		print(tostring(Player1) .. " " .. tostring(Player2));
		if(game.ServerGame.Game.Players[Player1].IsAIOrHumanTurnedIntoAI == true)then
			if(game.ServerGame.Game.Players[Player2].IsAIOrHumanTurnedIntoAI == false and Mod.Settings.AllowAIDeclaration == false)then
				return;
			end
			print(game.ServerGame.Game.Players[Player2].IsAIOrHumanTurnedIntoAI);
			print( Mod.Settings.AIsdeclearAIs);
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
		if(Mod.PublicGameData.CantDeclare[Player1][Player2] ~= nil)then
			--the player have enforced peace
			return;
		end
		RemainingDeclerations[tablelength(RemainingDeclerations)+1] = {};
		RemainingDeclerations[tablelength(RemainingDeclerations)].S1 = Player1;
		RemainingDeclerations[tablelength(RemainingDeclerations)].S2 = Player2;
		if(hasrevenge == nil)then
			if(game.ServerGame.Game.Players[Player2].IsAI == false)then
				for _,with in pairs(playerGameData[Player2].Allianzen)do
					DeclareWar(Player2,Player1,game,true);
				end
			end
		end
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
function addmessage(message,spieler)
	playerGameData[spieler].Nachrichten[tablelength(playerGameData[spieler].Nachrichten)+1] = message;
	playerGameData[spieler].NeueNachrichten[tablelength(playerGameData[spieler].NeueNachrichten)+1] = message;
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
