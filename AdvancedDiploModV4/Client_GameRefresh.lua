require('History');
function Client_GameRefresh(game)
	if(game.Us == nil)then
		return;
	end
	if(lastnachricht == nil)then
		lastnachricht = "";
	end
	if(showedreturnmessage == nil or showedreturnmessage == true)then
		local Nachricht = "";
    		if(tablelength(Mod.PlayerGameData.Peaceoffers)>0)then
    			Nachricht = Nachricht .. "\n" .. 'You have ' .. tablelength(Mod.PlayerGameData.Peaceoffers) .. ' open peace offer';
   		end
   		if(tablelength(Mod.PlayerGameData.AllyOffers)>0)then
     			Nachricht = Nachricht .. "\n" .. 'You have ' .. tablelength(Mod.PlayerGameData.AllyOffers) .. ' open ally offer';
  		end
		ShowAllHistory(game,Nachricht);
	else
		showedreturnmessage = true;
	end
end
function tablelength(T)
	if(T==nil)then
		return "error";
	end
	local count = 0;
	for _,elem in pairs(T)do
		count = count + 1;
	end
	return count;
end
