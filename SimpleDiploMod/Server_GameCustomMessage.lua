function getplayerIDs(game)
	local rgvalue = {};
	for _,playerinfo in pairs(game.ServerGame.Game.Players)do
		if(playerinfo.ID > 50)then
			rgvalue[tablelength(rgvalue)+1] = playerinfo.ID;
		end
	end
	return rgvalue;
end
function Server_GameCustomMessage(game, playerID, payload, setReturnTable)
	AllPlayerIDs = getplayerIDs(game);
	local rg = {};
	if(payload.Message == "Read")then
		local playerGameData = Mod.PlayerGameData;
		playerGameData[playerID].NeueNachrichten = nil;
		Mod.PlayerGameData = playerGameData;
	end
 	if(payload.Message == "Peace")then
		local target = payload.TargetPlayerID;
		local preis = payload.Preis;
		local dauer = payload.duration;
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
			--playerGameData[playerID].NeueNachrichten = playerGameData[pID].NeueNachrichten ..  playerID .. ",1," .. duration .. "," .. target .. ",";
			--playerGameData[target].Nachrichten = playerGameData[pID].Nachrichten ..  playerID .. ",1,".. duration .. "," .. target .. ",";
			for _,pID in pairs(AllPlayerIDs)do
				if(pID ~= playerID or pID ~= target)then
					if(playerGameData[pID].NeueNachrichten == nil)then
						playerGameData[pID].NeueNachrichten = ",";
					end
					if(playerGameData[pID].Nachrichten == nil)then
						playerGameData[pID].Nachrichten = ",";
					end
					playerGameData[pID].NeueNachrichten = playerGameData[pID].NeueNachrichten ..  playerID .. ",1," .. dauer .. "," .. target .. ",";
					playerGameData[pID].Nachrichten = playerGameData[pID].Nachrichten ..  playerID .. ",1," .. dauer .. "," .. target .. ",";
				else
					playerGameData[pID].Nachrichten = playerGameData[pID].Nachrichten ..  playerID .. ",1," .. dauer .. ",".. target .. ",";
					--View out of other playerIDs
				end
			end
			if(match == false)then
				playerGameData[target].Peaceoffers = existingpeaceoffers .. playerID .. "," .. preis .. "," .. dauer .. ",";
				Mod.PlayerGameData=playerGameData;
				rg.Message ='The Offer has been submitted';
				setReturnTable(rg);
			else
				rg.Message ='The player has already a pending peace offer by you.';
				setReturnTable(rg);
			end
		else
			local publicGameData = Mod.PublicGameData;
			local remainingwar = ",";
			local withtable = stringtotable(Mod.PublicGameData.War[an]);
			for _,with in pairs(withtable) do
				if(tonumber(with)~=playerID)then
					remainingwar = remainingwar .. with .. ",";
				end
			end
			publicGameData.War[an] = remainingwar;
			remainingwar = ",";
			local withtable = stringtotable(Mod.PublicGameData.War[playerID]);
			for _,with in pairs(withtable) do
				if(tonumber(with)~=an)then
					remainingwar = remainingwar .. with .. ",";
				end
			end
			publicGameData.War[playerID] = remainingwar;
			Mod.PublicGameData = publicGameData;
			local privateGameData = Mod.PrivateGameData;
			num = game.Game.NumberOfTurns;
			while(num < game.Game.NumberOfTurns+dauer)do
				if(privateGameData.Cantdeclare[num] == nil)then
					privateGameData.Cantdeclare[num] = ",";
				end
				privateGameData.Cantdeclare[num] = privateGameData.Cantdeclare[num] .. an .. "," .. playerID .. ",";
				num = num +1;
			end
			Mod.PrivateGameData = privateGameData;
			local playerGameData = Mod.PlayerGameData;
			for _,pID in pairs(AllPlayerIDs)do
				if(pID == playerID or pID == target)then
					if(playerGameData[pID].NeueNachrichten == nil)then
						playerGameData[pID].NeueNachrichten = ",";
					end
					if(playerGameData[pID].Nachrichten == nil)then
						playerGameData[pID].Nachrichten = ",";
					end
					playerGameData[pID].NeueNachrichten = playerGameData[pID].NeueNachrichten ..  playerID .. ",2," .. tostring(game.Game.NumberOfTurns+dauer) .. "," .. target .. ",";
					playerGameData[pID].Nachrichten = playerGameData[pID].Nachrichten ..  playerID .. ",2,".. tostring(game.Game.NumberOfTurns+dauer) .. "," .. target .. ",";
				else
					playerGameData[pID].Nachrichten = playerGameData[pID].Nachrichten ..  playerID .. ",2,".. tostring(game.Game.NumberOfTurns+dauer) .. "," .. target .. ",";
				end
			end
			Mod.PlayerGameData=playerGameData;
			rg.Message = 'The AI accepted your offer';
			setReturnTable(rg);
			--accept peace cause ai
		end
	else
		rg.Message = 'Bug';
		setReturnTable(rg);
  	end
	if(payload.Message == "Accept Peace" or payload.Message == "Decline Peace")then
		local playerGameData = Mod.PlayerGameData;
		local an = payload.TargetPlayerID;
		local preis = 0;
		local dauer = 0;
		offers = stringtotable(playerGameData[playerID].Peaceoffers);
		local num = 1;
		local remainingoffers = ",";
		while(offers[num]~=nil and offers[num+1]~=nil and offers[num+2]~=nil and offers[num+2]~="")do
			if(tonumber(offers[num])==tonumber(an))then
				preis = tonumber(offers[num+1]);
				dauer = tonumber(offers[num+2]);
			else
				remainingoffers = remainingoffers .. offers[num] .. "," .. offers[num+1] .. "," .. offers[num+2] .. ",";
			end
			num = num + 3;
		end
		if(remainingoffers == ",")then
			playerGameData[playerID].Peaceoffers = nil;
		else
			playerGameData[playerID].Peaceoffers = remainingoffers;
		end
		offers = stringtotable(playerGameData[an].Peaceoffers);
		remainingoffers = ",";
		num = 1;
		while(offers[num]~=nil and offers[num+1]~=nil and offers[num+2]~=nil and offers[num+2]~="")do
			if(tonumber(offers[num])~=tonumber(playerID))then
				remainingoffers = remainingoffers .. offers[num] .. "," .. offers[num+1] .. "," .. offers[num+2] .. ",";
			end
			num = num + 3;
		end
		if(remainingoffers == ",")then
			playerGameData[an].Peaceoffers = nil;
		else
			playerGameData[an].Peaceoffers = remainingoffers;
		end
		if(payload.Message == "Accept Peace")then
			playerGameData[an].Money = Mod.PlayerGameData[an].Money + preis;
			playerGameData[playerID].Money = Mod.PlayerGameData[playerID].Money - preis;
			for _,pID in pairs(AllPlayerIDs)do
				if(pID == playerID or pID == target)then
					if(playerGameData[pID].NeueNachrichten == nil)then
						playerGameData[pID].NeueNachrichten = ",";
					end
					if(playerGameData[pID].Nachrichten == nil)then
						playerGameData[pID].Nachrichten = ",";
					end
					playerGameData[pID].NeueNachrichten = playerGameData[pID].NeueNachrichten ..  playerID .. ",2," ..tostring(game.Game.NumberOfTurns+dauer).. "," .. an .. ",";
					playerGameData[pID].Nachrichten = playerGameData[pID].Nachrichten ..  playerID .. ",2,"..tostring(game.Game.NumberOfTurns+dauer).. "," .. an .. ",";
				else
					playerGameData[pID].Nachrichten = playerGameData[pID].Nachrichten ..  playerID .. ",2,".. tostring(game.Game.NumberOfTurns+dauer).. "," .. an .. ",";
				end
			end
			Mod.PlayerGameData=playerGameData;
			local publicGameData = Mod.PublicGameData;
			local remainingwar = ",";
			local withtable = stringtotable(Mod.PublicGameData.War[an]);
			for _,with in pairs(withtable) do
				if(tonumber(with)~=playerID)then
					remainingwar = remainingwar .. with .. ",";
				end
			end
			publicGameData.War[an] = remainingwar;
			remainingwar = ",";
			local withtable = stringtotable(Mod.PublicGameData.War[playerID]);
			for _,with in pairs(withtable) do
				if(tonumber(with)~=an)then
					remainingwar = remainingwar .. with .. ",";
				end
			end
			publicGameData.War[playerID] = remainingwar;
			Mod.PublicGameData = publicGameData;
			local privateGameData = Mod.PrivateGameData;
			num = game.Game.NumberOfTurns;
			while(num < game.Game.NumberOfTurns+dauer)do
				if(privateGameData.Cantdeclare==nil)then
					privateGameData.Cantdeclare = {};
				end
				if(privateGameData.Cantdeclare[num] == nil)then
					privateGameData.Cantdeclare[num] = ",";
				end
				privateGameData.Cantdeclare[num] = privateGameData.Cantdeclare[num] .. an .. "," .. playerID .. ",";
				num = num +1;
			end
			Mod.PrivateGameData = privateGameData;
		else
			for _,pID in pairs(AllPlayerIDs)do
				if(pID == playerID or pID == target)then
					if(playerGameData[pID].NeueNachrichten == nil)then
						playerGameData[pID].NeueNachrichten = ",";
					end
					if(playerGameData[pID].Nachrichten == nil)then
						playerGameData[pID].Nachrichten = ",";
					end
					playerGameData[pID].NeueNachrichten = playerGameData[pID].NeueNachrichten ..  playerID .. ",3," .. "," .. an .. ",";
					playerGameData[pID].Nachrichten = playerGameData[pID].Nachrichten ..  playerID .. ",3,".. "," .. an .. ",";
				else
					playerGameData[pID].Nachrichten = playerGameData[pID].Nachrichten ..  playerID .. ",3,".. "," .. an .. ",";
					--View out of other playerIDs
				end
			end
			Mod.PlayerGameData=playerGameData;
		end
	end
	if(payload.Message == "Territory Sell")then
		local target = tonumber(payload.TargetPlayerID);--target == 0 = everyone
		local Preis = payload.Preis;
		local targetterr = tonumber(payload.TargetTerritoryID);
		local playerGameData = Mod.PlayerGameData;
		if(target == 0)then
			--option everyone
			local addedoffers = 0;
			local alreadyoffered = -1;
			for _,pid in pairs(game.ServerGame.Game.Players)do
				if(pid.IsAI == false and pid.ID ~= playerID)then
					local existingterroffers = ",";
					if(playerGameData[pid.ID].Terrselloffers~=nil)then
						existingterroffers=playerGameData[pid.ID].Terrselloffers;
					end
					if(HasTerritoryOffer(existingterroffers,playerID,targetterr)==false)then
						existingterroffers = existingterroffers .. tostring(playerID) .. ',' .. tostring(targetterr) .. ',' .. Preis .. ',';
						playerGameData[pid.ID].Terrselloffers = existingterroffers;
						addedoffers = addedoffers + 1;
					end
				else
					alreadyoffered = alreadyoffered + 1;
				end
			end
			if(addedoffers==0)then
				rg.Message ='Everyone has already a pending territory sell offer for that territoy by you.';
				setReturnTable(rg);
			else
				if(alreadyoffered > 0)then
					rg.Message ='You successfully added ' .. tostring(addedoffers) .. ' Territory Sell Offers ' .. '\n' .. tostring(alreadyoffered) .. ' players had already a territory sell offer for that territory';
				else
					rg.Message ='You successfully added ' .. tostring(addedoffers) .. ' Territory Sell Offers';
				end
				setReturnTable(rg);
				Mod.PlayerGameData = playerGameData;
			end
		else
			local existingterroffers = ",";
			if(playerGameData[target].Terrselloffers~=nil)then
				existingterroffers=playerGameData[target].Terrselloffers;
			end
			if(HasTerritoryOffer(existingterroffers,playerID,targetterr))then
				rg.Message ='The player has already a pending territory sell offer by you for that territory.';
				setReturnTable(rg);
			else
				existingterroffers = existingterroffers .. tostring(playerID) .. ',' .. tostring(targetterr) .. ',' .. Preis .. ',';
				playerGameData[target].Terrselloffers = existingterroffers;
				Mod.PlayerGameData = playerGameData;
				rg.Message ='The player recieved the offer.';
				setReturnTable(rg);
			end
		end
	end
	if(payload.Message == "Deny Territory Sell")then
		local removed = false;
		local von = tonumber(payload.TargetPlayerID);
		local terr = tonumber(payload.TargetTerritoryID);
		local num = 1;
		local existingterroffers = stringtotable(Mod.PlayerGameData[playerID].Terrselloffers);
		local remainingoffers = ",";
		while(existingterroffers[num+2] ~= nil)do
			if(tonumber(existingterroffers[num]) ~= von and tonumber(existingterroffers[num+1]) ~= terr)then
				remainingoffers = remainingoffers .. existingterroffers[num] .. ",".. existingterroffers[num+1] .. "," .. existingterroffers[num+2] .. ",";
			end
			num = num+3;
		end
		playerdata = Mod.PlayerGameData;
		playerdata[playerID].Terrselloffers=remainingoffers;
		if(playerdata[playerID].Nachrichten== nil)then
			playerdata[playerID].Nachrichten = ",";
		end
		if(playerdata[von].Nachrichten== nil)then
			playerdata[von].Nachrichten = ",";
		end
		playerdata[playerID].Nachrichten = playerdata[playerID].Nachrichten ..  von .. ",4,".. tostring(game.Game.NumberOfTurns) .. "," .. terr .. ",";
		playerdata[von].Nachrichten = playerdata[von].Nachrichten ..  playerID .. ",5,".. tostring(game.Game.NumberOfTurns) .. "," .. terr .. ",";
		Mod.PlayerGameData = playerdata;
	end
end
function HasTerritoryOffer(data,von,terr)
	local num = 1;
	data = stringtotable(data);
	while(data[num] ~= nil)do
		if(tonumber(data[num]) == von)then
			if(tonumber(data[num+1]) == terr)then
				return true;
			end
		end
		num = num+3;
	end
	return false;
end
function stringtotable(variable)
	local chartable = {};
	if(variable ~= nil)then
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
	else
		return {};
	end
end
function tablelength(T)
	local count = 0;
	for _,elem in pairs(T)do
		count = count + 1;
	end
	return count;
end
