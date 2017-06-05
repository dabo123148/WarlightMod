function Server_GameCustomMessage(game,playerID,payload,setReturn)
  if(payload.PestCardPlayer~=nil)then
    PGD=Mod.PublicGameData;
    PGD.PestilenceStadium[payload.PestCardPlayer]=1;
    PlGD=Mod.PlayerGameData;
    PlGD[playerID].PestCards=Mod.PlayerGameData[playerID].PestCards-1;
    Mod.PublicGameData=PGD;
    Mod.PlayerGameData=PlGD;
  end
end
