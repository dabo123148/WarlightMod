function Server_AdvanceTurn_Start (game,addNewOrder)
	AllAIs = {};
	for _,terr in pairs(game.ServerGame.LatestTurnStanding.Territories)do
		local Match = false;
		local CheckingID = terr.OwnerPlayerID;
		if(CheckingID ~= WL.PlayerID.Neutral)then
			if(game.Game.Players[CheckingID].IsAI)then
				for _,knownAIs in pairs(AllAIs)do
					if(CheckingID == knownAIs)then
						Match = true;
					end
				end
				if(Match == false)then
					AllAIs[tablelength(AllAIs)] = CheckingID;
				end
			end
		end
	end
	AllPlayerIDs = {};
	for _,terr in pairs(game.ServerGame.LatestTurnStanding.Territories)do
		local Match = false;
		local CheckingID = terr.OwnerPlayerID;
		if(CheckingID ~= WL.PlayerID.Neutral)then
			for _,knownPlayers in pairs(AllPlayerIDs)do
				if(CheckingID == knownPlayers)then
					Match = true;
				end
			end
			if(Match == false)then
				AllPlayerIDs[tablelength(AllPlayerIDs)] = CheckingID;
			end
		end
	end
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	if(order.proxyType == "GameOrderAttackTransfer")then
		if(result.IsAttack and game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID ~= WL.PlayerID.Neutral)then
			if(InWar(game.ServerGame.LatestTurnStanding.Territories[order.From].OwnerPlayerID,game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID) == true)then
				--Set attacks between
			else
				skipThisOrder(WL.ModOrderControl.Skip);
				--War declaration
				if(Mod.Settings.AllowAIDeclaration == false)then
					local Match = false;
					for _, AI in pairs(AllAIs)do
						if(game.ServerGame.LatestTurnStanding.Territories[order.From].OwnerPlayerID == AI)then
							Match = true;
						end
					end
					if(Match == false)then
						DeclearWar(game.ServerGame.LatestTurnStanding.Territories[order.From].OwnerPlayerID,game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID);
						--Allys declear war on order.From if not allied with order.From
					end
				else
					DeclearWar(game.ServerGame.LatestTurnStanding.Territories[order.From].OwnerPlayerID,game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID);
					--Allys declear war on order.From if not allied with order.From
				end
			end
		end
	end
	--War declearation through sanction card
	if(order.proxyType == "GameOrderPlayCardSanctions")then
		print('Sanction');
		skipThisOrder(WL.ModOrderControl.Skip);
		if(InWar(order.PlayerID,order.SanctionedPlayerID) == false)then
			if(Mod.Settings.AllowAIDeclaration == false)then
				local Match = false;
				if(AllAIs == nil)then
					print('Fehler');
				end
				for _, AI in pairs(AllAIs)do
					if(order.PlayerID == AI)then
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
function Server_AdvanceTurn_End (game,addNewOrder)
	--add new Allys
	--add new war decleartions
	if(RemainingDeclerations ~= nil)then
		print('T5');
		for _,newwar in pairs(RemainingDeclerations)do
			local P1 = tonumber(stringtotable(newwar)[1]);
			local P2 = tonumber(stringtotable(newwar)[2]);
			local newinwar = {};
			if(War[P1] ~= nil)then
				for _, alreadyinwar in pairs(War[P1])do
					newinwar[alreadyinwar] = true;
				end
			end
			newinwar[P2] = true;
			War[P1] = newinwar;
			--addNewOrder(WL.GameOrderEvent.Create(WL.PlayerID.Neutral, "The Player with the player ID " .. tostring(P1) .. " decleared war on " .. tostring(P2), nil,{}));
			addNewOrder(WL.GameOrderCustom.Create(P1, "Declears war on " .. tostring(P2), "War " .. tostring(P1) .. " " .. tostring(P2));
			local P3 = P2;
			P2 = P1;
			p1 = P3;
			local newinwar = {};
			if(War[P1] ~= nil)then
				for _, alreadyinwar in pairs(War[P1])do
					newinwar[alreadyinwar] = true;
				end
			end
			newinwar[P2] = true;
			War[P1] = newinwar;
		end
	end
	RemainingDeclerations = {};
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
		if(RemainingDeclerations == nil)then
			RemainingDeclerations = {};
		end
		local Match = false;
		for _,newwar in pairs(RemainingDeclerations)do
			local P1 = tonumber(stringtotable(newwar)[1]);
			local P2 = tonumber(stringtotable(newwar)[2]);
			if(P1 == Player1 or P1 == Player2)then
				if(P2 == Player1 or P2 == Player2)then
					Match = true;
				end
			end
		end
		if(Match == false)then
			RemainingDeclerations[tablelength(RemainingDeclerations)] = Player1 .. "," ..Player2;
		end
		print('T4');
	else
		RemoveAlly(Player1,Player2);
	end
end
function InWar(Player1,Player2)
	if(War == nil)then
		print('neu gesetzt');
		War = {{}};
	end
	if(War[Player1] ~= nil)then
		print('Test');
		if(War[Player1][Player2])then
			print('Test2');
			return true;
		end
	end
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
