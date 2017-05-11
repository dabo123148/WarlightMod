function Server_AdvanceTurn_Start (game,addNewOrder)
	executed = false;
end
function Server_AdvanceTurn_End(game,addNewOrder)
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
							addNewOrder(WL.GameOrderEvent.Create(WL.PlayerID.Neutral, 'Neutral_Move', nil, terrMod));
						end
					end
				end
			end
		end
	end
end
