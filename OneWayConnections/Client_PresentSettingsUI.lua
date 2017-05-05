
function Client_PresentSettingsUI(rootParent)
	local RC = stringtotable(Mod.Settings.RemovedConnections);
	local num = 1;
	while(RC[num] ~= nil)do
		UI.CreateLabel(rootParent)
		.SetText('Removed Connection between ' .. RC[num] .. ' and ' .. RC[num+1]);
		num=num+2;
	end
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
function tablelength(T)
	local count = 0;
	for _ in pairs(T) do count = count + 1 end;
	return count;
end
