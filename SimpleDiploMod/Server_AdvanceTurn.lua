function Server_AdvanceTurn_Start (game,addNewOrder)
	AllAIs = {};
	for _,terr in pairs(game.ServerGame.LatestTurnStanding.Territories)do
		local CheckingID = terr.OwnerPlayerID;
		if(CheckingID ~= WL.PlayerID.Neutral)then
			if(game.Game.Players[CheckingID].IsAI)then
				local Match = false;
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
			for _,knownAI in pairs(AllAIs)do
				if(CheckingID == knownAI)then
					Match = true;
				end
			end
			if(Match == false)then
				AllPlayerIDs[tablelength(AllPlayerIDs)] = CheckingID;
			end
		end
	end
	Attacksbetween = {};
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	if(order.proxyType == "GameOrderAttackTransfer")then
		if(result.IsAttack and game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID ~= WL.PlayerID.Neutral)then
			if(InWar(order.PlayerID,game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID) == true)then
				local playerGameData = Mod.PlayerGameData;
				if(result.IsSuccessful)then
					for _,spieler in pairs(AllPlayerIDs)do
						if(spieler == order.PlayerID)then
							playerGameData[order.PlayerID].Money = Mod.PlayerGameData[order.PlayerID].Money+ Mod.Settings.MoneyPerCapturedTerritory;
						end
					end
				end
				local toowner = game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID;
				for _,spieler in pairs(AllPlayerIDs)do
					if(spieler == order.PlayerID)then
						playerGameData[order.PlayerID].Money = Mod.PlayerGameData[order.PlayerID].Money+ result.AttackingArmiesKilled.NumArmies*Mod.Settings.MoneyPerKilledArmy;
					end
					if(spieler == toowner)then
						playerGameData[toowner].Money = playerGameData[toowner].Money + result.DefendingArmiesKilled.NumArmies*Mod.Settings.MoneyPerKilledArmy;
					end
				end
				Mod.PlayerGameData = playerGameData;
			else
				skipThisOrder(WL.ModOrderControl.Skip);
				if(Mod.Settings.AllowAIDeclaration == false or Mod.Settings.AIsdeclearAIs  == false)then
					local Match1 = false;
					local Match2 = false;
					for _, AI in pairs(AllAIs)do
						if(order.PlayerID == AI)then
							Match1 = true;
						end
						if(game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID == AI)then
							Match2 = true;
						end
					end
					if(Match1 == false)then
						DeclearWar(order.PlayerID,game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID,game);
					else
						if(Mod.Settings.AllowAIDeclaration and Match2 == false)then
							DeclearWar(order.PlayerID,game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID,game);
						else
							if(Mod.Settings.AIsdeclearAIs and Match2 == true)then
								DeclearWar(order.PlayerID,game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID,game);
							end
						end
					end
				else
					DeclearWar(order.PlayerID,game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID,game);
				end
			end
		end
	end
	if(order.proxyType == "GameOrderCustom")then
		if(check(order.Message,"Declared war on"))then
			if(InWar(order.PlayerID,order.Payload) == false)then
				DeclearWar(order.PlayerID,tonumber(order.Payload),game);
			end
		end
		if(check(order.Message,"Removed ally with"))then
			
		end
		skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);
	end
	if(order.proxyType == "GameOrderPlayCardSanctions" and Mod.Settings.SanctionCardRequireWar)then
		if(InWar(order.PlayerID,order.SanctionedPlayerID) == false)then
			local Match1 = false;
			local Match2 = false;
			for _, AI in pairs(AllAIs)do
				if(order.PlayerID == AI)then
					Match1 = true;
				end
				if(order.SanctionedPlayerID == AI)then
					Match2 = true;
				end
			end
			if(Match1 == false)then
				DeclearWar(order.PlayerID,order.SanctionedPlayerID,game);
			else
				if(Mod.Settings.AllowAIDeclaration and Match2 == false)then
					DeclearWar(order.PlayerID,order.SanctionedPlayerID,game);
				else
					if(Mod.Settings.AIsdeclearAIs and Match2 == true)then
						DeclearWar(order.PlayerID,order.SanctionedPlayerID,game);
					end
				end
			end
			skipThisOrder(WL.ModOrderControl.Skip);
		end
	end
	if(order.proxyType == "GameOrderPlayCardBomb" and Mod.Settings.BombCardRequireWar)then
		if(InWar(order.PlayerID,game.ServerGame.LatestTurnStanding.Territories[order.TargetTerritoryID].OwnerPlayerID) == false)then
			local Match1 = false;
			local Match2 = false;
			for _, AI in pairs(AllAIs)do
				if(order.PlayerID == AI)then
					Match1 = true;
				end
				if(game.ServerGame.LatestTurnStanding.Territories[order.TargetTerritoryID].OwnerPlayerID == AI)then
					Match2 = true;
				end
			end
			if(Match1 == false)then
				DeclearWar(order.PlayerID,game.ServerGame.LatestTurnStanding.Territories[order.TargetTerritoryID].OwnerPlayerID,game);
			else
				if(Mod.Settings.AllowAIDeclaration and Match2 == false)then
					DeclearWar(order.PlayerID,game.ServerGame.LatestTurnStanding.Territories[order.TargetTerritoryID].OwnerPlayerID,game);
				else
					if(Mod.Settings.AIsdeclearAIs and Match2 == true)then
						DeclearWar(order.PlayerID,game.ServerGame.LatestTurnStanding.Territories[order.TargetTerritoryID].OwnerPlayerID,game);
					end
				end
			end
			skipThisOrder(WL.ModOrderControl.Skip);
		end
	end
