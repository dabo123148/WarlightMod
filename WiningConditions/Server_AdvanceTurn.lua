function Server_AdvanceTurn_Start (game,addNewOrder)
	playerGameData = Mod.PlayerGameData;
	recalculate = {};
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	if(order.PlayerID == WL.PlayerID.Neutral)then
		return;
	end
	if(order.proxyType == "GameOrderDeploy")then
		if(game.ServerGame.Game.Players[order.PlayerID].IsAI == false)then
			playerGameData[order.PlayerID].Ownedarmies = playerGameData[order.PlayerID].Ownedarmies+order.NumArmies;
			checkwin(order.PlayerID,addNewOrder,game);
		end
	end
	if(order.proxyType == "GameOrderPlayCardBomb")then
		local targetterr = order.TargetTerritoryID;
		if(game.ServerGame.Game.Players[order.PlayerID].IsAI == false)then
			playerGameData[order.PlayerID].Killedarmies = playerGameData[order.PlayerID].Killedarmies+game.ServerGame.LatestTurnStanding.Territories[targetterr].NumArmies.NumArmies/2;
			checkwin(order.PlayerID,addNewOrder,game);
		end
		local player2 = game.ServerGame.LatestTurnStanding.Territories[targetterr].OwnerPlayerID;
		if(player2 ~= WL.PlayerID.Neutral and game.ServerGame.Game.Players[player2].IsAI == false)then
			playerGameData[player2].Lostarmies = playerGameData[player2].Lostarmies+game.ServerGame.LatestTurnStanding.Territories[targetterr].NumArmies.NumArmies/2;
			playerGameData[player2].Ownedarmies = playerGameData[player2].Ownedarmies - game.ServerGame.LatestTurnStanding.Territories[targetterr].NumArmies.NumArmies/2;;
			checkwin(order.PlayerID,addNewOrder,game);
		end
	end
	if(order.proxyType == "GameOrderPlayCardAbandon" or order.proxyType == "GameOrderPlayCardBlockade")then
		local targetterr = order.TargetTerritoryID;
		if(playerGameData[order.PlayerID].HoldTerritories == nil)then
			playerGameData[order.PlayerID].HoldTerritories = {};
		end
		if(playerGameData[order.PlayerID].HoldTerritories[targetterr] == nil)then
			playerGameData[order.PlayerID].HoldTerritories[targetterr] = nil;
		end
		if(game.ServerGame.Game.Players[order.PlayerID].IsAI == false)then
			playerGameData[order.PlayerID].Ownedarmies = playerGameData[order.PlayerID].Ownedarmies - game.ServerGame.LatestTurnStanding.Territories[targetterr].NumArmies.NumArmies;
			playerGameData[order.PlayerID].Lostarmies = playerGameData[order.PlayerID].Lostarmies+game.ServerGame.LatestTurnStanding.Territories[targetterr].NumArmies.NumArmies;
			playerGameData[order.PlayerID].Killedarmies = playerGameData[order.PlayerID].Killedarmies+game.ServerGame.LatestTurnStanding.Territories[targetterr].NumArmies.NumArmies;
			playerGameData[order.PlayerID].Lostterritories = playerGameData[order.PlayerID].Lostterritories + 1;
			playerGameData[order.PlayerID].Ownedterritories = playerGameData[order.PlayerID].Ownedterritories - 1;
			for _,boni in pairs(game.Map.Territories[targetterr].PartOfBonuses)do
				local Match = true;
				for _,terrid in pairs(game.Map.Bonuses[boni].Territories)do
					if(terrid ~= targetterr)then
						local terrowner = game.ServerGame.LatestTurnStanding.Territories[terrid].OwnerPlayerID;
						if(terrowner ~= order.PlayerID)then
							Match = false;
						end
					end
				end
				if(Match == true)then
					playerGameData[order.PlayerID].Lostbonuses = playerGameData[order.PlayerID].Lostbonuses + 1;
					playerGameData[order.PlayerID].Ownedbonuses = playerGameData[order.PlayerID].Ownedbonuses - 1;
				end
			end
			checkwin(order.PlayerID,addNewOrder,game);
		end
	end
	if(order.proxyType == "GameOrderPlayCardGift")then
		local targetterr = order.TerritoryID;
		if(playerGameData[order.PlayerID].HoldTerritories == nil)then
			playerGameData[order.PlayerID].HoldTerritories = {};
		end
		if(playerGameData[order.PlayerID].HoldTerritories[targetterr] == nil)then
			playerGameData[order.PlayerID].HoldTerritories[targetterr] = nil;
		end
		for _,boni in pairs(game.Map.Territories[targetterr].PartOfBonuses)do
			local Match = true;
			local Match2 = true;
			for _,terrid in pairs(game.Map.Bonuses[boni].Territories)do
				if(terrid ~= targetterr)then
					local terrowner = game.ServerGame.LatestTurnStanding.Territories[terrid].OwnerPlayerID;
					if(terrowner ~= toowner)then
						Match2 = false;
					end
					if(terrowner ~= order.PlayerID)then
						Match = false;
					end
				end
			end
			if(Match == true and game.ServerGame.Game.Players[order.PlayerID].IsAI == false)then
				playerGameData[order.PlayerID].Lostbonuses = playerGameData[order.PlayerID].Lostbonuses+1;
				playerGameData[order.PlayerID].Ownedbonuses = playerGameData[order.PlayerID].Ownedbonuses - 1;
			end
			if(Match2 == true and toowner ~= WL.PlayerID.Neutral and game.ServerGame.Game.Players[toowner].IsAI == false)then
				playerGameData[toowner].Lostbonuses = playerGameData[toowner].Capturedbonuses + 1;
				playerGameData[toowner].Ownedbonuses = playerGameData[toowner].Ownedbonuses + 1;
			end
		end
		if(game.ServerGame.Game.Players[order.PlayerID].IsAI == false)then
			playerGameData[order.PlayerID].Ownedarmies = playerGameData[order.PlayerID].Ownedarmies - game.ServerGame.LatestTurnStanding.Territories[targetterr].NumArmies.NumArmies;
			playerGameData[order.PlayerID].Lostarmies = playerGameData[order.PlayerID].Lostarmies+game.ServerGame.LatestTurnStanding.Territories[targetterr].NumArmies.NumArmies;
			playerGameData[order.PlayerID].Lostterritories = playerGameData[order.PlayerID].Lostterritories + 1;
			playerGameData[order.PlayerID].Ownedterritories = playerGameData[order.PlayerID].Ownedterritories - 1;
			checkwin(order.PlayerID,addNewOrder,game);
		end
		if(game.ServerGame.Game.Players[order.GiftTo].IsAI == false)then
			playerGameData[order.GiftTo].Ownedarmies = playerGameData[order.GiftTo].Ownedarmies - game.ServerGame.LatestTurnStanding.Territories[targetterr].NumArmies.NumArmies;
			playerGameData[order.GiftTo].Ownedterritories = playerGameData[order.GiftTo].Ownedterritories + 1;
			checkwin(order.GiftTo,addNewOrder,game);
		end
	end
	if(order.proxyType == "GameOrderAttackTransfer")then
		if(result.IsAttack)then
			local toowner = game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID;
			if(result.IsSuccessful)then
				for _,boni in pairs(game.Map.Territories[order.To].PartOfBonuses)do
					local Match = true;
					local Match2 = true;
					for _,terrid in pairs(game.Map.Bonuses[boni].Territories)do
						if(terrid ~= order.To)then
							local terrowner = game.ServerGame.LatestTurnStanding.Territories[terrid].OwnerPlayerID;
							if(terrowner ~= toowner)then
								Match2 = false;
							end
							if(terrowner ~= order.PlayerID)then
								Match = false;
							end
						end
					end
					if(Match == true and game.ServerGame.Game.Players[order.PlayerID].IsAI == false)then
						playerGameData[order.PlayerID].Capturedbonuses = playerGameData[order.PlayerID].Capturedbonuses+1;
						playerGameData[order.PlayerID].Ownedbonuses = playerGameData[order.PlayerID].Ownedbonuses+1;
					end
					if(Match2 == true and toowner ~= WL.PlayerID.Neutral and game.ServerGame.Game.Players[toowner].IsAI == false)then
						playerGameData[toowner].Lostbonuses = playerGameData[toowner].Lostbonuses + 1;
						playerGameData[toowner].Ownedbonuses = playerGameData[toowner].Ownedbonuses - 1;
					end
				end
			end
			if(game.ServerGame.Game.Players[order.PlayerID].IsAI == false)then
				if(result.IsSuccessful)then
					playerGameData[order.PlayerID].Capturedterritories = playerGameData[order.PlayerID].Capturedterritories+1;
					playerGameData[order.PlayerID].Ownedterritories = playerGameData[order.PlayerID].Ownedterritories+1;
					local Match = true;
					for _,terr in pairs(game.ServerGame.LatestTurnStanding.Territories) do
						if(terr.OwnerPlayerID == toowner and terr.ID ~= order.To)then
							Match = false;
						end
					end
					if(Match == true)then
						if(toowner ~= WL.PlayerID.Neutral and game.ServerGame.Game.Players[toowner].IsAI == false)then
							playerGameData[order.PlayerID].Eleminateplayers = playerGameData[order.PlayerID].Eleminateplayers+1;
						else
							playerGameData[order.PlayerID].Eleminateais = playerGameData[order.PlayerID].Eleminateais+1;
						end
						playerGameData[order.PlayerID].Eleminateaisandplayers = playerGameData[order.PlayerID].Eleminateaisandplayers+1;
					end
					if(playerGameData[order.PlayerID].HoldTerritories == nil)then
						playerGameData[order.PlayerID].HoldTerritories = {};
					end
					if(playerGameData[order.PlayerID].HoldTerritories[order.To] == nil)then
						playerGameData[order.PlayerID].HoldTerritories[order.To] = 0;
					end
				end
				playerGameData[order.PlayerID].Ownedarmies = playerGameData[order.PlayerID].Ownedarmies - result.AttackingArmiesKilled.NumArmies;
				playerGameData[order.PlayerID].Lostarmies = playerGameData[order.PlayerID].Lostarmies+result.AttackingArmiesKilled.NumArmies;
				playerGameData[order.PlayerID].Killedarmies = playerGameData[order.PlayerID].Killedarmies+result.DefendingArmiesKilled.NumArmies;
				checkwin(order.PlayerID,addNewOrder,game);
			end
			if(toowner ~= WL.PlayerID.Neutral and game.ServerGame.Game.Players[toowner].IsAI == false)then
				if(result.IsSuccessful)then
					playerGameData[toowner].Lostterritories = playerGameData[toowner].Lostterritories+1;
					playerGameData[toowner].Ownedterritories = playerGameData[toowner].Ownedterritories-1;
					if(playerGameData[toowner].HoldTerritories == nil)then
						playerGameData[toowner].HoldTerritories = {};
					end
					if(playerGameData[toowner].HoldTerritories[order.To] == nil)then
						playerGameData[toowner].HoldTerritories[order.To] = nil;
					end
				end
				playerGameData[toowner].Ownedarmies = playerGameData[toowner].Ownedarmies - result.DefendingArmiesKilled.NumArmies;
				playerGameData[toowner].Killedarmies = playerGameData[toowner].Killedarmies+result.AttackingArmiesKilled.NumArmies;
				playerGameData[toowner].Lostarmies = playerGameData[toowner].Lostarmies+result.DefendingArmiesKilled.NumArmies;
				checkwin(toowner,addNewOrder,game);
			end
		end
	end
	
