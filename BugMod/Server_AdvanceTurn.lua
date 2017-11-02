function Server_AdvanceTurn_Start (game,addNewOrder)
	playerGameData = Mod.PlayerGameData;
	playerGameData = {};
	for _,pid in pairs(game.ServerGame.Game.PlayingPlayers)do
		if(pid.IsAI == false)then
			playerGameData[pid.ID] = {};
			playerGameData[pid.ID].Money = 1;
		end
	end
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
--Giving for every new order one money to the player
	if(game.ServerGame.Game.PlayingPlayers[order.PlayerID].IsAI == false)then
		playerGameData[order.PlayerID].Money = playerGameData[order.PlayerID].Money +1;
	end
end
function Server_AdvanceTurn_End (game,addNewOrder)
--Giving the money to the players
	for _,pid in pairs(game.ServerGame.Game.PlayingPlayers)do
		if(pid.IsAI == false)then
			local moneyforplayer = {};
			moneyforplayer[pid.ID] = {};
			moneyforplayer[pid.ID][WL.ResourceType.Gold] = playerGameData[pid.ID].Money;
			addNewOrder(WL.GameOrderEvent.Create(pid.ID, "Received " .. playerGameData[pid.ID].Money .. " gold from Advanced Diplo Mod", {}, {},moneyforplayer));
			playerGameData[pid.ID].Money = 0;
		end
	end
	
	Mod.PlayerGameData = playerGameData;
end
function tablelength(T)
	local count = 0;
	for _,elem in pairs(T)do
		count = count + 1;
	end
	return count;
end