function Server_AdvanceTurn_Start (game,addNewOrder)
	local ArmiesonTerr = {};
	for _, terra in pairs(game.Map.Territories)do
		ArmiesonTerr[terra.ID] = game.ServerGame.LatestTurnStanding.Territories[terra.ID].NumArmies.NumArmies;
	end
	for _, terra in pairs(game.ServerGame.LatestTurnStanding.Territories)do
		if(terra.NumArmies.NumArmies > Mod.Settings.StackLimit)then
			local Effect = {};
			local ExtraArmies = ArmiesonTerr[terra.ID]-Mod.Settings.StackLimit;
			for _, terri in pairs(game.ServerGame.LatestTurnStanding.Territories)do
				if(terri.OwnerPlayerID == terra.OwnerPlayerID)then
					local PlaceFor = Mod.Settings.StackLimit-ArmiesonTerr[terri.ID];
					if(PlaceFor > ExtraArmies)then
						PlaceFor = ExtraArmies;
					end
					if(PlaceFor > 0)then
						local HasArmies = ArmiesonTerr[terri.ID];
						if(HasArmies + PlaceFor > Mod.Settings.StackLimit)then
							ExtraArmies = ExtraArmies - (Mod.Settings.StackLimit-HasArmies);
							HasArmies=Mod.Settings.StackLimit;
						else
							ExtraArmies = ExtraArmies - PlaceFor;
							HasArmies = HasArmies + PlaceFor;
						end
						Effect[tablelength(Effect)+1] = WL.TerritoryModification.Create(terri.ID);
						Effect[tablelength(Effect)].SetArmiesTo = HasArmies;
						ArmiesonTerr[terri.ID] = HasArmies;
					end
				end
			end
			Effect[tablelength(Effect)+1] = WL.TerritoryModification.Create(terra.ID);
			Effect[tablelength(Effect)].SetArmiesTo = Mod.Settings.StackLimit;
			ArmiesonTerr[terra.ID] = Mod.Settings.StackLimit;
			addNewOrder(WL.GameOrderEvent.Create(terra.OwnerPlayerID,"Stack Limit",{},Effect));
		end
	end
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	if(order.proxyType == 'GameOrderDeploy')then
		local Deploys = order.NumArmies;
		local terr = game.ServerGame.LatestTurnStanding.Territories[order.DeployOn];
		if(terr.NumArmies.NumArmies + Deploys > Mod.Settings.StackLimit)then
			local PlaceFor = Mod.Settings.StackLimit-terr.NumArmies.NumArmies;
			local Effect = {};
			Effect[tablelength(Effect)+1] = WL.TerritoryModification.Create(terr.ID);
			Effect[tablelength(Effect)].SetArmiesTo = Mod.Settings.StackLimit;
			local RemainingArmies = Deploys-PlaceFor;
			for _, terri in pairs(game.ServerGame.LatestTurnStanding.Territories)do
				if(terri.OwnerPlayerID == terr.OwnerPlayerID)then
					local CanTakeArmies = Mod.Settings.StackLimit-terri.NumArmies.NumArmies;
					if(CanTakeArmies > RemainingArmies)then
						CanTakeArmies = RemainingArmies;
					end
					if(CanTakeArmies > 0)then
						local HasArmies = terri.NumArmies.NumArmies;
						if(HasArmies + CanTakeArmies > Mod.Settings.StackLimit)then
							RemainingArmies = RemainingArmies - (Mod.Settings.StackLimit-HasArmies);
							HasArmies=Mod.Settings.StackLimit;
						else
							RemainingArmies = RemainingArmies - CanTakeArmies;
							HasArmies = HasArmies + CanTakeArmies;
						end
						Effect[tablelength(Effect)+1] = WL.TerritoryModification.Create(terri.ID);
						Effect[tablelength(Effect)].SetArmiesTo = HasArmies;
					end
				end
			end
			addNewOrder(WL.GameOrderEvent.Create(terr.OwnerPlayerID,"Stack Limit",{},Effect));
		end
	end
	if(order.proxyType == 'GameOrderAttackTransfer')then
		local Deploys = order.NumArmies.NumArmies;
		local terr = game.ServerGame.LatestTurnStanding.Territories[order.To];
		if(terr.NumArmies.NumArmies + Deploys > Mod.Settings.StackLimit)then
			if(order.PlayerID == terr.OwnerPlayerID)then
				local PlaceFor = Mod.Settings.StackLimit-terr.NumArmies.NumArmies;
				skipThisOrder(WL.ModOrderControl.Skip);
				if(PlaceFor > 0)then
					addNewOrder(WL.GameOrderAttackTransfer.Create(order.PlayerID, order.From, order.To, order.AttackTransfer , order.ByPercent , WL.Armies.Create(PlaceFor,order.NumArmies.SpecialUnits), order.AttackTeammates));
				end
			else
				if(Deploys > Mod.Settings.StackLimit)then
					skipThisOrder(WL.ModOrderControl.Skip);
					addNewOrder(WL.GameOrderAttackTransfer.Create(order.PlayerID, order.From, order.To, order.AttackTransfer , order.ByPercent , WL.Armies.Create(PlaceFor,order.NumArmies.SpecialUnits), order.AttackTeammates));
				end
			end
		end
	end
	if(order.proxyType == 'GameOrderPlayCardAirlift')then
		local Deploys = order.Armies.NumArmies;
		local terr = game.ServerGame.LatestTurnStanding.Territories[order.ToTerritoryID];
		if(terr.NumArmies.NumArmies + Deploys > Mod.Settings.StackLimit)then
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
