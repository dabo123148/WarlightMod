function Server_StartGame(game,standing)
  for playerID in pairs(game.ServerGame.Game.PlayingPlayers) do
    Mod.PlayerGameData[playerID]={ PestCardPieces=Mod.Settings.PestCardStartPieces, PestCards=0, SuccessfullyAttacked=false };
  end
end
