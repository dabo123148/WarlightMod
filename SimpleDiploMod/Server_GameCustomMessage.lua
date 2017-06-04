function Server_GameCustomMessage(game, playerID, payload, setReturnTable)
	print('Custom Message');
 	if(check(payload,"Peace"))then
    		print('Friedensangebot');
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
