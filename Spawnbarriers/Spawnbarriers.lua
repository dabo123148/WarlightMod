

function Spawnbarriers(game, standing)
	for _, territory in pairs(standing.Territories) do
        if (territory.OwnerPlayerID ~= PlayerID.Neutral) then
        local newArmiesCount = Mod.Settings.ConnectedArmyNumber;
            if (newArmiesCount < 0) then newArmiesCount = 0 end;
            if (newArmiesCount > 100000) then newArmiesCount = 100000 end;
		for conn, _ in pairs(game.Map.Territories[territory.territoryID].ConnectedTo) do
		   if(conn.OwnerPlayerID == PlayerID) then
			conn.NumArmies = Armies(newArmiesCount);
		   end
	     end
        end
    end
end
