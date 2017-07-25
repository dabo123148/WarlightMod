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
   Mod.PlayerGameData = playerGameData;
end
