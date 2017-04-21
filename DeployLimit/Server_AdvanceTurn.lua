function Server_AdvanceTurn_Start (game,addNewOrder)
	AlreadyDeployed = {};
	for _,terr in pairs(game.Map.Territories)do
		AlreadyDeployed[terr.ID] = 0;
	end
	redeployarmies = {};
	executed = false;
	SkippedOrders = {};
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	print('Test1');
	if(executed == false)then
		if(order.proxyType == 'GameOrderDeploy') then
			local Deploys = order.NumArmies;
			local on = order.DeployOn;
			print('Test2');
			if(AlreadyDeployed[on] + Deploys > Mod.Settings.MaxDeploy)then
				print('Test3');
				Deploys = Mod.Settings.MaxDeploy-AlreadyDeployed[on];
				if(Deploys > 0)then
					addNewOrder(order.PlayerID,Deploys,on);
					redeployarmies[order.PlayerID] = redeployarmies[order.PlayerID] + (order.NumArmies-Deploys);--This armies must be deployed on other Territories
					skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);
				end
			else
				AlreadyDeployed[on] = Deploys;
			end
		else
			print('Test4');
			SkippedOrders[tablelength(SkippedOrders)] = order;
			skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);
		end
	end
end
function Server_AdvanceTurn_End (game,addNewOrder)
	print('Test5');
	if(executed == false)then
		executed = true;
		for _, terri in pairs(game.ServerGame.LatestTurnStanding)do
			local remainingarmies = redeployarmies[terri.OwnerPlayerID];
			if(remainingarmies ~= nil)then
				if(remainingarmies > 0)then
					for _, terra in pairs(game.ServerGame.LatestTurnStanding)do
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
			redeployarmies[terri.OwnerPlayerID] = 0;
		end
		for _,order in pairs(SkippedOrders)do
			addNewOrder(order);
		end
	end
end
