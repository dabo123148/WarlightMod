function Server_StartGame(game,standing)
   local playerGameData = Mod.PlayerGameData;
   for _,terr in pairs(standing.Territories)do
     playerGameData[terr.OwnerPlayerID] ={ Money=Mod.Settings.StartMoney};
   end
   Mod.PlayerGameData = playerGameData;
end
