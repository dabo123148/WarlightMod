function Server_StartGame(game,standing)
	local publicGameData = Mod.PublicGameData;
	--Contains every War
	publicGameData.War = {};
	for _,pid in pairs(game.ServerGame.Game.Players) do
		--Sets, that every player has no war going on
		publicGameData.War[pid.ID] = {};
	end
	--Saves data
	Mod.PublicGameData = publicGameData;
end
