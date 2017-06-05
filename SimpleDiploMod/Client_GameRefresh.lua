function Client_GameRefresh(game)
  if(Mod.PlayerGameData.Peaceoffers~=nil)then
    if(tablelength(stringtotable(Mod.PlayerGameData.Peaceoffers))>0)then
    	UI.Alert('You have ' .. tablelength(stringtotable(Mod.PlayerGameData.Peaceoffers))/2-0.5 .. ' open peace requests');
	--UI.Alert(Mod.PlayerGameData.Peaceoffers);
    end
  end
  if(Mod.PlayerGameData.Allyoffers~=nil)then
    if(tablelength(stringtotable(Mod.PlayerGameData.Allyoffers))>0)then
      UI.Alert('You have ' .. tablelength(stringtotable(Mod.PlayerGameData.Allyoffers)) .. ' open ally requests');
    end
  end
  if(Mod.PlayerGameData.PendingTradements~=nil)then
    if(tablelength(PendingTradements)>0)then
      UI.Alert('You have ' .. tablelength(PendingTradements) .. ' open tradement requests');
    end
  end
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
