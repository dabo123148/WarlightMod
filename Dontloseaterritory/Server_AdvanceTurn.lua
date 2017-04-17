
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	--result GameOrderAttackTransferResult
	--order GameOrderAttackTransfer
    if (order.proxyType == 'GameOrderAttackTransfer') then
		--Checking if a territory has a commmander
		local Zahl = 0;
		for _, unit in pairs(order.NumArmies.SpecialUnits) do
			--in an earlyer version I checked if unit.ID == Mod.Settings and then removed the order and adapted it
			Zahl = 1;
		end
		if(Zahl == 1) then
			--Skiping the order, if a special unit is part of an attack
			skipThisOrder(WL.ModOrderControl.Skip);
			addNewOrder(WL.GameOrderAttackTransfer.Create(order.PlayerID, order.From, order.To, order.AttackTransfer , order.ByPercent , WL.Armies.Create(order.NumArmies.NumArmies), order.AttackTeammates));
		end
	end
end
