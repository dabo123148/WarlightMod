function Server_AdvanceTurn_Start (game,addNewOrder)
	AlreadyDeployed = {};
	for _,terr in pairs(game.Map.Territories)do
		AlreadyDeployed[terr.ID] = 0;
	end
	redeployarmies = {};
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	if(order.proxyType == 'GameOrderDeploy') then
		local Deploys = order.NumArmies;
		local on = order.DeployOn;
		if(AlreadyDeployed[on] + Deploys > Mod.Settings.MaxDeploy)then
			Deploys = Mod.Settings.MaxDeploy-AlreadyDeployed[on];
			if(Deploys > 0)then
				addNewOrder(WL.GameOrderDeploy.Create(order.PlayerID,Deploys,on));
				AlreadyDeployed[on] = AlreadyDeployed[on]+Deploys;
				if(redeployarmies[order.PlayerID] == nil)then
					redeployarmies[order.PlayerID] = 0;
				end
				redeployarmies[order.PlayerID] = redeployarmies[order.PlayerID] + (order.NumArmies-Deploys);--This armies must be deployed on other Territories
				skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);
				local terri = game.ServerGame.LatestTurnStanding.Territories[on];
				local remainingarmies = redeployarmies[terri.OwnerPlayerID];
				if(remainingarmies ~= nil)then
					if(remainingarmies > 0)then
						for _, terra in pairs(game.ServerGame.LatestTurnStanding.Territories)do
							if(terri.OwnerPlayerID == terra.OwnerPlayerID)then
								if(AlreadyDeployed[terra.ID] < Mod.Settings.MaxDeploy)then
									local PlaceFor = Mod.Settings.MaxDeploy-AlreadyDeployed[terra.ID];
									if(PlaceFor>remainingarmies)then
										PlaceFor = remainingarmies;
									end
									if(PlaceFor > 0)then
										addNewOrder(WL.GameOrderDeploy.Create(terri.OwnerPlayerID,PlaceFor,terra.ID));
										remainingarmies = remainingarmies - PlaceFor;
									end
								end
							end
						end
					end
				end
			end
		else
			AlreadyDeployed[on] = Deploys;
		end
	end
end
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
