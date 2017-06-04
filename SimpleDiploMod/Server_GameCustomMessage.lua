function Server_GameCustomMessage(game, playerID, payload, setReturnTable)
	print('Custom Message');
 	if(payload.Message == "Peace")then
		local target = payload.TargetPlayerID;
		local preis = payload.Preis;
    		print('Friedensangebot');
		local privateGameData = Mod.PrivateGameData;
		if(privateGameData.Peaceoffers == nil)then
			privateGameData.Peaceoffers = {};
			privateGameData.Peaceoffers[target] = ",";
		else
 			if(privateGameData.Peaceoffers[target]==nil)then
				privateGameData.Peaceoffers[target]=",";
			end
		end
		privateGameData.Peaceoffers = privateGameData.Peaceoffers .. "," .. target .. "," .. preis .. ",";
		print(privateGameData.Peaceoffers);
		Mod.PrivateGameData=privateGameData;
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
