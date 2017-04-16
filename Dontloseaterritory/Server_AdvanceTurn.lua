
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	--result GameOrderAttackTransferResult
	--order GameOrderAttackTransfer
    if (order.proxyType == 'GameOrderAttackTransfer' and game.ServerGame.LatestTurnStanding.Territories[order.From].OwnerPlayerID == Mod.Settings.Spieler) then
		for _, unit in pairs(order.NumArmies.SpecialUnits) do
			skipThisOrder(WL.ModOrderControl.Skip);
			addNewOrder(WL.GameOrderAttackTransfer.Create(order.PlayerID, order.From, order.To, order.AttackTransfer , order.ByPercent , WL.Armies.Create(order.NumArmies.NumArmies), order.AttackTeammates));		end
		end
	end
end
