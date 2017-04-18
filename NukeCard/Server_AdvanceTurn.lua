function Server_AdvanceTurn_Start (game,addNewOrder)
	SkippedOrders = {};
	executed = false;
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	if(executed == false)then
		if(order.proxyType ~= 'GameOrderDeploy')then--deployorders needn't to be skipped
			SkippedOrders[tablelength(SkippedOrders)] = order;
		end
	end
end
function Server_AdvanceTurn_End(game, addNewOrder)
	if(executed == false)then
		executed = true;
		local deployed = false;
		local Renaisanceterr = {};
		for _,order in pairs(SkippedOrders) do
			if(order.proxyType == 'GameOrderPlayCardReconnaissance')then
				Renaisanceterr[tablelength(Renaisanceterr)] = order;
			end
		end
		for _,order in pairs(SkippedOrders) do
			if(deployed == false)then
				deployed = true;
				for _,bombterrid in pairs(Renaisanceterr) do
					local Effect = {};
					for _,conn in pairs(game.Map.Territories[bombterrid]) do
						Effect[tablelength(Effect)] = WL.TerritoryModification.Create(conn.ID);
						Effect[tablelength(Effect)-1].SetArmiesTo = game.ServerGame.LatestTurnStanding.Territories[conn.ID].NumArmies.NumArmies*0.75;
					end
					Effect[tablelength(Effect)] = WL.TerritoryModification.Create(bombterrid);
					Effect[tablelength(Effect)-1].SetArmiesTo = game.ServerGame.LatestTurnStanding.Territories[bombterrid].NumArmies.NumArmies/2;
					addNewOrder(WL.GameOrderEvent.Create(order.PlayerID,'Nuke',{},Effect));
				end
			end
			if(order.proxyType ~= 'GameOrderPlayCardReconnaissance')then
				addNewOrder(order);
			end
		end
	end
end
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
