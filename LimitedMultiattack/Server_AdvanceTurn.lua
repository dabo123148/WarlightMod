function Server_AdvanceTurn_Start (game,addNewOrder)
	UbrigeAngriffe={};
	local Maximaleangriffe = Mod.Settings.MaxAttacks;
	if (Maximaleangriffe < 1) then Maximaleangriffe = 1 end;
	if (Maximaleangriffe > 100000) then Maximaleangriffe = 100000 end;
	for _, terr in pairs(game.Map.Territories) do
		UbrigeAngriffe[terr.ID] = Maximaleangriffe;
	end
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	--result GameOrderAttackTransferResult
	--order GameOrderAttackTransfer
	if(order.proxyType == 'GameOrderAttackTransfer') then
		if(UbrigeAngriffe[order.From] > 0)then
			if(result.IsSuccessful)then
				if(game.ServerGame.LatestTurnStanding.Territories[order.From].OwnerPlayerID ~= game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID)then
					UbrigeAngriffe[order.To] = UbrigeAngriffe[order.From];
				else
					UbrigeAngriffe[order.To] = 1;
				end
				UbrigeAngriffe[order.To] = UbrigeAngriffe[order.To] - 1;
			else
				UbrigeAngriffe[order.From] = 0;
			end
		else
			skipThisOrder(WL.ModOrderControl.Skip);
		end
	end
end
function Server_AdvanceTurn_End(game,addNewOrder)
	local Maximaleangriffe = Mod.Settings.MaxAttacks;
	if (Maximaleangriffe < 1) then Maximaleangriffe = 1 end;
	if (Maximaleangriffe > 100000) then Maximaleangriffe = 100000 end;
	for _, terr in pairs(game.Map.Territories) do
		UbrigeAngriffe[terr.ID] = Maximaleangriffe;
	end
end
