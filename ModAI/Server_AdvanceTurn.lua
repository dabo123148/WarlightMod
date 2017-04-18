function Server_AdvanceTurn_Start (game,addNewOrder)
	print('T10');
	SkippedOrders = {};
	AddedAI = false;
	SkippedGameOrderEvents = {};
	AustehendeGameOrderEvents = 0;
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	--result GameOrderAttackTransferResult
	--order GameOrderAttackTransfer
	--Every order must be skipped to give the ais the same priority and then the new orders must be added between the skipped orders
	if (AddedAI == false) then
		SkippedOrders[tablelength(SkippedOrders)] = order;
		skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);
	else
		if(order.proxyType == 'GameOrderEvent')then
			if(AusstehendeOrdnern==0)then
				skipThisOrder(WL.ModOrderControl.Keep);
				AustehendeGameOrderEvents = AustehendeGameOrderEvents-1;
				if(AustehendeGameOrderEvents == 0)then
					--giving of card pieces
					for _, cardpiece in pairs(SkippedOrders) do
						AustehendeGameOrderEvents = 1;
						if(order.proxyType == 'GameOrderReceiveCard')then
							addNewOrder(cardpiece);
						end
					end
				end
			else
				skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);
				SkippedGameOrderEvents[tablelength(SkippedGameOrderEvents)] = order;
			end
		else
			AusstehendeOrdnern= AusstehendeOrdnern-1;
			skipThisOrder(WL.ModOrderControl.Keep);
			print('Keep ' .. AusstehendeOrdnern);
			if(order.proxyType == 'GameOrderDeploy') then
				local PlayerDeployonid = order.DeployOn;
				local PlayerDeployArmies = order.NumArmies;
				local PlayerDeployID = game.ServerGame.LatestTurnStanding.Territories[order.DeployOn].OwnerPlayerID;
				print(PlayerDeployID .. ' ' .. PlayerDeployArmies .. ' ' .. PlayerDeployonid);
				if(AusstehendeOrdnern == 0)then
					print('gameorderevents nachholen');
					for _, replayorder in pairs(SkippedGameOrderEvents)do
						if(replayorder.Message ~= "Pestilence")then
							addOrder(replayorder);
							AustehendeGameOrderEvents = AustehendeGameOrderEvents+1;
						end
					end
					if(Mod.Settings.HasPestilence)then
						print('Pestilence');
						--This is the code of the mod Pestilence. It would lead to errors, if it happens before the deploys, so I needed to put it into this code
						standing=game.ServerGame.LatestTurnStanding;
						CurrentIndex=1;
						PestilenceOrder={};
						for _,terr in pairs(standing.Territories) do
							if not (terr.IsNeutral) then
								Count = terr.NumArmies.NumArmies;
								terrMod2=WL.TerritoryModification.Create(terr.ID);
								if(terr.ID == PlayerDeployonid)then
									terrMod2.SetArmiesTo=math.max(Count-Mod.Settings.PestilenceStrength+PlayerDeployArmies,0);
								else
									terrMod2.SetArmiesTo=math.max(Count-Mod.Settings.PestilenceStrength,0);
								end
								PestilenceOrder[CurrentIndex]=terrMod2;
								CurrentIndex=CurrentIndex+1;
								--addNewOrder(WL.GameOrderEvent.Create(terr.OwnerPlayerID,'Pestilence',{},{terrMod2}));
								if (Count<=Mod.Settings.PestilenceStrength) then
									terrMod = WL.TerritoryModification.Create(terr.ID);
									terrMod.SetOwnerOpt=WL.PlayerID.Neutral;
									PestilenceOrder[CurrentIndex]=terrMod;
									CurrentIndex=CurrentIndex+1;
									--addNewOrder(WL.GameOrderEvent.Create(terr.OwnerPlayerID,"Pestilence",{},{terrMod}));
								end
							end
						end
						addNewOrder(WL.GameOrderEvent.Create(WL.PlayerID.Neutral,'Pestilence',nil,PestilenceOrder));
						AustehendeGameOrderEvents = AustehendeGameOrderEvents+1;
					else
						--giving of card pieces
						if(tablelength(SkippedGameOrderEvents)==0)then
							for _, cardpiece in pairs(SkippedOrders) do
								AustehendeGameOrderEvents = 1;
								if(order.proxyType == 'GameOrderReceiveCard')then
									addNewOrder(cardpiece);
								end
							end
						end
					end
				end
			end
		end
	end
	--print(tablelength(SkippedOrders));
