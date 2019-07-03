function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)	
	if(order.proxyType == 'GameOrderPlayCardAirlift')then
		local targetterritory = order.ToTerritoryID;
		for _,terrid in pairs(game.ServerGame.LatestTurnStanding.Territories) do
			if(terrid.OwnerPlayerID ~= order.PlayerID)then
				addNewOrder(WL.GameOrderEvent.Create(order.PlayerID, "Skipped an airlift since the target territory was next to an enemy territory", {}, nil, nil));
				skipThisOrder(WL.ModOrderControl.Skip);
				return;
			end
		end
end