function Server_GameCustomMessage(game, playerID, payload, setReturnTable)
	publicGameData = Mod.PublicGameData;
	publicGameData.Testvar = publicGameData.Testvar+1;
	Mod.PublicGameData = publicGameData;
	local rg = {};
	rg.Message = "Resonse of custom message.";
	setReturnTable(rg);
end