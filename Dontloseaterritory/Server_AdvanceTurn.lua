
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
    if (order.proxyType == 'GameOrderAttackTransfer') then
		if(result.IsSuccessful and result.IsAttack)then
			--Should still support a little bit the older versions
			if(game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID ~= WL.PlayerID.Neutral)then
				if(Mod.Settings.NoTerritory == nil or Mod.Settings.NoTerritory == false)then
					for _,terr in pairs(game.ServerGame.TurnZeroStanding.Territories)do
						if(terr.ID == order.To)then
							local Player = game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID;
							if(terr.OwnerPlayerID == Player)then
								local Effect = {};
								for _,terr2 in pairs(game.ServerGame.LatestTurnStanding.Territories)do
									if(Player==terr2.OwnerPlayerID and terr2.ID ~= order.To)then
										Effect[tablelength(Effect)+1] = WL.TerritoryModification.Create(terr2.ID); 
										Effect[tablelength(Effect)].SetOwnerOpt = WL.PlayerID.Neutral;
									end
								end
								addNewOrder(WL.GameOrderEvent.Create(Player, "Got eliminated through losing a territory", nil, Effect),true);
							end
						end
					end
				else
					local Effect = {};
					local Player = game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID;
					for _,terr in pairs(game.ServerGame.LatestTurnStanding.Territories)do
						if(Player==terr.OwnerPlayerID and terr.ID ~= order.To)then
							Effect[tablelength(Effect)+1] = WL.TerritoryModification.Create(terr.ID); 
							Effect[tablelength(Effect)].SetOwnerOpt = WL.PlayerID.Neutral;
						end
					end
					addNewOrder(WL.GameOrderEvent.Create(Player, "Got eliminated through losing a territory", nil, Effect),true);
				end
			end
		end
	end
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
