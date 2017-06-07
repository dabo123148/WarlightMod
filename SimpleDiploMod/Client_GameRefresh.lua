function Client_GameRefresh(game)
	local Nachricht = "";
	if(Mod.PlayerGameData.NeueNachrichten ~= nil and Mod.PlayerGameData.NeueNachrichten ~= "")then
		local NeueNachrichtensplit = stringtotable(Mod.PlayerGameData.NeueNachrichten);
		local num = 1;
		while(NeueNachrichtensplit[num] ~= nil and NeueNachrichtensplit[num+1] ~= nil and NeueNachrichtensplit[num+2] ~= nil and NeueNachrichtensplit[num+3] ~= nil)do
			if(NeueNachrichtensplit[num+1] == "0")then
				Nachricht = Nachricht .. "\n" .. toname(NeueNachrichtensplit[num],game) .. " declared war on " .. toname(NeueNachrichtensplit[num+3],game) .. "in turn " .. NeueNachrichtensplit[num+2];
			end
			if(NeueNachrichtensplit[num+1] == "1")then
				Nachricht = Nachricht .. "\n" .. toname(NeueNachrichtensplit[num],game) .. " accepted the peace offer by " .. toname(NeueNachrichtensplit[num+3],game) .. "until turn " .. NeueNachrichtensplit[num+2];
			end
			num = num + 4;
		end
	end
  	if(Mod.PlayerGameData.Peaceoffers~=nil)then
    		if(tablelength(stringtotable(Mod.PlayerGameData.Peaceoffers))>0)then
    			Nachricht = Nachricht .. "\n" .. 'You have ' .. tablelength(stringtotable(Mod.PlayerGameData.Peaceoffers))/2-0.5 .. ' open peace requests';
   		end
  	end
  	if(Mod.PlayerGameData.Allyoffers~=nil)then
    		if(tablelength(stringtotable(Mod.PlayerGameData.Allyoffers))>0)then
      			Nachricht = Nachricht .. "\n" .. 'You have ' .. tablelength(stringtotable(Mod.PlayerGameData.Allyoffers)) .. ' open ally requests';
    		end
 	 end
  	if(Mod.PlayerGameData.PendingTradements~=nil)then
    		if(tablelength(PendingTradements)>0)then
      			Nachricht = Nachricht .. "\n" .. 'You have ' .. tablelength(PendingTradements) .. ' open tradement requests';
    		end
  	end
	if(Nachricht ~= "")then
		UI.Alert(Nachricht);
	end
	if(Mod.PlayerGameData.NeueNachrichten ~= nil and Mod.PlayerGameData.NeueNachrichten ~= "")then
		local payload = {};
		payload.Message = "Read";
		game.SendGameCustomMessage("Sending read confirmation...", payload, function(returnvalue)end);
	end
end
function toname(playerid,game)
	return game.Game.Players[tonumber(playerid)].DisplayName(nil, false);
end
function tablelength(T)
	local count = 0;
	for _,elem in pairs(T)do
		count = count + 1;
	end
	return count;
end
function stringtotable(variable)
	chartable = {};
	while(string.len(variable)>0)do
		chartable[tablelength(chartable)] = string.sub(variable, 1 , 1);
		variable = string.sub(variable, 2);
	end
	local newtable = {};
	local tablepos = 0;
	local executed = false;
	for _, elem in pairs(chartable)do
		if(elem == ",")then
			tablepos = tablepos + 1;
			newtable[tablepos] = "";
			executed = true;
		else
			if(executed == false)then
				tablepos = tablepos + 1;
				newtable[tablepos] = "";
				executed = true;
			end
			if(newtable[tablepos] == nil)then
				newtable[tablepos] = elem;
			else
				newtable[tablepos] = newtable[tablepos] .. elem;
			end
		end
	end
	return newtable;
end
