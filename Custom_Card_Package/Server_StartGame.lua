function Server_StartGame(game,standing)
  local playerGameData = Mod.PlayerGameData;
  for playerID in pairs(game.ServerGame.Game.PlayingPlayers) do
    if(playerID>50)then
      playerGameData[playerID]={ PestCardPieces=Mod.Settings.PestCardStartPieces, PestCards=0, SuccessfullyAttacked=0 };
    end
  end
  Mod.PlayerGameData = playerGameData;
end
