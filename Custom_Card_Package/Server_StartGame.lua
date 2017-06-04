function Server_StartGame(game,standing)
  for playerID in pairs(game.ServerGame.Game.PlayingPlayers) do
    pData={ PestCardPieces=Mod.Settings.PestCardStartPieces, PestCards=0, SuccessfullyAttacked=false };
    Mod.PlayerGameData[playerID]=pData;
  end
end
