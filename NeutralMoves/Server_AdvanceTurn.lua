function Server_AdvanceTurn_Start (game,addNewOrder)
	for _, terr in pairs(game.ServerGame.LatestTurnStanding.Territories) do
		if(terr.OwnerPlayerID == WL.PlayerID.Neutral)then
			local Remainingarmies = 0;
			for _,conn in pairs(game.Map.Territories[terr].ConnectedTo) do
				local  Takenarmies = math.random(0,Remainingarmies);
				Remainingarmies = Remainingarmies - Takenarmies;
				addNewOrder(WL.GameOrderAttackTransfer.Create(WL.PlayerID.Neutral, terr.ID, conn.ID, attackOrTransfer,true, WL.Armies.Create(Takenarmies), false));
			end
		end
	end
end
