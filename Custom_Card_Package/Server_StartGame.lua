function Server_StartGame(game,standing)
  local playerGameData = Mod.PlayerGameData;
  for playerID in pairs(game.ServerGame.Game.PlayingPlayers) do
    playerGameData[playerID]={ PestCardPieces=Mod.Settings.PestCardStartPieces, PestCards=0, SuccessfullyAttacked=false };
  end
  Mod.PlayerGameData = playerGameData;
end
