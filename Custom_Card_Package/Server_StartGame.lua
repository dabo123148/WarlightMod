function Server_StartGame(game,standing)
  local playerGameData = Mod.PlayerGameData;
  for playerID in pairs(game.ServerGame.Game.PlayingPlayers) do
    if(playerID>50)then
      Pieces = Mod.Settings.PestCardStartPieces%Mod.Settings.PestCardPiecesNeeded;
      Cards = (Mod.Settings.PestCardStartPieces-Pieces)/Mod.Settings.PestCardPiecesNeeded;
      playerGameData[playerID]={ PestCardPieces=Pieces, PestCards=Cards, SuccessfullyAttacked=0 };
    end
  end
  local publicGameData = Mod.PublicGameData;
  publicGameData={PestilenceStadium={}};
  
  Mod.PublicGameData=publicGameData;
  Mod.PlayerGameData = playerGameData;
end
