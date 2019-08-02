function Server_StartGame(game,standing)
	local publicGameData = Mod.PublicGameData;
	--Contains every War
	publicGameData.War = {};
	publicGameData.War[517210] = "517210";
	Mod.PublicGameData = publicGameData;
end
