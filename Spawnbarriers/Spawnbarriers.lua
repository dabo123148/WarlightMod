function Spawnbarriers(game, standing)
	for _, territory in pairs(standing.Territories) do
        if (territory.OwnerPlayerID ~= WL.PlayerID.Neutral) then
        	local newArmiesCount = Mod.Settings.ConnectedArmyNumber;
			if(newArmiesCount == nil)then
				newArmiesCount = 5;
			end
           	if (newArmiesCount < 0) then
				newArmiesCount = 0; 
			end
            if (newArmiesCount > 100000) then
				newArmiesCount = 100000;
			end
			local radi = Mod.Settings.Radius;
			if(radi == nil)then
				radi = 1;
			end
			if(radi < 1 )then
				radi = 1;
			end
			if(radi > 3) then
				radi = 3;
			end
			Rekursion(game,standing, territory,radi,newArmiesCount);
        end
  	end
end
function Rekursion(game, standing, terr,r,armen)
	if(r == 0)then
		if(terr.OwnerPlayerID == WL.PlayerID.Neutral)then
			terr.NumArmies = WL.Armies.Create(armen);
		end
	else
		for _, conn in pairs(game.Map.Territories[terr.ID].ConnectedTo) do
			Rekursion(game, standing, standing.Territories[conn.ID],r-1,armen);
	    end
		if(terr.OwnerPlayerID == WL.PlayerID.Neutral)then
			terr.NumArmies = WL.Armies.Create(armen);
		end
	end
end
