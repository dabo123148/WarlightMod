require('History');
function Client_GameRefresh(game)
	if(game.Us == nil)then
		return;
	end
	--It appears that gamerefresh gets called before startgame, so this filters out a crash
	if(Mod.PlayerGameData.Peaceoffers == nil)then
		return;
	end
	if(Mod.PublicGameData.War[game.Us.ID] ==nil)then
		UI.Alert("I identified a problem with the data structure of this mod. This could be based on the device you are running(it is a normal bug for some devices that run the standalone client). Try using a different device. If the bug consists, please contact the author of this mod(go to mod info and click the github link).");
		return;
	end
	if(lastnachricht == nil)then
		lastnachricht = "";
	end
	local Nachricht = "";
    	if(tablelength(Mod.PlayerGameData.Peaceoffers)>0)then
    		Nachricht = Nachricht .. "\n" .. 'You have ' .. tablelength(Mod.PlayerGameData.Peaceoffers) .. ' open peace offer';
   	end
   	if(tablelength(Mod.PlayerGameData.AllyOffers)>0)then
     		Nachricht = Nachricht .. "\n" .. 'You have ' .. tablelength(Mod.PlayerGameData.AllyOffers) .. ' open ally offer';
  	end
	ShowAllHistory(game,Nachricht);
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
