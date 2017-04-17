
function Server_AdvanceTurn_End(game,addOrder)
    standing=game.ServerGame.LatestTurnStanding;
	for _,terr in standing.Territories do
		if not (terr.isNeutral) then
			terr.NumArmies.Substract(math.min(Mod.Settings.PestilenceStrength,terr.numArmies.numArmies));
			if (terr.NumArmies.NumArmies==0) then
				addOrder(WL.GameOrderEvent.Create(terr.OwnerPlayerID,'Pestilence',nil,WL.TerritoryModification.Create(terr.ID).SetArmiesTo(math.min(terr.NumArmies.NumArmies-Mod.Settings.PestilenceStrength,0))));
				if (terr.NumArmies.NumArmies<=Mod.Settings.PestilenceStrength) then
					addOrder(WL.GameOrderEvent.Create(terr.OwnerPlayerID,'Pestilence',nil,WL.TerritoryModification.Create(terr.ID).SetOwnerOpt(WL.PlayerID.Neutral)));
				end
			end
		end
	end

end
