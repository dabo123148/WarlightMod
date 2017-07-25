function Server_StartGame(game,standing)
   	local playerGameData = Mod.PlayerGameData;
	for _,pid in pairs(game.ServerGame.Game.PlayingPlayers)do
		if(pid.IsAI == false)then
			playerGameData[pid.ID] = {};
			playerGameData[pid.ID].Capturedterritories = 0;
			playerGameData[pid.ID].Lostterritories = 0;
			playerGameData[pid.ID].Ownedterritories = 0;
			playerGameData[pid.ID].Capturedbonuses = 0;
			playerGameData[pid.ID].Lostbonuses = 0;
			playerGameData[pid.ID].Ownedbonuses = 0;
			playerGameData[pid.ID].Killedarmies = 0;
			playerGameData[pid.ID].Lostarmies = 0;
			playerGameData[pid.ID].Ownedarmies = 0;
			playerGameData[pid.ID].Eleminateais = 0;
			playerGameData[pid.ID].Eleminateplayers = 0;
			playerGameData[pid.ID].Eleminateaisandplayers = 0;
		end
	end
	for _,terr in pairs(standing.Territories)do
		if(game.ServerGame.Game.PlayingPlayers[terr.OwnerPlayerID].IsAI == false)then
			playerGameData[pid.ID].Ownedterritories = playerGameData[pid.ID].Ownedterritories+1;
			playerGameData[pid.ID].Ownedarmies = playerGameData[pid.ID].Ownedarmies+terr.NumArmies.NumArmies;
		end
	end
	for _,boni in pairs(game.Map.Bonuses)do
		local Match = true;
		for _,terrid in pairs(boni.Territories)do
			if(pid == nil)then
				pid = standing.Territories[terrid].OwnerPlayerID;
			end
			if(pid ~= standing.Territories[terrid].OwnerPlayerID)then
				Match = false;
			end
		end
		if(Match == true)then
			playerGameData[pid].Ownedbonuses = playerGameData[pid].Ownedbonuses+1;
		end
		pid = nil;
	end
   	Mod.PlayerGameData = playerGameData;
end
