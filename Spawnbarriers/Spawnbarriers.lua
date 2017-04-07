

function RandomizeWastelands(game, standing)
	for _, territory in pairs(standing.Territories) do
        if (territory.OwnerPlayerID != PlayerID.Neutral) then
            local newArmiesCount = Mod.Settings.ConnectedArmyNumber;
            if (newArmies < 0) then newArmies = 0 end;
            if (newArmies > 100000) then newArmies = 100000 end;
			for conn, _ in pairs(game.Map.Territories[territory.territoryID].ConnectedTo) do
				if(conn.OwnerPlayerID == PlayerID) then
					conn.NumArmies = Armies(newArmiesCount);
				end
			end
        end
    end
end
