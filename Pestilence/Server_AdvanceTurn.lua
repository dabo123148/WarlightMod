
function Server_AdvanceTurn_End(game,addOrder)
    standing=game.ServerGame.LatestTurnStanding;
	for _,terr in pairs(standing.Territories) do
		if not (terr.IsNeutral) then
			terr.NumArmies.Substract(math.min(Mod.Settings.PestilenceStrength,terr.numArmies.numArmies));
			if (terr.NumArmies.NumArmies==0) then
				terr.OwnerPlayerID = WL.PlayerID.Neutral;
			end
		end
	end

end
