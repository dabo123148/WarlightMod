
function Server_AdvanceTurn_End(game,addNewOrder)
	local ArmiesonTerr = {};
	for _, terr in pairs(game.ServerGame.LatestTurnStanding.Territories)do
		ArmiesonTerr[terr.ID] = terr.NumArmies.NumArmies;
	end
   	for _, terr in pairs(game.ServerGame.LatestTurnStanding.Territories)do
		if(ArmiesonTerr[terr.ID] > Mod.Settings.StackLimit)then
			local Effect = {};
			local ExtraArmies = Mod.Settings.StackLimit-ArmiesonTerr[terr.ID];
			print(ExtraArmies');
			for _, terr2 in pairs(game.ServerGame.LatestTurnStanding.Territories)do
				if(terr2.OwnerPlayerID == terr.OwnerPlayerID)then
					print('Test2');
					local PlaceFor = Mod.Settings.StackLimit-ArmiesonTerr[terr2.ID];
					if(PlaceFor > ExtraArmies)then
						PlaceFor = ExtraArmies;
					end
					if(PlaceFor > 0)then
						print('Test3');
						local HasArmies = Mod.Settings.StackLimit;
						if(HasArmies + PlaceFor > Mod.Settings.StackLimit)then
							ExtraArmies = ExtraArmies - (Mod.Settings.StackLimit-HasArmies);
							HasArmies=Mod.Settings.StackLimit;
						else
							ExtraArmies = ExtraArmies - PlaceFor;
							HasArmies = HasArmies - PlaceFor;
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
			addNewOrder(WL.GameOrderEvent.Create(terr.OwnerPlayerID,"Stack Limit",nil,Effect));
		end
	end
end
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
