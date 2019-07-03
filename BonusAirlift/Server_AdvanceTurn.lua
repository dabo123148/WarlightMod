function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)	
	if(order.proxyType == 'GameOrderPlayCardAirlift')then
		local targetterritory = order.ToTerritoryID;
		local from = order.FromTerritoryID;
		local modify = {};
		local modifyid = 1;
		local armiestolift = 0;
		local alreadymodified = {};
		for _,bonusid in pairs(game.Map.Territories[from].PartOfBonuses) do
			if((game.Settings.OverriddenBonuses[bonusid] == nil and game.Map.Bonuses[bonusid].Amount ~=0) or (game.Settings.OverriddenBonuses[bonusid] ~= nil and game.Settings.OverriddenBonuses[bonusid] ~= 0))then
				for _,terrid in pairs(game.Map.Bonuses[bonusid].Territories) do
					if(terrid ~= targetterritory and game.ServerGame.LatestTurnStanding.Territories[terrid].OwnerPlayerID == order.PlayerID)then
						armiestolift = armiestolift + game.ServerGame.LatestTurnStanding.Territories[terrid].NumArmies.NumArmies;
						if(game.ServerGame.LatestTurnStanding.Territories[terrid].NumArmies.NumArmies ~= 0 and alreadymodified[terrid] == nil)then
							modify[modifyid] = WL.TerritoryModification.Create(terrid);
							modify[modifyid].SetArmiesTo = 0;
							modifyid = modifyid +1;
							alreadymodified[terrid] = true;
						end
					end
				end
			end
		end
		modify[modifyid] = WL.TerritoryModification.Create(targetterritory);
		modify[modifyid].SetArmiesTo = armiestolift;
		addNewOrder(WL.GameOrderEvent.Create(order.PlayerID, 'Airlift', {}, modify));
		addNewOrder(WL.GameOrderDiscard.Create(order.PlayerID, order.CardInstanceID));
		skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);
	end
end
