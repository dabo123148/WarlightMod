function Server_AdvanceTurn_Start (game,addNewOrder)
	local publicGameData = Mod.PublicGameData;
	--Contains every War
	publicGameData.War = {};
	for _,pid in pairs(game.ServerGame.Game.Players) do
		--Sets, that every player has no war going on
		publicGameData.War[517210] = "Test " .. pid.ID;
	end
	--Saves data
	Mod.PublicGameData = publicGameData;
end
