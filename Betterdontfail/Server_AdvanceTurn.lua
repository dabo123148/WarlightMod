function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	--result GameOrderAttackTransferResult
	--order GameOrderAttackTransfer
	if(order.proxyType == 'GameOrderAttackTransfer') then
		if(result.IsSuccessful == false)then
			local terr = game.ServerGame.LatestTurnStanding.Territories[order.To];
			terrMod = WL.TerritoryModification.Create(terr.ID);
			terrMod.SetOwnerOpt=terr.OwnerPlayerID;
			terrMod.SetArmiesTo = result.DefendingArmiesKilled.NumArmies+result.AttackingArmiesKilled.NumArmies+game.ServerGame.LatestTurnStanding.Territories[order.To].NumArmies.NumArmies;
			addOrder(WL.GameOrderEvent.Create(terr.OwnerPlayerID,"Attackfailed",{},{terrMod}));
		end
	end
end
