
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
    if (order.proxyType == 'GameOrderAttackTransfer') then
		if(result.IsSuccessful and result.IsAttack)then
			--Should still support a little bit the older versions
			if(Mod.Settings.NoTerritory == nil)then
				for _,terr in pairs(game.ServerGame.TurnZeroStanding.Territories)do
					if(terr.ID == order.To)then
						if(terr.OwnerPlayerID ~= WL.PlayerID.Neutral)then
							skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);
							addNewOrder(Eliminate(game,game.ServerGame.LatestTurnStanding.Territories[order.To]));
							addNewOrder(order);
						end
					end
				end
			end
			if(Mod.Settings.NoTerritory == false)then
				for _,terr in pairs(game.ServerGame.TurnZeroStanding.Territories)do
					if(terr.ID == order.To)then
						if(terr.OwnerPlayerID ~= WL.PlayerID.Neutral)then
							skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);
							addNewOrder(Eliminate(game,game.ServerGame.LatestTurnStanding.Territories[order.To]));
							addNewOrder(order);
						end
					end
				end
			else
				skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);
				addNewOrder(Eliminate(game,game.ServerGame.LatestTurnStanding.Territories[order.To]));
				addNewOrder(order);
			end
		end
	end
end
function Eliminate(game,Player)
	local Effect = {};
	for _,terr in pairs(game.ServerGame.LatestTurnStanding.Territories)do
		if(Player==terr.OwnerPlayerID)then
			Effect[tablelength(t)+1] = WL.TerritoryModification.Create(terr.ID); 
			Effect[tablelength(t)].SetOwnerOpt = WL.PlayerID.Neutral;
		end
	end
	return WL.GameOrderEvent.Create(Player, "Got eliminated through losing a territory", nil, Effect);
end
function Exists(game,Player)
	for _,terr in pairs(game.ServerGame.LatestTurnStanding.Territories)do
		if(Player==terr.OwnerPlayerID)then
			return true;
		end
	end
	return false;
end
function tablelength(t)
	local count = 0;
	for _,elem in pairs(t)do
		count = count + 1;
	end
	return count;
end
