function Server_AdvanceTurn_Start (game,addNewOrder)
	executed = false;
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	if(executed == false) then
		executed = true;
		for _, terr in pairs(game.ServerGame.LatestTurnStanding.Territories) do
			if(terr.OwnerPlayerID == WL.PlayerID.Neutral)then
				local Remainingarmies = 0;
				for _,conn in pairs(game.Map.Territories[terr.ID].ConnectedTo) do
					local  Takenarmies = math.random(0,Remainingarmies);
					if(Takenarmies > 0)then
						Remainingarmies = Remainingarmies - Takenarmies;
						local terrMod = {}
						terrMod[0] = WL.TerritoryModification.Create(terr.ID);
						terrMod[0].SetArmiesTo = Remainingarmies;
						terrMod[1] = WL.TerritoryModification.Create(conn.ID);
						terrMod[1].SetArmiesTo = game.ServerGame.LatestTurnStanding.Territories[conn.ID].NumArmies.NumArmies + Takenarmies;
						addNewOrder(WL.GameOrderEvent.Create(WL.PlayerID.Neutral, "Neutral Move", {}, terrMod));
					end
				end
			end
		end
	end
end
