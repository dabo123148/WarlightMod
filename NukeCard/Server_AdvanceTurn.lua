function Server_AdvanceTurn_Start (game,addNewOrder)
	SkippedOrders = {};
	executed = false;
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	if(executed == false)then
		if(order.proxyType ~= 'GameOrderDeploy')then--deployorders needn't to be skipped
			SkippedOrders[tablelength(SkippedOrders)] = order;
			skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);
		end
	end
end
function Server_AdvanceTurn_End(game, addNewOrder)
	if(executed == false)then
		executed = true;
		local Renaisanceterr = {};
		for _,order in pairs(SkippedOrders) do
			if(order.proxyType == 'GameOrderPlayCardReconnaissance')then
				local Effect = {};
				for _,conn in pairs(game.Map.Territories[order.TargetTerritory].ConnectedTo) do
					Effect[tablelength(Effect)+1] = WL.TerritoryModification.Create(conn.ID);
					Effect[tablelength(Effect)].SetArmiesTo = game.ServerGame.LatestTurnStanding.Territories[conn.ID].NumArmies.NumArmies*0.75;
				end
				Effect[tablelength(Effect)+1] = WL.TerritoryModification.Create(order.TargetTerritory);
				Effect[tablelength(Effect)].SetArmiesTo = game.ServerGame.LatestTurnStanding.Territories[order.TargetTerritory].NumArmies.NumArmies/2;
				addNewOrder(WL.GameOrderEvent.Create(order.PlayerID,'Nuked ' .. game.Map.Territories[order.TargetTerritory].Name,{},Effect));
			end
		end
		for _,order in pairs(SkippedOrders) do
			addNewOrder(order);
		end
	end
end
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
