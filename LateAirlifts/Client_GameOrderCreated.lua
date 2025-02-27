function Client_GameOrderCreated (game, order, skip)
	--check if an Airlift was entered, if so popup an alert to let player know it will occur at the end of a turn and not the beginning
	if (order.proxyType=='GameOrderPlayCardAirlift') then
		UI.Alert ("[LATE AIRLIFTS]\nAirlifts occur at the END OF A TURN (not the beginning) in this game.\n\nIf you no longer own the territory at that time, the airlift will not occur.");

		local toowner = game.LatestStanding.Territories[order.ToTerritoryID].OwnerPlayerID;
		local fromowner = game.LatestStanding.Territories[order.FromTerritoryID].OwnerPlayerID;
		local orderplayerTeam = game.Game.Players[order.PlayerID].Team;
		local toownerTeam = game.Game.Players[toowner].Team;
		local fromownerTeam = game.Game.Players[fromowner].Team;

		--weed odd all scenarios where the airlift would fail and cancel the airlift in those cases (and don't consume the card)
		local boolExecuteAirlift = true;
		if (toowner == WL.PlayerID.Neutral) then boolExecuteAirlift=false; end --cancel order if TO territory is neutral
		if (fromowner == WL.PlayerID.Neutral) then boolExecuteAirlift=false; end --cancel order if FROM territory is neutral

		--if player is on a team, check if TO and FROM territories belong to the same team, if so allow airlift, if not cancel it
		if (orderplayerTeam >=0) then --player has a team, check TO/FROM territory ownership for team alignment (not just solo alignment) and permit it
			if(orderplayerTeam ~= toownerTeam) then boolExecuteAirlift=false; end --cancel order if TO territory is not owned by team member that order player sending airlift belongs to
			if(orderplayerTeam ~= fromownerTeam) then boolExecuteAirlift=false; end --cancel order if FROM territory is not owned by team member that order player sending airlift belongs to
		else --order player has no team alignment so do solo ownership checks on TO/FROM territory ownership
			if(order.PlayerID ~= fromowner) then boolExecuteAirlift=false; end --cancel order if player sending airlift no longer owns the FROM territory
			if(order.PlayerID ~= toowner) then boolExecuteAirlift=false; end --cancel order if player sending airlift no longer owns the FROM territory
		end

		print ("[GOC]---------------");
		print ("order player ID=="..order.PlayerID..", team=="..orderplayerTeam);
		print ("toowner      ID=="..toowner..", team=="..toownerTeam);
		print ("fromowner    ID=="..fromowner..", team=="..fromownerTeam);

			--if operation hasn't been canceled, execute the airlift & consume the card
		if(boolExecuteAirlift==true) then
			print ("AIRLIFT YES");
			--addNewOrder(order);
		else
		--airlift has been canceled; add a message in game history to inform user why; don't consume the airlift card
			print ("airlift SKIP");
			--addNewOrder(WL.GameOrderEvent.Create(order.PlayerID, "Airlift from "..game.Map.Territories[order.FromTerritoryID].Name.." to "..game.Map.Territories[order.ToTerritoryID].Name.." has been canceled as you no longer own both territories", {}, {},{}));
		end
	end
end