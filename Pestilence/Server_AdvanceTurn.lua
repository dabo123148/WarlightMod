
function Server_AdvanceTurn_End(game,addOrder)
    standing=game.ServerGame.LatestTurnStanding;
	for _,terr in pairs(standing.Territories) do
		if not (terr.IsNeutral) then
			--addOrder(WL.GameOrderEvent.Create(terr.OwnerPlayerID,'Pestilence',nil,WL.TerritoryModification.Create(terr.ID).SetArmiesTo(math.min(terr.NumArmies.NumArmies-Mod.Settings.PestilenceStrength,0))));
			if (terr.NumArmies.NumArmies<=Mod.Settings.PestilenceStrength) then
				terrMod = WL.TerritoryModification.Create(terr.ID);
				terrMod.SetOwnerOpt=WL.PlayerID.Neutral;
				addOrder(WL.GameOrderEvent.Create(terr.OwnerPlayerID,"Pestilence",nil,{terrMod}));
			end
			
		end
	end

end
