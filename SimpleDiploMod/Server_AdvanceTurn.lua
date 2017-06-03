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
				--Set attacks between
				if(Attacksbetween[order.PlayerID] ~= nil)then
					bereitsgemachteangriffe = Attacksbetween[order.PlayerID];
					if(bereitsgemachteangriffe == nil)then
						bereitsgemachteangriffe={};
					end
					bereitsgemachteangriffe[game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID] = true;
					Attacksbetween[order.PlayerID] = bereitsgemachteangriffe;
				else
					Attacksbetween[order.PlayerID] = {};
					Attacksbetween[order.PlayerID][game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID] = true;
				end
				if(Attacksbetween[game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID] ~= nil)then
					bereitsgemachteangriffe = Attacksbetween[game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID];
					if(bereitsgemachteangriffe == nil)then
						bereitsgemachteangriffe={};
					end
					bereitsgemachteangriffe[order.PlayerID] = true;
					Attacksbetween[game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID] = bereitsgemachteangriffe;
				else
					Attacksbetween[game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID] = {};
					Attacksbetween[game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID][order.PlayerID] = true;
				end
			else
				skipThisOrder(WL.ModOrderControl.Skip);
				--War declaration
				if(Mod.Settings.AllowAIDeclaration == false)then
					local Match = false;
					for _, AI in pairs(AllAIs)do
						if(order.PlayerID == AI)then
							Match = true;
						end
					end
					if(Match == false)then
						DeclearWar(order.PlayerID,game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID);
						--Allys declear war on order.From if not allied with order.From
					end
				else
					DeclearWar(order.PlayerID,game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID);
					--Allys declear war on order.From if not allied with order.From
				end
			end
		end
	end
	if(order.proxyType == "GameOrderCustom")then
		if(check(order.Message,"Declared war on"))then
			local with = toint(order.Message);
			if(InWar(order.PlayerID,order.SanctionedPlayerID) == false)then
				local ordersplit = stringtochararray(order.Message);
				local with = "";
				local num = 16;
				while(num < tablelength(ordersplit))do
					with = with + splitelem[num];
					num = num + 1;
				end
				print('with ' .. with);
				DeclearWar(order.PlayerID,tonumber(with));
			end
		end
		if(check(order.Message,"Offer peace to"))then
			
		end
		if(check(order.Message,"Offer ally to"))then
			
		end
		if(check(order.Message,"Removed ally with"))then
			
		end
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
				local newinwar = {};
				for _, alreadyinwar in pairs(War[P1])do
					newinwar[alreadyinwar] = true;
				end
				publicGameData.War[P1] = newinwar;
			else
				publicGameData.War[P1] = {};
			end
			publicGameData.War[P1][P2] = true;
			--addNewOrder(WL.GameOrderEvent.Create(WL.PlayerID.Neutral, "The Player with the player ID " .. tostring(P1) .. " decleared war on " .. tostring(P2), nil,{}));
			--addNewOrder(WL.GameOrderCustom.Create(P1, "Declars war on " .. tostring(P2), ""));
			local P3 = P2;
			P2 = P1;
			P1 = P3;
			if(Mod.PublicGameData.War[P1] ~= nil)then
				local newinwar ={};
				for _, alreadyinwar in pairs(Mod.PublicGameData.War[P1])do
					newinwar[alreadyinwar] = true;
				end
				publicGameData.War[P1] = newinwar;
			else
				publicGameData.War[P1] = {};
			end
			publicGameData.War[P1][P2] = true;
			publicGameData.War[P1] = true;
			Mod.PublicGameData = publicGameData;
		end
	end
	RemainingDeclerations = {};
	if(RemainingAllies ~= nil)then
		for _,newwar in pairs(RemainingAllies)do
			local P1 = tonumber(stringtotable(newwar)[1]);
			local P2 = tonumber(stringtotable(newwar)[2]);
			local publicGameData = Mod.PublicGameData;
			if(Mod.PublicGameData.Ally[P1] ~= nil)then
				local newinwar = {};
				for _, alreadyinwar in pairs(Ally[P1])do
					newinwar[alreadyinwar] = true;
				end
				publicGameData.Ally[P1] = newinwar;
			else
				publicGameData.Ally[P1] = {};
			end
			publicGameData.Ally[P1][P2] = true;
			local P3 = P2;
			P2 = P1;
			P1 = P3;
			if(Mod.PublicGameData.Ally[P1] ~= nil)then
				local newinwar ={};
				for _, alreadyinwar in pairs(Mod.PublicGameData.Ally[P1])do
					newinwar[alreadyinwar] = true;
				end
				publicGameData.Ally[P1] = newinwar;
			else
				publicGameData.Ally[P1] = {};
			end
			publicGameData.Ally[P1][P2] = true;
			publicGameData.Ally[P1] = true;
			Mod.PublicGameData = publicGameData;
		end
	end
	RemainingAllies = {};
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
function RemoveAlly(Player1,Player2)
	
end
function RemoveWar(Player1,Player2)
	
end
function DeclearWar(Player1,Player2)
	print('Declear War');
	--Allys declear war on order.PlayerID if not allied with order.PlayerID
	if(IsAlly(Player1,Player2)==false)then
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
			RemainingDeclerations[tablelength(RemainingDeclerations)] = Player1 .. "," ..Player2;
		end
		print('T4');
	else
		RemoveAlly(Player1,Player2);
	end
end
function InWar(Player1,Player2)
	print(Player1);
	print(Player2);
	if(Mod.PublicGameData.War == nil)then
		print('neu gesetzt');
		local publicGameData = Mod.PublicGameData;
 		publicGameData.War={};
		Mod.PublicGameData=publicGameData;
	end
	if(Mod.PublicGameData.War[Player1] ~= nil)then
		print('Test');
		print(Mod.PublicGameData.War[Player1][Player2]);
		if(Mod.PublicGameData.War[Player1][Player2])then
			print('Test2');
			return true;
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
	local match = false;
	local mess = stringtochararray(message);
	local varchararray = stringtochararray(variable);
	local num = 0;
	while(mess[num] ~= nil)do
		if(mess[num] ~= varchararray[num])then
			match = false;
		end
		num = num + 1;
	end
	return match;
end
