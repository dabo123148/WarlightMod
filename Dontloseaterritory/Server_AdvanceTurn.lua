
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	--result GameOrderAttackTransferResult
	--order GameOrderAttackTransfer
    if (order.proxyType == 'GameOrderAttackTransfer' and game.ServerGame.LatestTurnStanding.Territories[order.From].OwnerPlayerID == Mod.Settings.Spieler) then
		for _, unit in pairs(order.NumArmies.SpecialUnits) do
			print(unit.ID);
			for _, created in pairs(Mod.Settings.CreatedCommander) do
			print('T1');
				if(unit.ID == created.ID) then
					print('T2');
					skipThisOrder(WL.ModOrderControl.Skip);
					addNewOrder(WL.GameOrderAttackTransfer.Create(order.PlayerID, order.From, order.To, order.AttackTransfer , order.ByPercent , WL.Armies.Create(order.NumArmies.NumArmies), order.AttackTeammates))
				end
			end
		end
	end
end

function IsDestinationNeutral(game, order)
	local terrID = order.To; --The order has "To" and "From" which are territory IDs
	local terrOwner = game.ServerGame.LatestTurnStanding.Territories[terrID].OwnerPlayerID; --LatestTurnStanding always shows the current state of the game.
	return terrOwner == WL.PlayerID.Neutral;
end
