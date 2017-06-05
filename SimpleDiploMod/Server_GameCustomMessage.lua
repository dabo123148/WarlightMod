function Server_GameCustomMessage(game, playerID, payload, setReturnTable)
	print('Custom Message');
 	if(payload.Message == "Peace")then
		local target = payload.TargetPlayerID;
		local preis = payload.Preis;
    		print('Friedensangebot');
		if(target> 50)then
			local playerGameData = Mod.PlayerGameData;
			local existingpeaceoffers = ",";
 			if(playerGameData[target].Peaceoffers~=nil)then
				existingpeaceoffers=playerGameData[target].Peaceoffers;
			end
			--there can be double peace offers
			--peaceoffers if not in war/allied still possible
			playerGameData[target] = {Peaceoffers=existingpeaceoffers .. math.random(0,10000) .. "," .. preis .. ",",Money=Mod.PlayerGameData[target].Money};
			print(playerGameData[target].Peaceoffers);
			Mod.PlayerGameData=playerGameData;
			local rg = {};
			rg.Message =playerGameData[target].Peaceoffers ..'Test';
			setReturnTable(rg);
		else
			local rg = {};
			rg.Message = 'Frieden an ai Test';
			setReturnTable(rg);
			--accept peace cause ai
		end
	else
		local rg = {};
		rg.Message = 'Fehler';
		setReturnTable(rg);
  	end
	if(payload.Message == "Accept Peace")then
		local playerGameData = Mod.PlayerGameData;
		local an = payload.TargetPlayerID;
		local preis = 0;
		offers = stringtotable(playerGameData[playerID].Peaceoffers);
		local num = 1;
		local remainingoffers = ",";
		while(offers[num]~=niland offers[num+1]~=nil)do
			if(tonumber(offers[num])==an)then
				preis = tonumber(offers[num+1]);
			else
				remainingoffers = remainingoffers .. offers[num] .. "," .. ofefers[num+1] .. ",";
			end
			num = num + 2;
		end
		playerGameData[playerID].Peaceoffers = remainingoffers;
		offers = stringtotable(playerGameData[an].Peaceoffers);
		while(offers[num]~=niland offers[num+1]~=nil)do
			if(tonumber(offers[num])==playerID)then
				preis = tonumber(offers[num+1]);
			else
				remainingoffers = remainingoffers .. offers[num] .. "," .. ofefers[num+1] .. ",";
			end
			num = num + 2;
		end
		playerGameData[an].SetMoney = Mod.PlayerGameData[an] + preis;
		playerGameData[playerID].SetMoney = Mod.PlayerGameData[playerID] - preis;
		Mod.PlayerGameData=playerGameData;
		local publicGameData = Mod.PublicGameData;
		local remainingwar = ",";
		for _,with in pairs(publicGameData.War[an]) do
			if(tonumber(with)~=playerID)then
				remainingwar = remainingwar .. with .. ",";
			end
		end
		publicGameData.War[an] = remainingwar;
		remainingwar = ",";
		for _,with in pairs(publicGameData.War[playerID]) do
			if(tonumber(with)~=an)then
				remainingwar = remainingwar .. with .. ",";
			end
		end
		publicGameData.War[playerID] = remainingwar;
		Mod.PublicGameData = publicGameData;
		local privateGameData = Mod.PrivateGameData;
		if(privateGameData.Cantdeclare == nil)then
			privateGameData.Cantdeclare = ",";
		end
		privateGameData.Cantdeclare = privateGameData.Cantdeclare .. an .. "," .. playerID .. ",";
		Mod.PrivateGameData = privateGameData;
	end
	if(payload.Message == "Request Data")then
		
	end
end
function stringtochararray(variable)
	chartable = {};
	while(string.len(variable)>0)do
		chartable[tablelength(chartable)] = string.sub(variable, 1 , 1);
		variable = string.sub(variable, 2);
	end
	return chartable;
end
function check(message,variable)
	local match = true;
	local mess = stringtochararray(message);
	local varchararray = stringtochararray(variable);
	local num = 0;
	while(varchararray[num] ~= nil)do
		if(mess[num] ~= varchararray[num])then
			print(mess[num] .. ' ' .. varchararray[num]);
			return false;
		end
		num = num + 1;
	end
	return match;
end
