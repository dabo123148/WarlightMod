require('DistributeWinningTerritories')
function Server_StartGame(game,standing)
   	local playerGameData = Mod.PlayerGameData;
	for _,pid in pairs(game.ServerGame.Game.Players)do
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
		if(terr.OwnerPlayerID ~= WL.PlayerID.Neutral)then
			if(game.ServerGame.Game.PlayingPlayers[terr.OwnerPlayerID].IsAI == false)then
				playerGameData[terr.OwnerPlayerID].Ownedterritories = playerGameData[terr.OwnerPlayerID].Ownedterritories+1;
				playerGameData[terr.OwnerPlayerID].Ownedarmies = playerGameData[terr.OwnerPlayerID].Ownedarmies+terr.NumArmies.NumArmies;
			end
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
			if(pid ~= WL.PlayerID.Neutral and game.ServerGame.Game.PlayingPlayers[pid].IsAI == false)then
				playerGameData[pid].Ownedbonuses = playerGameData[pid].Ownedbonuses+1;
			end
		end
		pid = nil;
	end
   	Mod.PlayerGameData = playerGameData;
	DistributeItems(game,standing);
end
