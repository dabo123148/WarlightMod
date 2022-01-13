function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	--Called after Server_AdvanceTurn_Start
	if(order.proxyType == 'GameOrderAttackTransfer') then --Through attack, armies are lost, so we need to take a look at this case
		local from = order.From; -- returns the territory id, the attack/transfer comes from
		local to = order.To; --returns the territory id, the attack/transfer goes to
		local FromOwner = game.ServerGame.LatestTurnStanding.Territories[from].OwnerPlayerID;--returns the playerid, of the territory with the id from
		local ToOwner = game.ServerGame.LatestTurnStanding.Territories[to].OwnerPlayerID;--returns the playerid, of the territory with the id to
		if(FromOwner ~= ToOwner)then
			for _, conn in pairs(game.Map.Territories[to].ConnectedTo)do
				if(tablelength(game.ServerGame.LatestTurnStanding.Territories[conn.ID].NumArmies.SpecialUnits)>0)then
					if(conn.ID ~= from and tablelength(order.NumArmies.SpecialUnits) == 0)then
						if(game.ServerGame.LatestTurnStanding.Territories[conn.ID].OwnerPlayerID == FromOwner)then
							local effect = WL.TerritoryModification.Create(conn.ID);
							local newarmies = result.AttackingArmiesKilled.NumArmies + game.ServerGame.LatestTurnStanding.Territories[conn.ID].NumArmies.NumArmies;
							if(newarmies < 0)then
								newarmies = 0;
							end
							effect.SetArmiesTo = newarmies;
							addNewOrder(WL.GameOrderEvent.Create(FromOwner, "Heal", {}, {effect}),true);
						end
						if(game.ServerGame.LatestTurnStanding.Territories[conn.ID].OwnerPlayerID == ToOwner)then
							local effect = WL.TerritoryModification.Create(conn.ID);
							local newarmies = result.DefendingArmiesKilled.NumArmies + game.ServerGame.LatestTurnStanding.Territories[conn.ID].NumArmies.NumArmies;
							if(newarmies < 0)then
								newarmies = 0;
							end
							effect.SetArmiesTo = newarmies;
							addNewOrder(WL.GameOrderEvent.Create(ToOwner, "Heal", {}, {effect}),true);
						end
					end
				end
			end
		end
	end
	if(order.proxyType == 'GameOrderPlayCardBomb') then --You can also implement this, to revive armies, that got killed by a bomb card, to simplyfy it, I left this case out
		
	end
end
function tablelength(T)
	local count = 0;
	for _, elem in pairs(T)do
		count = count + 1;
	end
	return count;
end
