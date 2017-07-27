function Server_GameCustomMessage(game, playerID, payload, setReturnTable)
	if(payload.Message == "Request Data")then
		local rg = {};
		for _,pid in pairs(game.ServerGame.Game.Players)do
			rg[pid.ID] = {};
			rg[pid.ID].Numberofbonuses = 0;
			rg[pid.ID].Numberofterritories = 0;
			rg[pid.ID].NumberofArmies = 0;
			rg[pid.ID].Income = pid.Income(0, game.ServerGame.LatestTurnStanding, false, false);
		end
		rg[WL.PlayerID.Neutral] = {};
		rg[WL.PlayerID.Neutral].Numberofterritories = 0;
		rg[WL.PlayerID.Neutral].NumberofArmies = 0;
		for _,terr in pairs(game.ServerGame.LatestTurnStanding.Territories)do
			rg[terr.OwnerPlayerID].Numberofterritories = rg[terr.OwnerPlayerID].Numberofterritories + 1;
			rg[terr.OwnerPlayerID].NumberofArmies = rg[terr.OwnerPlayerID].NumberofArmies + terr.NumArmies.NumArmies;
		end
		for _,boni in pairs(game.Map.Bonuses)do
			local works = true;
			local pid = WL.PlayerID.Neutral;
			for _,terrid in pairs(boni.Territories)do
				local terrowner = game.ServerGame.LatestTurnStanding.Territories[terrid].OwnerPlayerID;
				if(terrowner ~= WL.PlayerID.Neutral)then
					if(pid ~= WL.PlayerID.Neutral)then
						works = false;
					else
						pid = terrowner;
					end
				end
			end
			if(works and pid ~= WL.PlayerID.Neutral)then
				rg[terr.OwnerPlayerID].Numberofbonuses = rg[terr.OwnerPlayerID].Numberofbonuses + 1;
			end
		end
		setReturnTable(rg);
	end
end