end
function Server_AdvanceTurn_End (game,addNewOrder)
	for _,pid in pairs(game.ServerGame.Game.PlayingPlayers)do
		if(pid.IsAI == false)then
			if(playerGameData[pid.ID].HoldTerritories == nil)then
				playerGameData[pid.ID].HoldTerritories = {};
			end
		end
	end
	for _,terr in pairs(game.ServerGame.LatestTurnStanding.Territories)do
		if(terr.OwnerPlayerID ~= WL.PlayerID.Neutral and game.ServerGame.Game.Players[terr.OwnerPlayerID].IsAI == false)then
			if(playerGameData[terr.OwnerPlayerID].HoldTerritories[terr.ID] == nil)then
				playerGameData[terr.OwnerPlayerID].HoldTerritories[terr.ID] = 0;
			end
			playerGameData[terr.OwnerPlayerID].HoldTerritories[terr.ID] = playerGameData[terr.OwnerPlayerID].HoldTerritories[terr.ID] + 1;
			checkwin(terr.OwnerPlayerID,addNewOrder,game)
		end
	end
	Mod.PlayerGameData = playerGameData;
end
function checkwin(pid,addNewOrder,game)
	local completed = 0;
	local required = Mod.Settings.Conditionsrequiredforwin;
	if(Mod.Settings.Capturedterritories ~= 0)then
		if(playerGameData[pid].Capturedterritories >= Mod.Settings.Capturedterritories)then
			completed = completed + 1;
		end
	end
	if(Mod.Settings.Lostterritories ~= 0)then
		if(playerGameData[pid].Lostterritories >= Mod.Settings.Lostterritories)then
			completed = completed + 1;
		end
	end
	if(Mod.Settings.Ownedterritories ~= 0)then
		if(playerGameData[pid].Ownedterritories >= Mod.Settings.Ownedterritories)then
			completed = completed + 1;
		end
	end
	if(Mod.Settings.Capturedbonuses ~= 0)then
		if(playerGameData[pid].Capturedbonuses >= Mod.Settings.Capturedbonuses)then
			completed = completed + 1;
		end
	end
	if(Mod.Settings.Lostbonuses ~= 0)then
		if(playerGameData[pid].Lostbonuses >= Mod.Settings.Lostbonuses)then
			completed = completed + 1;
		end
	end
	if(Mod.Settings.Ownedbonuses ~= 0)then
		if(playerGameData[pid].Ownedbonuses >= Mod.Settings.Ownedbonuses)then
			completed = completed + 1;
		end
	end
	if(Mod.Settings.Killedarmies ~= 0)then
		if(playerGameData[pid].Killedarmies >= Mod.Settings.Killedarmies)then
			completed = completed + 1;
		end
	end
	if(Mod.Settings.Lostarmies ~= 0)then
		if(playerGameData[pid].Lostarmies >= Mod.Settings.Lostarmies)then
			completed = completed + 1;
		end
	end
	if(Mod.Settings.Ownedarmies ~= 0)then
		if(playerGameData[pid].Ownedarmies >= Mod.Settings.Ownedarmies)then
			completed = completed + 1;
		end
	end
	if(Mod.Settings.Eleminateais ~= 0)then
		if(playerGameData[pid].Eleminateais >= Mod.Settings.Eleminateais)then
			completed = completed + 1;
		end
	end
	if(Mod.Settings.Eleminateplayers ~= 0)then
		if(playerGameData[pid].Eleminateplayers >= Mod.Settings.Eleminateplayers)then
			completed = completed + 1;
		end
	end
	if(Mod.Settings.Eleminateaisandplayers ~= 0)then
		if(playerGameData[pid].Eleminateaisandplayers >= Mod.Settings.Eleminateaisandplayers)then
			completed = completed + 1;
		end
	end
	if(Mod.Settings.terrcondition ~= nil)then
		for _,condition in pairs(Mod.Settings.terrcondition)do
			if(playerGameData[pid].HoldTerritories ~= nil)then
				local terrid = getterrid(game,condition.Terrname);
				if(terrid ~= -1)then
					if(playerGameData[pid].HoldTerritories[terrid] ~= nil)then
						if(playerGameData[pid].HoldTerritories[terrid] >= tonumber(condition.Turnnum))then
							completed = completed + 1;
						end
					end
				end
			end
		end
	end
	if(completed >= required)then
		local num = 1;
		local effect = {}
		for _,terr in pairs(game.ServerGame.LatestTurnStanding.Territories) do
			effect[num] = WL.TerritoryModification.Create(terr.ID);
			effect[num].SetOwnerOpt = pid;
			num = num +1;
		end
		addNewOrder(WL.GameOrderEvent.Create(pid, "Win", nil, effect));
	end
end
function getterrid(game,name)
	for _,terr in pairs(game.Map.Territories)do
		if(terr.Name == name)then
			return terr.ID;
		end
	end
	return -1;
end
