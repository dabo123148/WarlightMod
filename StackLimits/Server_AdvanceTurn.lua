function Server_AdvanceTurn_Start (game,addNewOrder)
	SkippedOrders = {};
	executed = false;
	AddedOrders = {};
	executed2 = false;
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	if(executed == false)then
		if(order.proxyType ~= 'GameOrderDeploy')then
			if(order.proxyType ~= 'GameOrderPlayCardAirlift')then
				print(terr.dasdasd);
				executed = true;
				ArmiesonTerr = {};
				for _, terr in pairs(game.ServerGame.LatestTurnStanding.Territories)do
					ArmiesonTerr[terr.ID] = terr.NumArmies.NumArmies;
				end
				for _, terr in pairs(game.ServerGame.LatestTurnStanding.Territories)do
					if(ArmiesonTerr[terr.ID] > Mod.Settings.StackLimit)then
						local Effect = {};
						local ExtraArmies = ArmiesonTerr[terr.ID]-Mod.Settings.StackLimit;
						for _, terr2 in pairs(game.ServerGame.LatestTurnStanding.Territories)do
							if(terr2.OwnerPlayerID == terr.OwnerPlayerID)then
								local PlaceFor = Mod.Settings.StackLimit-ArmiesonTerr[terr2.ID];
								if(PlaceFor > ExtraArmies)then
									PlaceFor = ExtraArmies;
								end
								if(PlaceFor > 0)then
									print(terr.owner);
									local HasArmies = ArmiesonTerr[terr2.ID];
									if(HasArmies + PlaceFor > Mod.Settings.StackLimit)then
										ExtraArmies = ExtraArmies - (Mod.Settings.StackLimit-HasArmies);
										HasArmies=Mod.Settings.StackLimit;
									else
										ExtraArmies = ExtraArmies - PlaceFor;
										HasArmies = HasArmies + PlaceFor;
									end
									Effect[tablelength(Effect)+1] = WL.TerritoryModification.Create(terr2.ID);
									Effect[tablelength(Effect)].SetArmiesTo = HasArmies;
									ArmiesonTerr[terr2.ID] = HasArmies;
								end
							end
						end
						Effect[tablelength(Effect)+1] = WL.TerritoryModification.Create(terr.ID);
						Effect[tablelength(Effect)].SetArmiesTo = Mod.Settings.StackLimit;
						ArmiesonTerr[terr.ID] = Mod.Settings.StackLimit;
						AddedOrders[tablelength(AddedOrders)] = WL.GameOrderEvent.Create(terr.OwnerPlayerID,"Stack Limit",nil,Effect);
						SkippedOrders[tablelength(SkippedOrders)+1] = order;
						skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);
					end
				end
			end
		end
	else
		print(terr.asdsadasd);
		if(executed2 == false)then
			SkippedOrders[tablelength(SkippedOrders)+1] = order;
			skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);
		end
	end
end
function Server_AdvanceTurn_End(game,addNewOrder)
	if(executed2 == false)then
		executed2 = true;
		for _, order in pairs(AddedOrders)do
			addNewOrder(order);
		end
		for _, order in pairs(SkippedOrders)do
			addNewOrder(order);
		end
	end
end
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
