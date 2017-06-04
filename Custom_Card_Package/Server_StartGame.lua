function Server_StartGame(game,standing)
  local playerGameData = Mod.PlayerGameData;
  for playerID in pairs(game.ServerGame.Game.PlayingPlayers) do
    if(playerID>50)then
      playerGameData[playerID]={ PestCardPieces=Mod.Settings.PestCardStartPieces%Mod.Settings.PestCardPiecesNeeded, PestCards=(Mod.Settings.PestCardStartPieces-(Mod.Settings.PestCardStartPieces%Mod.Settings.PestCardPiecesNeeded))/PestCardPiecesNeeded, SuccessfullyAttacked=0 };
    end
  end
  Mod.PlayerGameData = playerGameData;
end
