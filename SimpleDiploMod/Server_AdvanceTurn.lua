function Server_AdvanceTurn_Start (game,addNewOrder)
	AllAIs = {};
	for _,terr in pairs(game.ServerGame.LatestTurnStanding.Territories)do
		local CheckingID = terr.OwnerPlayerID;
		if(CheckingID ~= WL.PlayerID.Neutral)then
			if(game.Game.Players[CheckingID].IsAI)then
				local Match = false;
				for _,knownAIs in pairs(AllAIs)do
					if(CheckingID == knownAIs)then
						Match = true;
					end
				end
				if(Match == false)then
					AllAIs[tablelength(AllAIs)] = CheckingID;
				end
			end
		end
	end
	AllPlayerIDs = {};
	for _,terr in pairs(game.ServerGame.LatestTurnStanding.Territories)do
		local Match = false;
		local CheckingID = terr.OwnerPlayerID;
		if(CheckingID ~= WL.PlayerID.Neutral)then
			for _,knownPlayers in pairs(AllPlayerIDs)do
				if(CheckingID == knownPlayers)then
					Match = true;
				end
			end
			if(Match == false)then
				AllPlayerIDs[tablelength(AllPlayerIDs)] = CheckingID;
			end
		end
	end
	Attacksbetween = {};
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	if(order.proxyType == "GameOrderAttackTransfer")then
		if(result.IsAttack and game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID ~= WL.PlayerID.Neutral)then
			if(InWar(order.PlayerID,game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID) == true)then
			else
				skipThisOrder(WL.ModOrderControl.Skip);
				--War declaration
				if(Mod.Settings.AllowAIDeclaration == false or Mod.Settings.AIsdeclearAIs  == false)then
					local Match1 = false;
					local Match2 = false;
					for _, AI in pairs(AllAIs)do
						if(order.PlayerID == AI)then
							Match1 = true;
						end
						if(game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID == AI)then
							Match2 = true;
						end
					end
					if(Match1 == false)then
						DeclearWar(order.PlayerID,game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID);
					else
						if(Mod.Settings.AllowAIDeclaration and Match2 == false)then
							DeclearWar(order.PlayerID,game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID);
						else
							if(Mod.Settings.AIsdeclearAIs and Match2 == true)then
								DeclearWar(order.PlayerID,game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID);
							end
						end
					end
				else
					DeclearWar(order.PlayerID,game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID);
				end
			end
		end
	end
	if(order.proxyType == "GameOrderCustom")then
		if(check(order.Message,"Declared war on"))then
			if(InWar(order.PlayerID,order.Payload) == false)then
				DeclearWar(order.PlayerID,tonumber(order.Payload));
			end
		end
		if(check(order.Message,"Removed ally with"))then
			
		end
		skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);
	end
end
function Server_AdvanceTurn_End (game,addNewOrder)
	--add new Allys
	--add new war decleartions
	if(RemainingDeclerations ~= nil)then
		for _,newwar in pairs(RemainingDeclerations)do
			local P1 = tonumber(stringtotable(newwar)[1]);
			local P2 = tonumber(stringtotable(newwar)[2]);
			local publicGameData = Mod.PublicGameData;
			if(Mod.PublicGameData.War[P1] ~= nil)then
				local with = Mod.PublicGameData.War[P1] .. tostring(P2) .. ",";
				publicGameData.War[P1] = with;
				--addNewOrder(WL.GameOrderEvent.Create(P1, "Test1", nil,{}));
			else
				publicGameData.War[P1] = "," .. tostring(P2) .. ",";
				--addNewOrder(WL.GameOrderEvent.Create(P1, "Test2", nil,{}));
			end
			addNewOrder(WL.GameOrderEvent.Create(P1, "Declared war on " .. toname(P2,game), nil,{}));
			local P3 = P2;
			P2 = P1;
			P1 = P3;
			if(Mod.PublicGameData.War[P1] ~= nil)then
				local with = Mod.PublicGameData.War[P1] .. tostring(P2) .. ",";
				publicGameData.War[P1] = with;
				--addNewOrder(WL.GameOrderEvent.Create(P1, "Test3", nil,{}));
			else
				publicGameData.War[P1] = "," .. tostring(P2) .. ",";
				--addNewOrder(WL.GameOrderEvent.Create(P1, "Test4", nil,{}));
			end
			Mod.PublicGameData = publicGameData;
		end
	end
	RemainingDeclerations = {};
	local privateGameData = Mod.PrivateGameData;
	privateGameData.Cantdeclare = nil;
	Mod.PublicGameData = privateGameData;
	--if(Mod.Settings.SeeAllyTerritories)then
		--play on every ally a reconnaisance card
		--for _, player in pairs(AllPlayerIDs)do
			--for _, terr in pairs(game.ServerGame.LatestTurnStanding.Territories)do
				--if(IsAlly(player,terr.OwnerPlayerID))then
					--addNewOrder(WL.GameOrderPlayCardReconnaissance.Create(WL.NoParameterCardInstance.Create(100, WL.CardID.Reconnaissance), player, terr));
				--end
			--end
		--end
	--end
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
function toname(playerid,game)
	local test = "";
	for _,playerinfo in pairs(game.ServerGame.Game.Players)do
		if(playerid == playerinfo.ID)then
			--return tostring(playerid) .. " " .. tostring(playerinfo.ID);
			--local name = playerinfo.DisplayName(nil, false);
			local name = playerinfo.Color.Name;
			if(name == nil or name == "")then
				return "fehler";
			else
				return name;
			end
		end
	end
	return "Error. Please report to dabo1.";
