function Server_AdvanceTurn_Start (game,addNewOrder)
	SkippedOrders = {};
	executed = false;
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	if(order.proxyType == 'GameOrderPlayCardReconnaissance') then
		skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);
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
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
