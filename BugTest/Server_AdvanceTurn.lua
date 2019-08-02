function Server_AdvanceTurn_Start (game,addNewOrder)
	local publicGameData = Mod.PublicGameData;
	--Contains every War
	publicGameData.War = {};
	publicGameData.War[517210] = "Test ";
	Mod.PublicGameData = publicGameData;
end
