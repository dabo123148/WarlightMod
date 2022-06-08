function Server_AdvanceTurn_Start (game,addNewOrder)
	SkippedAirlifts = {};
	executed = false;
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)	
	if(executed == false)then
		if(order.proxyType == 'GameOrderPlayCardAirlift')then
			SkippedAirlifts[tablelength(SkippedAirlifts)] = order;
			skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);
		end
	end
end
function Server_AdvanceTurn_End(game,addNewOrder)
	if(executed == false) then
		executed = true;
		for _,order in pairs(SkippedAirlifts)do
			local toowner = game.ServerGame.LatestTurnStanding.Territories[order.ToTerritoryID].OwnerPlayerID;
			if(order.PlayerID == game.ServerGame.LatestTurnStanding.Territories[order.FromTerritoryID].OwnerPlayerID)then
				if(game.ServerGame.Game.Players[order.PlayerID].TeamID == game.ServerGame.Game.Players[toowner].TeamID)then
					addNewOrder(order);
				end
			end
		end
	end
end
function tablelength(T)
	local count = 0;
	for _ in pairs(T) do count = count + 1 end;
	return count;
end