end
function Server_AdvanceTurn_End (game,addNewOrder)
	--add new Allys
	--add new war decleartions
	local playerGameData = Mod.PlayerGameData;
	if(RemainingDeclerations ~= nil)then
		for _,newwar in pairs(RemainingDeclerations)do
			local P1 = tonumber(stringtotable(newwar)[1]);
			local P2 = tonumber(stringtotable(newwar)[2]);
			local publicGameData = Mod.PublicGameData;
			if(Mod.PublicGameData.War[P1] ~= nil)then
				local with = Mod.PublicGameData.War[P1] .. tostring(P2) .. ",";
				publicGameData.War[P1] = with;
			else
				publicGameData.War[P1] = "," .. tostring(P2) .. ",";
			end
			addNewOrder(WL.GameOrderEvent.Create(P1, "Declared war on " .. toname(P2,game), nil,{}));
			local P3 = P2;
			P2 = P1;
			P1 = P3;
			if(Mod.PublicGameData.War[P1] ~= nil)then
				local with = Mod.PublicGameData.War[P1] .. tostring(P2) .. ",";
				publicGameData.War[P1] = with;
			else
				publicGameData.War[P1] = "," .. tostring(P2) .. ",";
			end
			Mod.PublicGameData = publicGameData;
			for _, spieler in pairs(AllPlayerIDs)do
				if(playerGameData[spieler].NeueNachrichten==nil)then
					playerGameData[spieler].NeueNachrichten = ",";
				end
				if(playerGameData[spieler].Nachrichten==nil)then
					playerGameData[spieler].Nachrichten = ",";
				end
				playerGameData[spieler].NeueNachrichten = playerGameData[spieler].NeueNachrichten ..  P2 .. ",0," .. (game.Game.NumberOfTurns+1) ..",".. P1 .. ",";
				playerGameData[spieler].Nachrichten = playerGameData[spieler].Nachrichten ..  P2 .. ",0,".. (game.Game.NumberOfTurns+1).."," .. P1 .. ",";
			end
		end
	end
	RemainingDeclerations = {};
	local privateGameData = Mod.PrivateGameData;
	if(privateGameData.Cantdeclare~= nil)then
		privateGameData.Cantdeclare[game.Game.NumberOfTurns] = ",";
	end
	Mod.PrivateGameData = privateGameData;
	--Giving Money per turn
	for _,spieler in pairs(AllPlayerIDs)do
		playerGameData[spieler].Money = playerGameData[spieler].Money + Mod.Settings.MoneyPerTurn;--Giving Money per turn
	end
	Mod.PlayerGameData = playerGameData;
	--if(Mod.Settings.SeeAllyTerritories)then
		--play on every ally a reconnaisance card
		--for _, player in pairs(AllPlayerIDs)do
			--for _, terr in pairs(game.ServerGame.LatestTurnStanding.Territories)do
				--if(IsAlly(player,terr.OwnerPlayerID))then
					--addNewOrder(WL.GameOrderPlayCardReconnaissance.Create(WL.NoParameterCardInstance.Create(100, WL.CardID.Reconnaissance), player, terr));
				--end
			--end
		--end
	--end
