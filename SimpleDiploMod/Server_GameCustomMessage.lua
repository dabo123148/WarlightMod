function Server_GameCustomMessage(game, playerID, payload, setReturnTable)
	print('Custom Message');
 	if(payload.Message == "Peace")then
		local target = payload.TargetPlayerID;
		local preis = payload.Preis;
		if(target> 50)then
			local playerGameData = Mod.PlayerGameData;
			local existingpeaceoffers = ",";
 			if(playerGameData[target].Peaceoffers~=nil)then
				existingpeaceoffers=playerGameData[target].Peaceoffers;
			end
			local existingofferssplit = stringtotable(existingpeaceoffers);
			local num = 1;
			local match = false;
			while(existingofferssplit[num] ~=nil)do
				if(tonumber(existingofferssplit[num]) == playerID)then
					match = true;
				end
				num=num+2;
			end
			local rg = {};
			if(match == false)then
				playerGameData[target] = {Peaceoffers=existingpeaceoffers .. playerID .. "," .. preis .. ",",Money=Mod.PlayerGameData[target].Money};
				print(playerGameData[target].Peaceoffers);
				Mod.PlayerGameData=playerGameData;
				rg.Message ='The Offer has been submitted';
				setReturnTable(rg);
			else
				rg.Message ='The player has already a pending peace offer by you.';
				setReturnTable(rg);
			end
		else
			local rg = {};
			rg.Message = 'Peace to AI';
			setReturnTable(rg);
			--accept peace cause ai
		end
	else
		local rg = {};
		rg.Message = 'Fehler';
		setReturnTable(rg);
  	end
	if(payload.Message == "Accept Peace")then
		--local playerGameData = Mod.PlayerGameData;
		--local an = payload.TargetPlayerID;
		--local preis = 0;
		--offers = stringtotable(playerGameData[playerID].Peaceoffers);
		--local num = 1;
		--local remainingoffers = ",";
		--while(offers[num]~=nil and offers[num+1]~=nil)do
		--	if(tonumber(offers[num])==an)then
		--		preis = tonumber(offers[num+1]);
		--	else
		--		remainingoffers = remainingoffers .. offers[num] .. "," .. ofefers[num+1] .. ",";
		--	end
		--	num = num + 2;
		--end
		--playerGameData[playerID].Peaceoffers = remainingoffers;
		--offers = stringtotable(playerGameData[an].Peaceoffers);
		--while(offers[num]~=nil and offers[num+1]~=nil)do
		--	if(tonumber(offers[num])==playerID)then
		--		preis = tonumber(offers[num+1]);
		--	else
		--		remainingoffers = remainingoffers .. offers[num] .. "," .. ofefers[num+1] .. ",";
		--	end
		--	num = num + 2;
		--end
		--playerGameData[an].SetMoney = Mod.PlayerGameData[an] + preis;
		--playerGameData[playerID].SetMoney = Mod.PlayerGameData[playerID] - preis;
		--Mod.PlayerGameData=playerGameData;
		--local publicGameData = Mod.PublicGameData;
		--local remainingwar = ",";
		--for _,with in pairs(publicGameData.War[an]) do
		--	if(tonumber(with)~=playerID)then
		--		remainingwar = remainingwar .. with .. ",";
		--	end
		--end
		--publicGameData.War[an] = remainingwar;
		--remainingwar = ",";
		--for _,with in pairs(publicGameData.War[playerID]) do
		--	if(tonumber(with)~=an)then
		--		remainingwar = remainingwar .. with .. ",";
		--	end
		--end
		--publicGameData.War[playerID] = remainingwar;
		--Mod.PublicGameData = publicGameData;
		--local privateGameData = Mod.PrivateGameData;
		--if(privateGameData.Cantdeclare == nil)then
		--	privateGameData.Cantdeclare = ",";
		--end
		--privateGameData.Cantdeclare = privateGameData.Cantdeclare .. an .. "," .. playerID .. ",";
		--Mod.PrivateGameData = privateGameData;
	end
	if(payload.Message == "Request Data")then
		
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
	for _,elem in pairs(T)do
		count = count + 1;
	end
	return count;
end
