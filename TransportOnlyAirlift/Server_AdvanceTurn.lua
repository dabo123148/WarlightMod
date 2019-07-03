function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)	
	if(order.proxyType == 'GameOrderPlayCardAirlift')then
		local targetterritory = order.ToTerritoryID;
		for _,terrid in pairs(game.Map.Territories[targetterritory].ConnectedTo) do
			local connowner = game.ServerGame.LatestTurnStanding.Territories[terrid.ID].OwnerPlayerID;
			local inteam = game.ServerGame.Game.Players[order.PlayerID].Team;
			if(inteam ~= -1)then
				if(connowner ~= order.PlayerID and connowner ~= WL.PlayerID.Neutral and game.ServerGame.Game.Players[connowner].Team ~= inteam)then
					addNewOrder(WL.GameOrderEvent.Create(order.PlayerID, "Skipped an airlift since the target territory was next to an enemy territory", {}, nil, nil));
					skipThisOrder(WL.ModOrderControl.Skip);
					return;
				end
			else
				if(connowner ~= order.PlayerID and connowner ~= WL.PlayerID.Neutral)then
					addNewOrder(WL.GameOrderEvent.Create(order.PlayerID, "Skipped an airlift since the target territory was next to an enemy territory", {}, nil, nil));
					skipThisOrder(WL.ModOrderControl.Skip);
					return;
				end
			end
		end
	end
end
