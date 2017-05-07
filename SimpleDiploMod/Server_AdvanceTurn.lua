function Server_AdvanceTurn_Start (game,addNewOrder)
	print('T0');
	AllAIs = {};
	print('T1');
	for _,terr in pairs(game.ServerGame.LatestTurnStanding.Territories)do
		local Match = false;
		local CheckingID = terr.OwnerPlayerID;
		print('T2');
		if(CheckingID ~= WL.PlayerID.Neutral)then
			print('T3');
			if(game.Game.Players[CheckingID].IsAI)then
				print('T4');
				for _,knownAIs in pairs(AllAIs)do
					if(CheckingID == knownAIs)then
						print('T5');
						Match = true;
					end
				end
				if(Match == false)then
					print('T6');
					AllAIs[tablelength(AllAIs)] = CheckingID;
				end
			end
		end
	end
	print('T7');
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	if(order.proxyType == "GameOrderAttackTransfer")then
		if(result.IsAttack)then
			if(InWar(order.From,order.To) == true and order.To ~= WL.PlayerID.Neutral)then
				--Set attacks between
			else
				skipThisOrder(WL.ModOrderControl.Skip);
				--War declaration
				if(Mod.Settings.AllowAIDeclaration == false)then
					local Match = false;
					if(AllAIs == nil)then
						print('Fehler');
					end
					for _, AI in pairs(AllAIs)do
						if(order.From == AI)then
							Match = true;
						end
					end
					if(Match == false)then
						DeclearWar(Player1,Player2);
						--Allys declear war on order.From if not allied with order.From
					end
				else
					DeclearWar(Player1,Player2);
					--Allys declear war on order.From if not allied with order.From
				end
			end
		end
	end
	--War declearation through sanction card
	if(order.proxyType == "GameOrderPlayCardSanctions")then
		skipThisOrder(WL.ModOrderControl.Skip);
		if(InWar(order.PlayerID,order.SanctionedPlayerID) == false)then
			if(Mod.Settings.AllowAIDeclaration == false)then
				local Match = false;
				if(AllAIs == nil)then
					print('Fehler');
				end
				for _, AI in pairs(AllAIs)do
					if(order.From == AI)then
						Match = true;
					end
				end
				if(Match == false)then
					DeclearWar(order.PlayerID,order.SanctionedPlayerID);
					--Allys declear war on order.PlayerID if not allied with order.PlayerID
				end
			else
				DeclearWar(order.PlayerID,order.SanctionedPlayerID);
				--Allys declear war on order.PlayerID if not allied with order.PlayerID
			end
		else
			--peace offer, but Allys are still in war
		end
	end
	--Ally offer & Peace declearation
	if(order.proxyType == "GameOrderPlayCardSpy")then
		
	end
end
function Server_AdvanceTurn_Start (game,addNewOrder)
	--add new Allys
	--add new war decleartions
	if(RemainingDecerations ~= nil)then
		for _,P1 in pairs(RemainingDecerations)do
			for _,P2 in pairs(P1)do
				if(RemainingDecerations[P1][P2] == true)then
					addNewOrder(WL.GameOrderEvent.Create(order.From, "The Player with the player ID " ..P1 .. " decleared war on " .. P2, nil, {}));
				end
			end
		end
	end
	if(Mod.Settings.SeeAllyTerritories)then
		--play on every ally a spy card
	end
end
function RemoveAlly(Player1,Player2)
end
function RemoveWar(Player1,Player2)
end
function DeclearWar(Player1,Player2)
	if(IsAlly(Player1,Player2)==false)then
		if(RemainingDecerations == nil)then
			RemainingDecerations = {{}};
		end
		RemainingDecerations[Player1][Player2] = true;
	else
		RemoveAlly(Player1,Player2);
	end
end
function InWar(Player1,Player2)
	return false;
end
function DeclearAlly(Player1,Player2)
	
end
function IsAlly(Player1,Player2)
	return false;
end
function tablelength(T)
	local count = 0;
	for _,elem in pairs(T)do
		count = count + 1;
	end
	return count;
end
