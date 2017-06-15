function Server_StartGame(game,standing)
  local playerGameData = Mod.PlayerGameData;
  for playerID in pairs(game.ServerGame.Game.PlayingPlayers) do
      if(playerID>50)then
        playerGameData[playerID]={};
        if(Mod.Settings.PestCardIn)then
          PestPieces = Mod.Settings.PestCardStartPieces%Mod.Settings.PestCardPiecesNeeded;
          PestCards = (Mod.Settings.PestCardStartPieces-PestPieces)/Mod.Settings.PestCardPiecesNeeded;
          playerGameData[playerID].PestCardPieces=PestPieces;
          playerGameData[playerID].PestCards=PestCards;
        end
       if(Mod.Settings.NukeCardIn)then
          NukePieces = Mod.Settings.NukeCardStartPieces%Mod.Settings.NukeCardPiecesNeeded;
          NukeCards = (Mod.Settings.NukeCardStartPieces-NukePieces)/Mod.Settings.NukeCardPiecesNeeded;
          playerGameData[playerID].NukeCardPieces=NukePieces;
          playerGameData[playerID].NukeCards=NukeCards;
       end
      playerGameData[playerID].SuccessfullyAttacked=0;
    end
  end
  local publicGameData = Mod.PublicGameData;
  publicGameData={PestilenceStadium={}};
  
  Mod.PublicGameData=publicGameData;
  Mod.PlayerGameData = playerGameData;
end
