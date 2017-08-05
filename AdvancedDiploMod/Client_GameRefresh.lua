require('History');
function Client_GameRefresh(game)
	if(game.Us == nil)then
		return;
	end
	local Nachricht = "";
    	if(Mod.PlayerGameData.Peaceoffers ~= nil and tablelength(Mod.PlayerGameData.Peaceoffers)>0)then
    		Nachricht = Nachricht .. "\n" .. 'You have ' .. tablelength(Mod.PlayerGameData.Peaceoffers) .. ' open peace offer';
   	end
    	if(Mod.PlayerGameData.AllyOffers ~= nil and tablelength(Mod.PlayerGameData.AllyOffers)>0)then
      		Nachricht = Nachricht .. "\n" .. 'You have ' .. tablelength(Mod.PlayerGameData.AllyOffers) .. ' open ally offer';
    	end
    	if(Mod.PlayerGameData.TerritorySellOffers ~= nil and tablelength(Mod.PlayerGameData.TerritorySellOffers)>0)then
      		Nachricht = Nachricht .. "\n" .. 'You have ' .. tablelength(Mod.PlayerGameData.TerritorySellOffers) .. ' open territory tradement offer';
    	end
	ShowHistory(Mod.PlayerGameData.NeueNachrichten,game,Nachricht);
end
