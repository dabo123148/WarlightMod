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
      			local offercount = 0;
			for _,player in pairs(Mod.PlayerGameData.TerritorySellOffers)do
				offercount = offercount + tablelength(player);
			end
     			Nachricht = Nachricht .. "\n" .. 'You have ' .. offercount .. ' open territory tradement offer';
    		end
		ShowHistory(Mod.PlayerGameData.NeueNachrichten,game,Nachricht);
	end
end
function tablelength(T)
	local count = 0;
	for _,elem in pairs(T)do
		count = count + 1;
	end
	return count;
end
