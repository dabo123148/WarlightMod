function Server_GameCustomMessage(game, playerID, payload, setReturnTable)
	print('Custom Message');
 	if(payload.Message == "Peace")then
		local target = payload.TargetPlayerID;
		local preis = payload.Preis;
    		print('Friedensangebot');
		if(getplayerid(target,game) > 50)then
			local playerGameData = Mod.PlayerGameData;
 			if(playerGameData[getplayerid(target,game)]==nil)then
				playerGameData[getplayerid(target,game)] = { Peaceoffers=","};
			end
			--there can be double peace offers
			--peaceoffers if not in war/allied still possible
			playerGameData[getplayerid(target,game)].Peaceoffers = playerGameData[getplayerid(target,game)].Peaceoffers .. playerID .. "," .. preis .. ",";
			print(playerGameData[getplayerid(target,game)].Peaceoffers);
			Mod.PlayerGameData=playerGameData;
			local rg = {};
			rg.Message =playerGameData[getplayerid(target,game)].Peaceoffers ..'Test';
			setReturnTable(rg);
		else
			local rg = {};
			rg.Message = 'Frieden an ai Test'.. getplayerid(target,game);
			setReturnTable(rg);
			--accept peace cause ai
		end
	else
		local rg = {};
		rg.Message = 'Fehler';
		setReturnTable(rg);
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
function getplayerid(playername,game)
	for _,playerinfo in pairs(game.ServerGame.Game.Players)do
		local name = playerinfo.DisplayName(nil, false);
		if(name == playername)then
			return playerinfo.ID;
		end
	end
	return 0;
end
