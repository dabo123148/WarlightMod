
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	--result GameOrderAttackTransferResult
	--order GameOrderAttackTransfer
    if (order.proxyType == 'GameOrderAttackTransfer') then
		for _, unit in pairs(order.NumArmies.SpecialUnits) do
			skipThisOrder(WL.ModOrderControl.Skip);
			addNewOrder(WL.GameOrderAttackTransfer.Create(order.PlayerID, order.From, order.To, order.AttackTransfer , order.ByPercent , WL.Armies.Create(order.NumArmies.NumArmies), order.AttackTeammates))
		end
	end
end
