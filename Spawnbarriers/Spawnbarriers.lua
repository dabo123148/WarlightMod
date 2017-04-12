function Spawnbarriers(game, standing)
	for _, territory in pairs(standing.Territories) do
        if (territory.OwnerPlayerID ~= WL.PlayerID.Neutral) then
        	local newArmiesCount = Mod.Settings.ConnectedArmyNumber;
           	if (newArmiesCount < 0) then newArmiesCount = 0 end;
            if (newArmiesCount > 100000) then newArmiesCount = 100000 end;
			print(game.Map.Territories[territory.ID]);
			for _, conn in pairs(game.Map.Territories[territory.ID].ConnectedTo) do
		  		if(standing.Territories[conn.ID].OwnerPlayerID == WL.PlayerID.Neutral) then
					standing.Territories[conn.ID].NumArmies = WL.Armies.Create(newArmiesCount);
		   		end
	    	end
        end
  	end
end
