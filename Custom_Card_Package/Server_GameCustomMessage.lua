function Server_GameCustomMessage(game,playerID,payload,setReturn)
  if(payload.PestCardPlayer~=nil)then
    PGD=Mod.PublicGameData;
    PGD.PestilenceStadium[payload.PestCardPlayer]=1;
  end
end