end
function getplayerid(playername,game)
	for _,playerinfo in pairs(game.ServerGame.Game.Players)do
		local name = playerinfo.DisplayName(nil, false);
		if(name == playername)then
			return playerinfo.ID;
		end
	end
	return 0;
end
function toname(playerid,game)
	local test = "";
	for _,playerinfo in pairs(game.ServerGame.Game.Players)do
		if(playerid == playerinfo.ID)then
			--return tostring(playerid) .. " " .. tostring(playerinfo.ID);
			--local name = playerinfo.DisplayName(nil, false);
			local name = playerinfo.Color.Name;
			if(name == nil or name == "")then
				return "fehler";
			else
				return name;
			end
		end
	end
	return "Error. Please report to dabo1.";
end
function RemoveAlly(Player1,Player2)
	
end
function RemoveWar(Player1,Player2)
	
end
function DeclearWar(Player1,Player2,game)
	print('Declear War');
	--Allys declear war on order.PlayerID if not allied with order.PlayerID
	if(IsAlly(Player1,Player2)==false and InWar(Player1,Player2) == false)then
		print('D1');
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
			if(Mod.PrivateGameData.Cantdeclare ~= nil and Mod.PrivateGameData.Cantdeclare[game.Game.NumberOfTurns] ~= nil)then
				local privateGameDatasplit = stringtotable(Mod.PrivateGameData.Cantdeclare[game.Game.NumberOfTurns]);
				local num = 1;
				while(privateGameDatasplit[num] ~= nil and privateGameDatasplit[num+1] ~= nil and privateGameDatasplit[num+1] ~= "")do
					if(tonumber(privateGameDatasplit[num]) == Player1 or tonumber(privateGameDatasplit[num+1]) == Player1)then
						if(tonumber(privateGameDatasplit[num]) == Player2 or tonumber(privateGameDatasplit[num+1]) == Player2)then
							Match = true;
						end
					end
					num = num + 2;
				end
			end
			if(Match == false)then
				RemainingDeclerations[tablelength(RemainingDeclerations)] = "," .. Player1 .. "," ..Player2;
			end
		end
	else
		RemoveAlly(Player1,Player2);
	end
end
function InWar(Player1,Player2)
	if(Mod.PublicGameData.War == nil)then
		print('neu gesetzt');
		local publicGameData = Mod.PublicGameData;
 		publicGameData.War={};
		Mod.PublicGameData=publicGameData;
	end
	if(Mod.PublicGameData.War[Player1] ~= nil)then
		local with = stringtotable(Mod.PublicGameData.War[Player1]);
		for _,pID in pairs(with)do
			print(pID .. " " .. Player2);
			if(tostring(pID) == tostring(Player2))then
				print("sind im krieg");
				return true;
			end
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
			print(mess[num] .. ' ' .. varchararray[num]);
			return false;
		end
		num = num + 1;
	end
	return match;
end
