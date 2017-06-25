function Client_GameRefresh(game)
	local Nachricht = "";
	if(Mod.PlayerGameData.NeueNachrichten ~= nil and Mod.PlayerGameData.NeueNachrichten ~= "")then
		local NeueNachrichtensplit = stringtotable(Mod.PlayerGameData.NeueNachrichten);
		local num = 1;
		while(NeueNachrichtensplit[num] ~= nil and NeueNachrichtensplit[num+1] ~= nil and NeueNachrichtensplit[num+2] ~= nil and NeueNachrichtensplit[num+3] ~= nil)do
			if(NeueNachrichtensplit[num+1] == "0")then
				Nachricht = Nachricht .. "\n" .. getname(NeueNachrichtensplit[num],game) .. " declared war on " .. getname(NeueNachrichtensplit[num+3],game) .. " in turn " .. NeueNachrichtensplit[num+2];
			end
			if(NeueNachrichtensplit[num+1] == "1")then
				if(tonumber(NeueNachrichtensplit[num+2]) > 1)then
					Nachricht = Nachricht .. "\n" .. getname(NeueNachrichtensplit[num],game) .. " offered " .. getname(NeueNachrichtensplit[num+3],game) .. " peace for " .. NeueNachrichtensplit[num+2] .. " turn";
				else
					Nachricht = Nachricht .. "\n" .. getname(NeueNachrichtensplit[num],game) .. " offered " .. getname(NeueNachrichtensplit[num+3],game) .. " peace for " .. NeueNachrichtensplit[num+2] .. " turns";
				end
			end
			if(NeueNachrichtensplit[num+1] == "2")then
				Nachricht = Nachricht .. "\n" .. getname(NeueNachrichtensplit[num],game) .. " accepted the peace offer by " .. getname(NeueNachrichtensplit[num+3],game) .. " until turn " .. tostring(tonumber(NeueNachrichtensplit[num+2])+1);
			end
			if(NeueNachrichtensplit[num+1] == "3")then
				Nachricht = Nachricht .. "\n" .. getname(NeueNachrichtensplit[num],game) .. " declined the peace offer of " .. getname(NeueNachrichtensplit[num+3],game);
			end
			if(NeueNachrichtensplit[num+1] == "4")then
				Nachricht = Nachricht .. "\n" .. "You declined the territory sell offer of " .. getname(NeueNachrichtensplit[num],game) .. " for " .. game.Map.Territories[tonumber(NeueNachrichtensplit[num+3])].Name .. " in turn " .. NeueNachrichtensplit[num+2];
			end
			if(NeueNachrichtensplit[num+1] == "5")then
				Nachricht = Nachricht .. "\n" .. getname(NeueNachrichtensplit[num],game) .. " declined your territory sell offer for " .. game.Map.Territories[tonumber(NeueNachrichtensplit[num+3])].Name .. " in turn " .. NeueNachrichtensplit[num+2];
			end
			if(NeueNachrichtensplit[num+1] == "6")then
				Nachricht = Nachricht .. "\n" .. "You were unable to buy " .. game.Map.Territories[tonumber(NeueNachrichtensplit[num+3])].Name .. " cause " .. getname(NeueNachrichtensplit[num],game) .. " doesn't own it when you tried to buy it in turn " .. NeueNachrichtensplit[num+2];
			end
			if(NeueNachrichtensplit[num+1] == "7")then
				Nachricht = Nachricht .. "\n" .. getname(NeueNachrichtensplit[num],game) .. " hadn't the money to pay you for " .. game.Map.Territories[tonumber(NeueNachrichtensplit[num+3])].Name .. " in turn " .. NeueNachrichtensplit[num+2];
			end
			if(NeueNachrichtensplit[num+1] == "8")then
				Nachricht = Nachricht .. "\n" .. "You hadn't the money to pay for " .. game.Map.Territories[tonumber(NeueNachrichtensplit[num+3])].Name .. " in turn " .. NeueNachrichtensplit[num+2];
			end
			if(NeueNachrichtensplit[num+1] == "9")then
				Nachricht = Nachricht .. "\n" .. getname(NeueNachrichtensplit[num],game) .. " bought " .. game.Map.Territories[tonumber(NeueNachrichtensplit[num+3])].Name .. " in turn " .. NeueNachrichtensplit[num+2];
			end
			num = num + 4;
		end
	end
  	if(Mod.PlayerGameData.Peaceoffers~=nil)then
    		if(tablelength(stringtotable(Mod.PlayerGameData.Peaceoffers))>0)then
    			Nachricht = Nachricht .. "\n" .. 'You have ' .. tablelength(stringtotable(Mod.PlayerGameData.Peaceoffers))/2-1 .. ' open peace requests';
   		end
  	end
  	if(Mod.PlayerGameData.Allyoffers~=nil)then
    		if(tablelength(stringtotable(Mod.PlayerGameData.Allyoffers))>0)then
      			Nachricht = Nachricht .. "\n" .. 'You have ' .. tablelength(stringtotable(Mod.PlayerGameData.Allyoffers)) .. ' open ally requests';
    		end
 	 end
  	if(Mod.PlayerGameData.Terrselloffers~=nil)then
    		if(tablelength(stringtotable(Mod.PlayerGameData.Terrselloffers))>0)then
      			Nachricht = Nachricht .. "\n" .. 'You have ' .. (tablelength(stringtotable(Mod.PlayerGameData.Terrselloffers))-1)/3 .. ' open territory tradement requests';
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
function getname(playerid,game)
	print(playerid);
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