end
function RemoveAlly(Player1,Player2)
	
end
function RemoveWar(Player1,Player2)
	
end
function DeclearWar(Player1,Player2)
	print('Declear War');
	--Allys declear war on order.PlayerID if not allied with order.PlayerID
	if(IsAlly(Player1,Player2)==false and InWar(Player1,Player2) == false)then
		print('D1');
		if(RemainingDeclerations == nil)then
			RemainingDeclerations = {};
		end
		local Match = false;
		for _,newwar in pairs(RemainingDeclerations)do
			local P1 = tonumber(stringtotable(newwar)[1]);
			local P2 = tonumber(stringtotable(newwar)[2]);
			if(P1 == Player1 or P1 == Player2)then
				if(P2 == Player1 or P2 == Player2)then
					Match = true;
				end
			end
		end
		if(Match == false)then
			local privateGameDatasplit = stringtotable(Mod.PrivateGameData.Cantdeclare);
			local num = 1;
			if(Mod.PrivateGameData.Cantdeclare~=nil)then
				while(privateGameDatasplit[num] ~= nil and privateGameDatasplit[num+1] ~= nil and privateGameDatasplit[num+1] ~= "")do
					if(tonumber(privateGameDatasplit[num]) == Player1 or tonumber(privateGameDatasplit[num+1]) == Player1)then
						if(tonumber(privateGameDatasplit[num]) == Player2 or tonumber(privateGameDatasplit[num+1]) == Player2)then
							--Match = true;
							error(tonumber(privateGameDatasplit[num]) .." " .. tonumber(privateGameDatasplit[num+1]).. " " .. Player1 .. " " .. Player2);
						end
					end
					num = num + 2;
				end
			end
			if(Match == false)then
				RemainingDeclerations[tablelength(RemainingDeclerations)] = "," .. Player1 .. "," ..Player2;
			end
		end
	else
		RemoveAlly(Player1,Player2);
	end
end
function InWar(Player1,Player2)
	if(Mod.PublicGameData.War == nil)then
		print('neu gesetzt');
		local publicGameData = Mod.PublicGameData;
 		publicGameData.War={};
		Mod.PublicGameData=publicGameData;
	end
	if(Mod.PublicGameData.War[Player1] ~= nil)then
		local with = stringtotable(Mod.PublicGameData.War[Player1]);
		for _,pID in pairs(with)do
			print(pID .. " " .. Player2);
			if(tostring(pID) == tostring(Player2))then
				print("sind im krieg");
				return true;
			end
		end
	end
	return false;
end
function DeclearAlly(Player1,Player2)
	
end
function IsAlly(Player1,Player2)
	return false;
end
function tablelength(T)
	local count = 0;
	for _,elem in pairs(T)do
		count = count + 1;
	end
	return count;
end
function stringtochararray(variable)
	chartable = {};
	while(string.len(variable)>0)do
		chartable[tablelength(chartable)] = string.sub(variable, 1 , 1);
		variable = string.sub(variable, 2);
	end
	return chartable;
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
