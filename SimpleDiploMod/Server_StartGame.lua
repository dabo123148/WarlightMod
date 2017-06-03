function Server_StartGame(game,standing)
   local playerGameData = Mod.PlayerGameData;
   for _,terr in pairs(standing.Territories)do
      print('Test1');
      if(terr.OwnerPlayerID > 50)then
         print('Test2');
         playerGameData[terr.OwnerPlayerID] ={ Money=Mod.Settings.StartMoney};
      end
   end
   Mod.PlayerGameData = playerGameData;
end
