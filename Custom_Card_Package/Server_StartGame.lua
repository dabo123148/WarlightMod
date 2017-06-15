function Server_StartGame(game,standing)
  local playerGameData = Mod.PlayerGameData;
  for playerID in pairs(game.ServerGame.Game.PlayingPlayers) do
    if(playerID>50)then
      PestPieces = Mod.Settings.PestCardStartPieces%Mod.Settings.PestCardPiecesNeeded;
      PestCards = (Mod.Settings.PestCardStartPieces-PestPieces)/Mod.Settings.PestCardPiecesNeeded;
      NukePieces = Mod.Settings.NukeCardStartPieces%Mod.Settings.NukeCardPiecesNeeded;
      NukeCards = (Mod.Settings.NukeCardStartPieces-NukePieces)/Mod.Settings.NukeCardPiecesNeeded;
      playerGameData[playerID]={};
      playerGameData[playerID].PestCardPieces=PestPieces;
      playerGameData[playerID].PestCards=PestCards;
      playerGameData[playerID].NukeCardPieces=NukePieces;
      playerGameData[playerID].NukeCards=NukeCards;
      playerGameData[playerID].SuccessfullyAttacked=0;
    end
  end
  local publicGameData = Mod.PublicGameData;
  publicGameData={PestilenceStadium={}};
  
  Mod.PublicGameData=publicGameData;
  Mod.PlayerGameData = playerGameData;
end
