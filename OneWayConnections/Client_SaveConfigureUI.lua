
function Client_SaveConfigureUI(alert)
    Mod.Settings.TotalRemovedConnections = InputStartArmies.GetValue();
	Mod.Settings.RemovedConnections = "";
	local num = 1;
	local setnum = 1;
	while(num < InputStartArmies.GetValue()*2) do
		if(RemovedConnectionsFields[num] ~= nil)then
			if(RemovedConnectionsFields[num].GetText() ~= "" and RemovedConnectionsFields[num+1].GetText() ~= "")then
				local Vorhanden = false;
				local chartable = {};
				local ausgang = RemovedConnectionsFields[num].GetText();
				while(string.len(ausgang)>0)do
					chartable[tablelength(chartable)] = string.sub(ausgang, 1 , 1);
					ausgang = string.sub(ausgang, 2);
				end
				for _, elem in pairs(chartable)do
					if(elem == ',')then
						Vorhanden=true;
					end
				end
				chartable = {};
				ausgang = RemovedConnectionsFields[num+1].GetText();
				while(string.len(ausgang)>0)do
					chartable[tablelength(chartable)] = string.sub(ausgang, 1 , 1);
					ausgang = string.sub(ausgang, 2);
				end
				for _, elem in pairs(chartable)do
					if(elem == ',')then
						Vorhanden=true;
					end
				end
				if(Vorhanden == false)then
					Mod.Settings.RemovedConnections = Mod.Settings.RemovedConnections .. ',' ..RemovedConnectionsFields[num].GetText() .. ',';
					Mod.Settings.RemovedConnections = Mod.Settings.RemovedConnections .. RemovedConnectionsFields[num+1].GetText();
					setnum = setnum +2;
				end
			end
		end
		num = num+2;
	end
end
function stringtotable(variable)
	local chartable = {};
	while(string.len(variable)>0)do
		chartable[tablelength(chartable)] = string.sub(variable, 1 , 1);
		variable = string.sub(variable, 2);
	end
	local newtable = {};
	local tablepos = 0;
	for _, elem in pairs(chartable)do
		if(elem == ',')then
			tablepos = tablepos + 1;
			newtable[tablepos] = "";
		else
			newtable[tablepos] = newtable[tablepos] .. elem;
		end
	end
	return newtable;
end
function tablelength(T)
	local count = 0;
	for _ in pairs(T) do count = count + 1 end;
	return count;
end
