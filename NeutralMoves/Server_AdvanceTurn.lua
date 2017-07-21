function Server_AdvanceTurn_Start (game,addNewOrder)
	executed = false;
	if(tablelength(game.ServerGame.LatestTurnStanding.Territories) > 500)then
		executed = true;
	end
end
function Server_AdvanceTurn_End(game,addNewOrder)
	error("Ende");
	local currentarmies = {};
	if(executed == false) then
		executed = true;
		for _, terr in pairs(game.ServerGame.LatestTurnStanding.Territories) do
			currentarmies[terr.ID] = terr.NumArmies.NumArmies;
		end
		for _, terr in pairs(game.ServerGame.LatestTurnStanding.Territories) do
			if(terr.OwnerPlayerID == WL.PlayerID.Neutral)then
				local Remainingarmies = currentarmies[terr.ID];
				for _,conn in pairs(game.Map.Territories[terr.ID].ConnectedTo) do
					if(game.ServerGame.LatestTurnStanding.Territories[conn.ID].OwnerPlayerID == WL.PlayerID.Neutral) then
						local  Takenarmies = math.random(0,Remainingarmies);
						if(Takenarmies > 0)then
							Remainingarmies = Remainingarmies - Takenarmies;
							local terrMod = {}
							terrMod[1] = WL.TerritoryModification.Create(terr.ID);
							terrMod[1].SetArmiesTo = Remainingarmies;
							terrMod[2] = WL.TerritoryModification.Create(conn.ID);
							currentarmies[conn.ID] = currentarmies[conn.ID] + Takenarmies;
							terrMod[2].SetArmiesTo = currentarmies[conn.ID];
							currentarmies[conn.ID] = currentarmies[terr.ID]-Takenarmies;
							addNewOrder(WL.GameOrderEvent.Create(WL.PlayerID.Neutral, 'Neutral_Move', {}, terrMod));
						end
					end
				end
			end
		end
	end
end
function tablelength(arr)
	local num = 0;
	for _,elem in pairs(arr)do
		num = num + 1;
	end
	return num;
end
