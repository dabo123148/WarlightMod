function Server_AdvanceTurn_Start (game,addNewOrder)
	--Verification that no territory got over the Stacklimit somehow (improved cross mod support)
	local Effect = {};
	local changefound = false;
	for _, terra in pairs(game.ServerGame.LatestTurnStanding.Territories)do
		if(terra.NumArmies.NumArmies > Mod.Settings.StackLimit)then
			local Effect = {};
			Effect[tablelength(Effect)+1] = WL.TerritoryModification.Create(terra.ID);
			Effect[tablelength(Effect)].SetArmiesTo = Mod.Settings.StackLimit;
			changefound = true;
		end
	end
	if(changefound)then
		addNewOrder(WL.GameOrderEvent.Create(WL.PlayerID.Neutral,"Verified All Territories and fixed Stack Limit on some",{},Effect));
	end
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	if(order.proxyType == 'GameOrderDeploy')then
		local Deploys = order.NumArmies;
		local terr = game.ServerGame.LatestTurnStanding.Territories[order.DeployOn];
		if(terr.NumArmies.NumArmies + Deploys > Mod.Settings.StackLimit)then
			skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);
			local Effect = {};
			Effect[tablelength(Effect)+1] = WL.TerritoryModification.Create(order.DeployOn);
			Effect[tablelength(Effect)].SetArmiesTo = Mod.Settings.StackLimit;
			print(order.DeployOn .. " " .. order.PlayerID .. )
			local newdeployorder = WL.GameOrderEvent.Create(order.PlayerID,"Stacklimit reduced Deployment to prevent crossing of Stacklimit",{},Effect);
			addNewOrder(newdeployorder);
		end
	end
	if(order.proxyType == 'GameOrderAttackTransfer')then
		local moveswith = order.NumArmies.NumArmies;
		local terr = game.ServerGame.LatestTurnStanding.Territories[order.To];
		if(terr.NumArmies.NumArmies + moveswith > Mod.Settings.StackLimit)then
			if(order.PlayerID == terr.OwnerPlayerID)then
				local PlaceFor = Mod.Settings.StackLimit-terr.NumArmies.NumArmies;
				skipThisOrder(WL.ModOrderControl.Skip);
				if(PlaceFor > 0)then
					addNewOrder(WL.GameOrderAttackTransfer.Create(order.PlayerID, order.From, order.To, order.AttackTransfer , order.ByPercent , WL.Armies.Create(PlaceFor,order.NumArmies.SpecialUnits), order.AttackTeammates));
				end
			else
				if(moveswith > Mod.Settings.StackLimit)then
					skipThisOrder(WL.ModOrderControl.Skip);
					addNewOrder(WL.GameOrderAttackTransfer.Create(order.PlayerID, order.From, order.To, order.AttackTransfer , order.ByPercent , WL.Armies.Create(Mod.Settings.StackLimit,order.NumArmies.SpecialUnits), order.AttackTeammates));
				end
			end
		end
	end
	if(order.proxyType == 'GameOrderPlayCardAirlift')then
		local moveswith = order.Armies.NumArmies;
		local terr = game.ServerGame.LatestTurnStanding.Territories[order.ToTerritoryID];
		if(terr.NumArmies.NumArmies + moveswith > Mod.Settings.StackLimit)then
			local PlaceFor = Mod.Settings.StackLimit-terr.NumArmies.NumArmies;
			skipThisOrder(WL.ModOrderControl.Skip);
			if(PlaceFor > 0)then
				addNewOrder(WL.GameOrderPlayCardAirlift.Create(order.CardInstanceID, order.PlayerID, order.FromTerritoryID , order.ToTerritoryID, WL.Armies.Create(PlaceFor ,order.Armies.SpecialUnits)));
			end
		end
	end
end
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
