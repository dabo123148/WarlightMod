function Spawnbarriers(game, standing)
	print('is called1');
	for _, territory in pairs(standing.Territories) do
		print('is called2');
        if (territory.OwnerPlayerID ~= PlayerID.Neutral) then
			print('is called3');
        	local newArmiesCount = Mod.Settings.ConnectedArmyNumber;
			print('is called4');
           	if (newArmiesCount < 0) then newArmiesCount = 0 end;
			print('is called5');
            if (newArmiesCount > 100000) then newArmiesCount = 100000 end;
			print('is called6');
			for placeholder, conn in pairs(game.Map.Territories[territory.ID].ConnectedTo.ID) do
				print('is called7');
		  		if(standing.Territories[conn].OwnerPlayerID == PlayerID.Neutral) then
					standing.Territories[conn].NumArmies = Armies(newArmiesCount);
		   		end
	    	end
        end
  	end
end
