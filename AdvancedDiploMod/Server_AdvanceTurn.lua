require('Money');
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
				if(hist.Turn >= turn-2 and num <= 10)then
					newhistory[num] = hist;
					num=num+1;
				end
			end
			playerGameData[pid.ID].NeueNachrichten = newhistory;
			if(playerGameData[pid.ID].Nachrichten ~= nil)then
				if(playerGameData[pid.ID].upgreaded == nil or playerGameData[pid.ID].upgreaded == false)then
					playerGameData[pid.ID].Nachrichten = {};
					addNewOrder(WL.GameOrderEvent.Create(WL.PlayerID.Neutral, "Due to a change in the mod history system, all old mod messages got deleted, new messages should still be shown", nil, nil));
				end
				for _,data in pairs(playerGameData[pid.ID].Nachrichten)do
					if(data.Type == 1)then
						if(data.S1 == pid.ID)then
							addNewOrder(WL.GameOrderEvent.Create(pid.ID, "You declared war on " .. toname(data.S2,game), {}, nil));
						end
						if(data.S2 == pid.ID)then
							addNewOrder(WL.GameOrderEvent.Create(pid.ID, toname(data.S1,game) .. " declared war on you", {}, nil));
						end
						if(data.S1 ~= pid.ID and data.S2 ~= pid.ID)then
							addNewOrder(WL.GameOrderEvent.Create(pid.ID, data.S1 .. " declared war on" .. toname(data.S2,game), {}, nil));
						end
					end
					if(data.Type == 2)then
						addNewOrder(WL.GameOrderEvent.Create(pid.ID, "You were unable to buy " .. getterrname(data.terrid,game) .. " from " .. toname(data.Von,game) .. " cause he didn't own it, when you tried to buy it", {}, nil));
					end
					if(data.Type == 3)then
						addNewOrder(WL.GameOrderEvent.Create(pid.ID, toname(data.Player,game) .. " was unable to buy " .. getterrname(data.terrid,game) .. " from you cause you didn't onwed it at the moment, he tried to buy it", {}, nil));;
					end
					if(data.Type == 4)then
						addNewOrder(WL.GameOrderEvent.Create(pid.ID, toname(data.Von,game) .. " hasn't " .. tostring(data.Preis) .." to pay you for " .. getterrname(data.terrid,game), {}, nil));
					end
					if(data.Type == 5)then
						addNewOrder(WL.GameOrderEvent.Create(pid.ID, "You were unable to buy " .. getterrname(data.terrid,game) .. " from " .. toname(data.Von,game) .. " cause you only had " .. tostring(data.YourMoney) .. " and not the required " .. tostring(data.Preis) .. " money", {}, nil));
					end
					if(data.Type == 6)then
						if(data.Preis == nil)then
							addNewOrder(WL.GameOrderEvent.Create(pid.ID, toname(data.buyer,game) .. " bought " .. getterrname(data.terrid,game) .." from " .. toname(data.Von,game), {}, nil));
						else
							if(data.buyer == pid.ID)then
								addNewOrder(WL.GameOrderEvent.Create(pid.ID, "You bought " .. getterrname(data.terrid,game) .." from " .. toname(data.Von,game) .. " for a price of " .. data.Preis, {}, nil));
							else
								addNewOrder(WL.GameOrderEvent.Create(pid.ID, toname(data.buyer,game) .. " bought " .. getterrname(data.terrid,game) .." from you for a price of " .. data.Preis, {}, nil));
							end
						end
					end
					if(data.Type == 7)then
						addNewOrder(WL.GameOrderEvent.Create(pid.ID, "You bought " .. tostring(data.Count) .. " armies for " .. getterrname(data.terrid,game) .. ". The total price was " .. tostring(data.Preis), {}, nil));
					end
					if(data.Type == 8)then
						addNewOrder(WL.GameOrderEvent.Create(pid.ID, "You declined the territory sell offer from " .. toname(data.Von,game) .. " for the territory " .. getterrname(data.TerrID,game), {}, nil));
					end
					if(data.Type == 9)then
						addNewOrder(WL.GameOrderEvent.Create(pid.ID, toname(data.Revoker,game) .. " declined your territory sell offer for the territory " .. getterrname(data.TerrID,game), {}, nil));
					end
					if(data.Type == 10)then
						if(data.Acceptor == pid.ID)then
							if(data.Preis ~= 0)then
								addNewOrder(WL.GameOrderEvent.Create(pid.ID, "You accepted the peace offer " .. toname(data.Von,game) .. " . You have now peace for " .. tostring(data.Duration) .. " Turns. The price for that was just " .. tostring(data.Preis), {}, nil));
							else
								addNewOrder(WL.GameOrderEvent.Create(pid.ID, "You accepted the peace offer " .. toname(data.Von,game) .. " . You have now peace for " .. tostring(data.Duration) .. " Turns", {}, nil));
							end
						end
						if(data.Von == pid.ID)then
							if(data.Preis ~= 0)then
								addNewOrder(WL.GameOrderEvent.Create(pid.ID, toname(data.Acceptor,game) .. " accepted your peace offer. You have now peace for " .. tostring(data.Duration) .. " Turns. The price for that was just " .. tostring(data.Preis), {}, nil));
							else
								addNewOrder(WL.GameOrderEvent.Create(pid.ID, toname(data.Acceptor,game) .. " accepted your peace offer. You have now peace for " .. tostring(data.Duration) .. " Turns", {}, nil));
							end
						end
						if(data.Acceptor ~= pid.ID and data.Von ~= pid.ID)then
							addNewOrder(WL.GameOrderEvent.Create(pid.ID, toname(data.Acceptor,game) .. " and " .. toname(data.Von,game) .. " have now peace for " .. tostring(data.Duration) .. " Turns", {}, nil));
						end
					end
					if(data.Type == 11)then --accidentialy double used with gift money and declined peace
						if(data.Spender ~= nil)then
							if(data.Spender == pid.ID)then
								addNewOrder(WL.GameOrderEvent.Create(pid.ID, "You gifted " .. toname(data.Nehmer,game) .. " " .. data.Menge .. " money", {}, nil));
							else
								addNewOrder(WL.GameOrderEvent.Create(pid.ID, toname(data.Spender,game) .. " gifted you " .. data.Menge ..  " money", {}, nil));
							end
						else
							if(data.DeclinedBy == pid.ID)then
								addNewOrder(WL.GameOrderEvent.Create(pid.ID, "You declined the peace offer from " .. toname(data.Von,game), {}, nil));
							else
								addNewOrder(WL.GameOrderEvent.Create(pid.ID, toname(data.DeclinedBy,game) .. " declined your peace offer", {}, nil));
							end
						end
					end
					if(data.Type == 12)then
						addNewOrder(WL.GameOrderEvent.Create(pid.ID, "The territory sell offer for the territory " .. getterrname(data.terrid,game) .. " by " ..toname(data.Von,game) .. " didn't existed any longer, when you tried to buy it", {}, nil));
					end
					if(data.Type == 13)then
						addNewOrder(WL.GameOrderEvent.Create(pid.ID, toname(data.Buyer,game) .. " tried to buy " .. getterrname(data.terrid,game) .. " from you, but you had just " .. tostring(data.YourMoney) .. " of " .. tostring(data.Preis) .. " money", {}, nil));
					end
					if(data.Type == 14)then
						addNewOrder(WL.GameOrderEvent.Create(pid.ID, toname(data.Buyer,game) .. " tried to buy " .. getterrname(data.terrid,game) .. " from you, but he hadn't enough money", {}, nil));
					end
					if(data.Type == 15)then
						if(data.OfferedBy == pid.ID)then
							addNewOrder(WL.GameOrderEvent.Create(pid.ID, "You offered " ..toname(data.OfferedTo,game) .. " an alliance", {}, nil));
						else
							addNewOrder(WL.GameOrderEvent.Create(pid.ID, toname(data.OfferedBy,game) .. " offered you an alliance", {}, nil));
						end
					end
					if(data.Type == 16)then
						if(data.OfferedBy == pid.ID)then
							addNewOrder(WL.GameOrderEvent.Create(pid.ID, "You are now allied with " .. toname(data.AcceptedBy,game), {}, nil));
						end
						if(data.AcceptedBy == pid.ID)then
							addNewOrder(WL.GameOrderEvent.Create(pid.ID, "You are now allied with " .. toname(data.OfferedBy,game), {}, nil));
						end
						if(data.OfferedBy ~= pid.ID and data.AcceptedBy ~= pid.ID)then
							addNewOrder(WL.GameOrderEvent.Create(pid.ID, toname(data.OfferedBy,game) .. " and "  .. toname(data.AcceptedBy,game) .. " are now allied", {}, nil));
						end
					end
					if(data.Type == 17)then
						if(data.OfferedBy == pid.ID)then
							addNewOrder(WL.GameOrderEvent.Create(pid.ID, toname(data.DeclinedBy,game) .. " declined your alliance offer", {}, nil));
						else
							addNewOrder(WL.GameOrderEvent.Create(pid.ID, "You declined " .. toname(data.OfferedBy,game) .. " alliance offer", {}, nil));
						end
					end
					if(data.Type == 18)then
						if(data.S1 == pid.ID)then
							addNewOrder(WL.GameOrderEvent.Create(pid.ID, "You are no longer allied with " .. toname(data.S2,game), {}, nil));
						end
						if(data.S2 == pid.ID)then
							addNewOrder(WL.GameOrderEvent.Create(pid.ID, "You are no longer allied with " .. toname(data.S1,game), {}, nil));
						end
						if(data.S1 ~= pid.ID and data.S2 ~= pid.ID)then
							addNewOrder(WL.GameOrderEvent.Create(pid.ID, toname(data.S1,game) .. " and "  .. toname(data.S2,game) .. " are no longer allied", {}, nil));
						end
					end
				end
				print("Nachrichten deleted");
				playerGameData[pid.ID].Nachrichten = {};
				playerGameData[pid.ID].upgreaded =true;
			end
		end
	end
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	if(order.proxyType == "GameOrderAttackTransfer")then
		if(result.IsAttack)then
			local toowner = game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID;
			if(WL.PlayerID.Neutral == toowner or order.PlayerID == WL.PlayerID.Neutral or InWar(order.PlayerID,toowner))then
				if(order.PlayerID ~= WL.PlayerID.Neutral and game.ServerGame.Game.Players[order.PlayerID].IsAI == false)then
					AddMoney(order.PlayerID,result.AttackingArmiesKilled.NumArmies*Mod.Settings.MoneyPerKilledArmy,playerGameData,game);
				end
				if(toowner ~= WL.PlayerID.Neutral and game.ServerGame.Game.Players[toowner].IsAI == false)then
					AddMoney(toowner,result.DefendingArmiesKilled.NumArmies*Mod.Settings.MoneyPerKilledArmy,playerGameData,game);
				end
			end
			if(result.IsSuccessful)then
				if(game.ServerGame.Game.Players[order.PlayerID].IsAI == false)then
					AddMoney(order.PlayerID,Mod.Settings.MoneyPerCapturedTerritory,playerGameData,game);
					if(Mod.Settings.MoneyPerCapturedBonus ~= 0)then
						for _,boni in pairs(game.Map.Territories[order.To].PartOfBonuses)do
							if(ownsbonus(game,boni,order.To,order.PlayerID))then
								AddMoney(order.PlayerID,Mod.Settings.MoneyPerCapturedBonus,playerGameData,game);
							end
						end
					end
				end
			end
			if(toowner ~= WL.PlayerID.Neutral and order.PlayerID ~= WL.PlayerID.Neutral)then
				if(InWar(order.PlayerID,toowner) == false)then
					skipThisOrder(WL.ModOrderControl.Skip);
					if(game.ServerGame.Game.Players[order.PlayerID].IsAIOrHumanTurnedIntoAI == true)then
						DeclareWar(order.PlayerID,toowner,game);
						if(game.ServerGame.Game.Players[toowner].IsAI == false)then
							for _,with in pairs(playerGameData[toowner].Allianzen)do
								DeclareWar(with,order.PlayerID,game);
							end
						end
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
		if(check(order.Message,"Buy Armies"))then
			local to = tonumber(stringtotable(order.Payload)[1]);
			if(game.ServerGame.LatestTurnStanding.Territories[to].OwnerPlayerID == order.PlayerID)then
				local money = GetMoney(order.PlayerID,playerGameData,game);
				local wants = tonumber(stringtotable(order.Payload)[2]);
				if(Mod.Settings.MoneyPerBoughtArmy*wants > money)then
					wants = math.floor(money/Mod.Settings.MoneyPerBoughtArmy);
				end
				if(wants > 0)then
					local effect = WL.TerritoryModification.Create(to);
					effect.SetArmiesTo = game.ServerGame.LatestTurnStanding.Territories[to].NumArmies.NumArmies + wants;
					addNewOrder(WL.GameOrderEvent.Create(order.PlayerID, "Bought " .. wants .. " Armies", {}, {effect}));
					RemoveMoney(order.PlayerID,Mod.Settings.MoneyPerBoughtArmy*wants,playerGameData,game);
					local message = {};
					message.Type = 7;
					message.Count = wants;
					message.Preis = money;
					message.terrid = to;
					message.Turn = game.Game.NumberOfTurns;
					--addnewmessage(message,order.PlayerID);
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
					--addnewmessage(message,order.PlayerID);
					addNewOrder(WL.GameOrderEvent.Create(pid.ID, "The territory sell offer for the territory " .. getterrname(terrid,game) .. " by " ..toname(von,game) .. " didn't existed any longer, when you tried to buy it", {}, nil));
				else
					local Preis = Terrselloffer.Preis;
					if(Preis < 0 and GetMoney(playerid,playerGameData,game) < Preis*-1)then
						--Seller hasn't the money to pay the person who tries buys the territory
						local message = {};
						message.Type = 4;
						message.Von = von;
						message.Preis = Preis;
						message.terrid = terrid;
						message.Turn = game.Game.NumberOfTurns;
						addNewOrder(WL.GameOrderEvent.Create(order.PlayerID, toname(von,game) .. " hasn't " .. tostring(Preis) .." to pay you for " .. getterrname(terrid,game), {}, nil));
						--addnewmessage(message,order.PlayerID);
						message = {};
						message.Type = 13;
						message.Buyer = order.PlayerID;
						message.Preis = Preis;
						message.YourMoney = GetMoney(playerid,playerGameData,game);
						message.terrid = terrid;
						message.Turn = game.Game.NumberOfTurns;
						--addnewmessage(message,von);
						addNewOrder(WL.GameOrderEvent.Create(von, toname(order.PlayerID,game) .. " tried to buy " .. getterrname(terrid,game) .. " from you, but you had only " .. tostring(GetMoney(playerid,playerGameData,game)) .. " of " .. tostring(Preis) .. " money", {}, nil));
					else
						if(Preis > 0 and GetMoney(order.PlayerID,playerGameData,game) < Preis)then
							--you haven't enough money
							local message = {};
							message.Type = 5;
							message.Von = von;
							message.Preis = Preis;
							message.YourMoney = GetMoney(order.PlayerID,playerGameData,game);
							message.terrid = terrid;
							message.Turn = game.Game.NumberOfTurns;
							--addnewmessage(message,order.PlayerID);
							addNewOrder(WL.GameOrderEvent.Create(pid.ID, "You were unable to buy " .. getterrname(terrid,game) .. " from " .. toname(von,game) .. " cause you only had " .. tostring(GetMoney(order.PlayerID,playerGameData,game)) .. " and not the required " .. tostring(Preis) .. " money", {}, nil));
							message = {};
							message.Type = 14;
							message.Buyer = order.PlayerID;
							message.Preis = Preis;
							message.terrid = terrid;
							message.Turn = game.Game.NumberOfTurns;
							--addnewmessage(message,von);
							addNewOrder(WL.GameOrderEvent.Create(pid.ID, toname(order.PlayerID,game) .. " tried to buy " .. getterrname(terrid,game) .. " from you, but he hadn't enough money", {}, nil));
						else
							--all players have the requirements for the offer
							--> buying the territory now
							Pay(order.PlayerID,von,Preis,playerGameData,game);
							local effect = WL.TerritoryModification.Create(terrid);
							effect.SetOwnerOpt = order.PlayerID;
							addNewOrder(WL.GameOrderEvent.Create(order.PlayerID, "Bought " .. game.Map.Territories[terrid].Name, {}, {effect}));
							local message = {};
							message.Type = 6;
							message.Von = von;
							message.buyer = order.PlayerID;
							message.Preis = Preis;
							message.terrid = terrid;
							message.Turn = game.Game.NumberOfTurns;
							--addnewmessage(message,order.PlayerID);
							--addnewmessage(message,von);
							addNewOrder(WL.GameOrderEvent.Create(order.PlayerID, "You bought " .. getterrname(terrid,game) .." from " .. toname(von,game) .. " for a price of " .. Preis, {}, nil));
							addNewOrder(WL.GameOrderEvent.Create(von, toname(order.PlayerID,game) .. " bought " .. getterrname(terrid,game) .." from you for a price of " .. Preis, {}, nil));
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
										--addnewmessage(message,pid.ID);
										addNewOrder(WL.GameOrderEvent.Create(pid.ID, order.PlayerID .. " bought " .. getterrname(terrid,game) .." from " .. toname(von,game), {}, nil));
									end
								end
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
				--addnewmessage(message,order.PlayerID);
				addNewOrder(WL.GameOrderEvent.Create(order.PlayerID, "You were unable to buy " .. getterrname(terrid,game) .. " from " .. toname(von,game) .. " cause he didn't own it, when you tried to buy it", {}, nil));
				--This is the error code, that order.PlayerID was unable to buy terrid, since von didn't own it
				message = {};
				message.Type = 3;
				message.Player = order.PlayerID;
				message.terrid = terrid;
				message.Turn = game.Game.NumberOfTurns;
				--addnewmessage(message,von);
				addNewOrder(WL.GameOrderEvent.Create(von, toname(order.PlayerID,game) .. " was unable to buy " .. getterrname(terrid,game) .. " from you cause you didn't onwed it at the moment, he tried to buy it", {}, nil));;
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
		addNewOrder(WL.GameOrderEvent.Create(newwar.S1, "You declared war on " .. toname(newwar.S2,game), {}, nil));
		addNewOrder(WL.GameOrderEvent.Create(newwar.S2, toname(newwar.S1,game) .. " declared war on you", {}, nil));
		for _,pid in pairs(game.ServerGame.Game.Players)do
			if(pid.IsAI == false)then
				addnewmessage(message,pid.ID);
				if(pid.ID ~= newwar.S1 and pid.ID ~= newwar.S2)then
					addNewOrder(WL.GameOrderEvent.Create(pid.ID, toname(newwar.S1,game) .. " declared war on " .. toname(newwar.S2,game), {}, nil));
				end
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
					if(pd.ID ~= canceldata.S1 and pd.ID ~= canceldata.S2)then
						--addnewmessage(message,pd.ID);
						addNewOrder(WL.GameOrderEvent.Create(pid.ID, toname(data.S1,game) .. " and "  .. toname(data.S2,game) .. " are no longer allied", {}, nil));
					end
				end
			end
		end
		addnewmessage(message,canceldata.S1);
		addNewOrder(WL.GameOrderEvent.Create(canceldata.S1, "You are no longer allied with " .. toname(canceldata.S2,game), {}, nil));
		addnewmessage(message,canceldata.S2);
		addNewOrder(WL.GameOrderEvent.Create(canceldata.S2, "You are no longer allied with " .. toname(canceldata.S1,game), {}, nil));
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
		for _,pid2 in pairs(game.ServerGame.Game.Players)do
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
	Mod.PublicGameData = publicGameData;
	--Giving Money per turn
	for _,pid in pairs(game.ServerGame.Game.PlayingPlayers)do
		if(pid.IsAI == false)then
			AddMoney(pid.ID,Mod.Settings.MoneyPerTurn,playerGameData,game);--Giving Money per turn
			if(game.ServerGame.Settings.CommerceGame == false)then
				
			else
				local moneyforplayer = {};
				moneyforplayer[pid.ID] = {};
				moneyforplayer[pid.ID][WL.ResourceType.Gold] = playerGameData[pid.ID].Money+game.ServerGame.LatestTurnStanding.NumResources(pid.ID, WL.ResourceType.Gold);
				addNewOrder(WL.GameOrderEvent.Create(pid.ID, "Received " .. playerGameData[pid.ID].Money .. " gold from Advanced Diplo Mod", {}, {},moneyforplayer));
			end
		end
	end
	finished = true;
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
		if(InWar(Player1,Player2)==false and requirewarsetting ~= nil and requirewarsetting == true)then
			--Declare war
			if(game.ServerGame.Game.Players[Player1].IsAIOrHumanTurnedIntoAI == true)then
				if(Mod.Settings.AllowAIDeclaration == true and game.ServerGame.Game.Players[Player2].IsAIOrHumanTurnedIntoAI == false)then
					DeclareWar(Player1,Player2,game);
					if(game.ServerGame.Game.Players[Player2].IsAI == false)then
						for _,with in pairs(playerGameData[Player2].Allianzen)do
							DeclareWar(with,Player1,game);
						end
					end
				end
				if(Mod.Settings.AIsDeclareAIs == true and game.ServerGame.Game.Players[Player2].IsAIOrHumanTurnedIntoAI == true)then
					DeclareWar(Player1,Player2,game);
					if(game.ServerGame.Game.Players[Player2].IsAI == false)then
						for _,with in pairs(playerGameData[Player2].Allianzen)do
							DeclareWar(with,Player1,game);
						end
					end
				end
			else
				DeclareWar(Player1,Player2,game);
				for _,with in pairs(playerGameData[Player2].Allianzen)do
					DeclareWar(with,Player1,game);
				end
			end
			return false;
		else
			return true;
		end
	else
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
				--Declare war
				if(game.ServerGame.Game.Players[Player1].IsAIOrHumanTurnedIntoAI == true)then
					if(Mod.Settings.AllowAIDeclaration == true and game.ServerGame.Game.Players[Player2].IsAIOrHumanTurnedIntoAI == false)then
						DeclareWar(Player1,Player2,game);
						for _,with in pairs(playerGameData[Player2].Allianzen)do
							DeclareWar(with,Player1,game);
						end
					end
					if(Mod.Settings.AIsDeclareAIs == true and game.ServerGame.Game.Players[Player2].IsAIOrHumanTurnedIntoAI == true)then
						DeclareWar(Player1,Player2,game);
						if(game.ServerGame.Game.Players[Player2].IsAI == false)then
							for _,with in pairs(playerGameData[Player2].Allianzen)do
								DeclareWar(with,Player1,game);
							end
						end
					end
				else
					DeclareWar(Player1,Player2,game);
					if(game.ServerGame.Game.Players[Player2].IsAI == false)then
						for _,with in pairs(playerGameData[Player2].Allianzen)do
							DeclareWar(with,Player1,game);
						end
					end
				end
				return false;
			end
		end
		return false;
	end
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
		if(Mod.PublicGameData.CantDeclare[Player1][Player2] ~= nil)then
			--the player have enforced peace
			return;
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
function addnewmessage(message,spieler)
	if(tablelength(playerGameData[spieler].NeueNachrichten) == 10)then
		local oldesturn = playerGameData[spieler].NeueNachrichten[1].Turn;
		local num = 1;
		for i,msg in pairs(playerGameData[spieler].NeueNachrichten)do
			if(msg.Turn < oldesturn)then
				oldesturn=msg.Turn;
				num=i;
			end
		end
		playerGameData[spieler].NeueNachrichten[num] = message;
	else
		playerGameData[spieler].NeueNachrichten[tablelength(playerGameData[spieler].NeueNachrichten)+1] = message;
	end
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
function getterrname(terrid,game)
	return game.Map.Territories[terrid].Name;
end
