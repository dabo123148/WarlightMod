function Server_AdvanceTurn_Start (game,addNewOrder)
	AlreadyDeployed = {};
	for _,terr in pairs(game.Map.Territories)do
		AlreadyDeployed[terr.ID] = 0;
	end
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	if(order.proxyType == 'GameOrderDeploy') then
		local Deploys = order.NumArmies;
		local on = order.DeployOn;
		if(AlreadyDeployed[on] + Deploys > Mod.Settings.MaxDeploy)then
			Deploys = Mod.Settings.MaxDeploy-AlreadyDeployed[on];
			skipThisOrder(WL.ModOrderControl.Skip);
			if(Deploys > 0)then
				addNewOrder(WL.GameOrderDeploy.Create(order.PlayerID,Deploys,on));
				print('Deploys ' .. Deploys .. ' on ' .. game.Map.Territories[on].Name .. AlreadyDeployed[on] .. ' armies deployed');
				AlreadyDeployed[on] = AlreadyDeployed[on]+Deploys;
				local terri = game.ServerGame.LatestTurnStanding.Territories[on];
				local remainingarmies = order.NumArmies-Deploys;
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
										AlreadyDeployed[terra.ID] = AlreadyDeployed[terra.ID]+PlaceFor;
										addNewOrder(WL.GameOrderDeploy.Create(terri.OwnerPlayerID,PlaceFor,terra.ID));
										remainingarmies = remainingarmies - PlaceFor;
										print('ReDeploys ' .. PlaceFor .. ' on ' .. game.Map.Territories[terra.ID].Name .. ' before there were ' .. AlreadyDeployed[terra.ID] .. ' armies deployed');
									end
								end
							end
						end
					end
				end
			else
				print('Ignoring Deploys zero order ' .. Deploys .. ' on ' .. game.Map.Territories[on].Name .. ' before there were ' .. AlreadyDeployed[on] .. ' armies deployed');
			end
		else
			print('Successfully ' .. Deploys .. ' on ' .. game.Map.Territories[on].Name .. ' before there were ' .. AlreadyDeployed[on] .. ' armies deployed');
			AlreadyDeployed[on] = AlreadyDeployed[on] + Deploys;
		end
	end
end
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
