function Server_AdvanceTurn_Start (game,addNewOrder)
	ExtraMoneyPerPlayer = {};
	for _,pid in pairs(game.Game.PlayingPlayers) do
		ExtraMoneyPerPlayer[pid.ID] = 0;
	end
end
function ChangeMoney(playerID,value,game)
	if(game.Game.PlayingPlayers[playerID] ~= nil)then
		ExtraMoneyPerPlayer[playerID] = ExtraMoneyPerPlayer[playerID] + value;
	end
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	if(game.ServerGame.Settings.CommerceGame == true)then
		if(order.proxyType == "GameOrderAttackTransfer")then
			if(result.IsAttack)then
				local toowner = game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID;
				if(toowner ~= order.PlayerID)then
					ChangeMoney(order.PlayerID,result.AttackingArmiesKilled.NumArmies*Mod.Settings.MoneyPerKilledArmy,game);
					ChangeMoney(toowner,result.DefendingArmiesKilled.NumArmies*Mod.Settings.MoneyPerKilledArmy,game);
				end
				if(result.IsSuccessful)then
					ChangeMoney(order.PlayerID,Mod.Settings.MoneyPerCapturedTerritory,game);
					if(Mod.Settings.MoneyPerCapturedBonus ~= 0)then
						for _,boni in pairs(game.Map.Territories[order.To].PartOfBonuses)do
							if(ownsbonus(game,boni,order.To,order.PlayerID))then
								ChangeMoney(order.PlayerID,Mod.Settings.MoneyPerCapturedBonus,game);
							end
						end
					end
				end
			end
		end
	end
end
function Server_AdvanceTurn_End (game,addNewOrder)
	if(game.ServerGame.Settings.CommerceGame == true)then
		for _,pid in pairs(game.ServerGame.Game.PlayingPlayers)do
			local moneyforplayer = {};
			moneyforplayer[pid.ID] = {};
			print(game.ServerGame.Game.Players[pid.ID].Resources[WL.ResourceType.Gold]);
			moneyforplayer[pid.ID][WL.ResourceType.Gold] = ExtraMoneyPerPlayer[pid.ID]+game.ServerGame.Game.Players[pid.ID].Resources[WL.ResourceType.Gold];
			addNewOrder(WL.GameOrderEvent.Create(pid.ID, "Recieved " .. ExtraMoneyPerPlayer[pid.ID] .. " gold from Commerce Plus", {}, {},moneyforplayer));
		end
	end
end
function ownsbonus(game,bonusid,ignorterrid,playerID)
	for _,terrid in pairs(game.Map.Bonuses[bonusid].Territories)do
		if(terrid ~= ignorterrid)then
			if(game.ServerGame.LatestTurnStanding.Territories[terrid].OwnerPlayerID ~= playerID)then
				return false;
			end
		end
	end
	return true;
end
function tablelength(T)
	local count = 0;
	for _,elem in pairs(T)do
		count = count + 1;
	end
	return count;
end
