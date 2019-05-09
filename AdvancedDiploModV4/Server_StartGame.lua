function Server_StartGame(game,standing)
	--required to store data localy to be able to do changes to data
	local playerGameData = Mod.PlayerGameData;
	local publicGameData = Mod.PublicGameData;
	--Contains every War
	publicGameData.War = {};
	--Contains all additional public history, that happened during GameCustomMessage, getting cleared in Server_AdvancedTurnStart, in order to save storage space
	publicGameData.History = {};
	publicGameData.Historyorder = {};
	for _,pid in pairs(game.ServerGame.Game.Players) do
		if(pid.IsAI == false)then
			playerGameData[pid.ID] = {};
			--Contains all peace offers for pid.ID
			playerGameData[pid.ID].Peaceoffers = {};
			--Contains all ally offers for pid.ID
			playerGameData[pid.ID].AllyOffers = {};
			--Contains all acitve alliances of pid.ID, it is stored in playerGameData, due to the feature allow everyone to see every ally
			playerGameData[pid.ID].Allianzen = {};
			--Contains all non public history, that happened during GameCustomMessage, getting cleared in Server_AdvancedTurnStart, in order to save storage space(this data is only containing declining and acceptiong of certain offers and alliances)
			playerGameData[pid.ID].PrivateHistory = {};
		end
		--Sets, that every player has no war going on
		publicGameData.War[pid.ID] = {};
	end
	--Saves data
	Mod.PlayerGameData = playerGameData;
	Mod.PublicGameData = publicGameData;
end
