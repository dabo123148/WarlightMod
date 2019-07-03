function Server_AdvanceTurn_Start (game,addNewOrder)
	executed = false;
	if(tablelength(game.ServerGame.LatestTurnStanding.Territories) > 500)then
		executed = true;
	end
	terrmodnum = 1;
	terrMod = {}
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
							currentarmies[terr.ID] = Remainingarmies;
							currentarmies[conn.ID] = currentarmies[conn.ID] + Takenarmies;
						end
					end
				end
			end
		end
		for _, terr in pairs(game.ServerGame.LatestTurnStanding.Territories) do
			terrMod[terrmodnum] = WL.TerritoryModification.Create(terr.ID);
			terrMod[terrmodnum].SetArmiesTo = currentarmies[terr.ID];
			terrmodnum = terrmodnum +1;
		end
		addNewOrder(WL.GameOrderEvent.Create(WL.PlayerID.Neutral, 'Neutral_Move', {}, terrMod));
	end
end
function tablelength(arr)
	local num = 0;
	for _,elem in pairs(arr)do
		num = num + 1;
	end
	return num;
end
