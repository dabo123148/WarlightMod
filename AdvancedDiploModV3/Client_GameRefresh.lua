require('History');
function Client_GameRefresh(game)
	if(game.Us == nil)then
		return;
	end
	if(Mod.PlayerGameData.NeueNachrichten ~= nil)then
		local Nachricht = "";
    		if(tablelength(Mod.PlayerGameData.Peaceoffers)>0)then
    			Nachricht = Nachricht .. "\n" .. 'You have ' .. tablelength(Mod.PlayerGameData.Peaceoffers) .. ' open peace offer';
   		end
    		if(tablelength(Mod.PlayerGameData.AllyOffers)>0)then
      			Nachricht = Nachricht .. "\n" .. 'You have ' .. tablelength(Mod.PlayerGameData.AllyOffers) .. ' open ally offer';
    		end
    		if(tablelength(Mod.PlayerGameData.TerritorySellOffers)>0)then
      			Nachricht = Nachricht .. "\n" .. 'You have ' .. tablelength(Mod.PlayerGameData.TerritorySellOffers) .. ' open territory tradement offer';
    		end
		ShowHistory(Mod.PlayerGameData.NeueNachrichten,game,Nachricht);
	end
end
