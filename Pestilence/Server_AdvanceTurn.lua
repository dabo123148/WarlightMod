
function Server_AdvanceTurn_End(game,addOrder)
    standing=game.ServerGame.LatestTurnStanding;
	for _,terr in pairs(standing.Territories) do
		if not (terr.IsNeutral) then
			terr.NumArmies = WL.Armies.Create(terr.NumArmies.NumArmies-Mod.Settings.PestilenceStrength);
			if (terr.NumArmies.NumArmies<=0) then
				terr.OwnerPlayerID = WL.PlayerID.Neutral;
			end
		end
	end

end
