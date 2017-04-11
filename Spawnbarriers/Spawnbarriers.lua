function Spawnbarriers(game, standing)
	print('is called1');
	for _, territory in pairs(standing.Territories) do
		print('is called2');
        if (territory.OwnerPlayerID ~= WL.PlayerID.Neutral) then
			print('is called3');
        	local newArmiesCount = Mod.Settings.ConnectedArmyNumber;
			print('is called4');
           	if (newArmiesCount < 0) then newArmiesCount = 0 end;
			print('is called5');
            if (newArmiesCount > 100000) then newArmiesCount = 100000 end;
			print('is called6');
			print(territory.ID);
			print('is called7');
			print(game.Map.Territories[territory.ID]);
			print('is called8');
			for _, conn in pairs(game.Map.Territories[territory.ID].ConnectedTo.ID) do
				print('is called9');
		  		if(standing.Territories[conn].OwnerPlayerID == PlayerID.Neutral) then
					print('is called10');
					standing.Territories[conn].NumArmies = WL.Armies.Create(newArmiesCount);
					print('is called11');
		   		end
	    	end
        end
  	end
end