end
function Server_AdvanceTurn_End(game,addNewOrder)
	--Identification of every AI
	if(AddedAI == false)then
		local AllAIs = {};
		for _,terr in pairs(game.ServerGame.LatestTurnStanding.Territories)do
			local Match = false;
			local CheckingID = terr.OwnerPlayerID;
			if(CheckingID ~= WL.PlayerID.Neutral)then
				if(game.Game.Players[CheckingID].IsAI)then
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
		local AIDeploymentsorders = {};
		for _,AI in pairs(AllAIs) do
			--Identify the Territories the AI can see
			local VisibleTerritories = {};
			--if(game.Settings.FogLevel == )
			--cause its not possible to check for foxlevel at the moment, I work with normal fog
			for _, terr in pairs(game.ServerGame.LatestTurnStanding.Territories) do
				if(terr.OwnerPlayerID == AI)then
					for _,conn in pairs(game.Map.Territories[terr.ID].ConnectedTo)do
						local Match = false;
						for _, knownterr in pairs(VisibleTerritories)do
							if(knownterr == game.ServerGame.LatestTurnStanding.Territories[conn.ID])then
								Match = true;
							end
						end
						if(Match == false)then
							VisibleTerritories[tablelength(VisibleTerritories)] = game.ServerGame.LatestTurnStanding.Territories[conn.ID];
						end
					end
					local Match2 = false;
					for _, knownterr in pairs(VisibleTerritories)do
						if(knownterr == terr)then
							Match2 = true;
						end
					end
					if(Match2 == false)then
						VisibleTerritories[tablelength(VisibleTerritories)] = terr;
					end
				end
			end
			local AIIncome = 0;
			for _, order in pairs(SkippedOrders)do
				if(order.proxyType == 'GameOrderDeploy') then
					if(game.ServerGame.LatestTurnStanding.Territories[order.DeployOn].OwnerPlayerID == AI)then
						AIIncome = AIIncome + order.NumArmies;
					end
				end
				if(order.proxyType == 'GameOrderPlayCardReinforcement') then
					print('reiforcment gespielt');
					--removes form the income the armies of the card
					--AIIncome = AIIncome - order.NumArmies;
				end
			end
			local InterrestingBonuses = {};
			for _,bonus in pairs(game.Map.Bonuses)do
				local TerrinBonus = tablelength(bonus.Territories);
				if(Mod.Settings.HasPestilence)then
					if(bonus.Amount > TerrinBonus*Mod.Settings.PestilenceStrength)then
						InterrestingBonuses[tablelength(InterrestingBonuses)] = bonus;
					end
				end
			end
			--Remove every earlyer order of the AI
			for _, order in pairs(SkippedOrders)do
				if(order.proxyType == 'GameOrderDeploy') then
					if(game.ServerGame.LatestTurnStanding.Territories[order.DeployOn].OwnerPlayerID == AI)then
						SkippedOrders = remove(SkippedOrders,order);
					end
				end
				if(order.proxyType == 'GameOrderAttackTransfer') then
					if(game.ServerGame.LatestTurnStanding.Territories[order.From].OwnerPlayerID == AI)then
						SkippedOrders = remove(SkippedOrders,order);
					end
				end
			end
			--Deployment
			if(tablelength(InterrestingBonuses)>0)then
			else
				--Through the PestilenceStrength it isn't profitable to capture a bonus
				local terridwithmaxarmies = 0;
				local maxarmies = 0;
				for _, vterr in pairs(VisibleTerritories)do
					if(vterr.NumArmies.NumArmies > maxarmies)then
						maxarmies = vterr.NumArmies.NumArmies;
						terridwithmaxarmies = vterr.ID;
					end
				end
				AIDeploymentsorders[tablelength(AIDeploymentsorders)] = WL.GameOrderDeploy.Create(AI, AIIncome , terridwithmaxarmies);
			end
		end
		--Add the deplyment orders
		AusstehendeOrdnern = 0;
		for _,order in pairs(AIDeploymentsorders) do
			print('Deployterrid: ' .. order.DeployOn);
			print('Deplyaremeen: ' ..order.NumArmies);
			print('Besitzer: ' ..game.ServerGame.LatestTurnStanding.Territories[order.DeployOn].OwnerPlayerID);
			addNewOrder(order);
			AusstehendeOrdnern= AusstehendeOrdnern+1;
		end
		for _,order in pairs(SkippedOrders)do
			if(order.proxyType == 'GameOrderDeploy') then
				local PlayerDeployonid = order.DeployOn;
				local PlayerDeployArmies = order.NumArmies;
				local PlayerDeployID = game.ServerGame.LatestTurnStanding.Territories[order.DeployOn].OwnerPlayerID;
				print(PlayerDeployID .. ' ' .. PlayerDeployArmies .. ' ' .. PlayerDeployonid);
				addNewOrder(WL.GameOrderDeploy.Create(PlayerDeployID,PlayerDeployArmies,PlayerDeployonid));
				AusstehendeOrdnern=AusstehendeOrdnern+1;
			end
		end
		--Attack(old order que with injections of the ai turns)
		local AIAttackOrderslength = 0;
		local PlayerAttackOrderslength = 0;
		AddedAI = true;
		print('Ende');
	end
end
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
function remove(T,E)
	local  newT = {};
	for _, EinT in pairs(T) do
		if(EinT ~= E)then
			newT[tablelength(newT)] = EinT;
		end
	end
	return newT;
end