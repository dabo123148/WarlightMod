

function Spawnbarriers(game, standing)
	local territoryId = 0;
	for _, territory in pairs(standing.Territories) do
        	if (territory.OwnerPlayerID ~= PlayerID.Neutral) then
        		local newArmiesCount = Mod.Settings.ConnectedArmyNumber;
           		if (newArmiesCount < 0) then newArmiesCount = 0 end;
            		if (newArmiesCount > 100000) then newArmiesCount = 100000 end;
			for conn, _ in pairs(game.Map.Territories[territoryId].ConnectedTo) do
		  		if(conn.OwnerPlayerID == PlayerID) then
					conn.NumArmies = Armies(newArmiesCount);
		   		end
	    		end
        	end
		territoryId += 1;
  	end
end
