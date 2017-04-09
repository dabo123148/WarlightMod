

function Spawnbarriers(game, standing)
	local territoryId = 0;
	for _, territory in pairs(standing.Territories) do
        	if (territory.OwnerPlayerID ~= PlayerID.Neutral) then
        		local newArmiesCount = Mod.Settings.ConnectedArmyNumber;
           		if (newArmiesCount < 0) then newArmiesCount = 0 end;
            		if (newArmiesCount > 100000) then newArmiesCount = 100000 end;
			for placeholder, conn in pairs(game.Map.Territories[territoryId].ConnectedTo) do
				print(territoryId);
		  		if(conn.OwnerPlayerID == PlayerID.Neutral) then
					conn.NumArmies = Armies(newArmiesCount);
		   		end
	    		end
        	end
		territoryId = territoryId + 1;
  	end
end
