function Client_GameRefresh(clientGame) 
  if(Mod.PublicGameData.PestilenceStadium[clientGame.Us.ID]~=nil)then
    if(Mod.PublicGameData.PestilenceStadium[clientGame.Us.ID]==1)then
      --if(Mod.Settings.PestCardStrength==1)then
      --  UI.Alert('Somebody played a Pestilence Card on you! You will lose 1 troop on every Territory at the end of Turn '..tostring(clientGame.Game.TurnNumber+1)..'. Territories with 0 armies will be lost!');
      --else
      --  UI.Alert('Somebody played a Pestilence Card on you! You will lose '..tostring(Mod.Settings.PestCardStrength)..' troops on every Territory at the end of Turn '..tostring(clientGame.Game.TurnNumber+1)..'. Territories with 0 armies will be lost!');
      --end
    else
      if(Mod.PublicGameData.PestilenceStadium[clientGame.Us.ID]==2)then
        if(Mod.Settings.PestCardStrength==1)then
          UI.Alert('Somebody played a Pestilence Card on you! You will lose 1 troop on every Territory at the end of this turn. Territories with 0 armies will be lost!');
        else
          UI.Alert('Somebody played a Pestilence Card on you! You will lose '..tostring(Mod.Settings.PestCardStrength)..' troops on every Territory at the end of this turn. Territories with 0 armies will be lost!');
        end
      end
    end
  end
end
