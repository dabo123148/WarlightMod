require('History');
function Client_GameRefresh(game)
	local Nachricht = "";
    	if(tablelength(Mod.PlayerGameData.Peaceoffers)>0)then
    		Nachricht = Nachricht .. "\n" .. 'You have ' .. tablelength(Mod.PlayerGameData.Peaceoffers) .. ' open peace requests';
   	end
    	if(tablelength(Mod.PlayerGameData.AllyOffers)>0)then
      		Nachricht = Nachricht .. "\n" .. 'You have ' .. tablelength(Mod.PlayerGameData.Allyoffers) .. ' open ally requests';
    	end
    	if(tablelength(Mod.PlayerGameData.Terrselloffers)>0)then
      		Nachricht = Nachricht .. "\n" .. 'You have ' .. tablelength(Mod.PlayerGameData.TerritorySellOffers) .. ' open territory tradement requests';
    	end
	ShowHistory(Mod.PlayerGameData.NeueNachrichten,game,Nachricht);
end
