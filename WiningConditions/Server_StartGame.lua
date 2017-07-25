function Server_StartGame(game,standing)
   local playerGameData = Mod.PlayerGameData;
	for _,pid in pairs(game.ServerGame.Game.PlayingPlayers)do
		if(pid.IsAI == false)then
			playerGameData[pid] = {};
			playerGameData[pid].Capturedterritories = 0;
			playerGameData[pid].Lostterritories = 0;
			playerGameData[pid].Ownedterritories = 0;
			playerGameData[pid].Capturedbonuses = 0;
			playerGameData[pid].Lostbonuses = 0;
			playerGameData[pid].Ownedbonuses = 0;
			playerGameData[pid].Killedarmies = 0;
			playerGameData[pid].Lostarmies = 0;
			playerGameData[pid].Ownedarmies = 0;
			playerGameData[pid].Eleminateais = 0;
			playerGameData[pid].Eleminateplayers = 0;
			playerGameData[pid].Eleminateaisandplayers = 0;
		end
	end
   Mod.PlayerGameData = playerGameData;
end
