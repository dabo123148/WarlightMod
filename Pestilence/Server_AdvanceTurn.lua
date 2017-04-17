
function Server_AdvanceTurn_End(game,addOrder)
    standing=game.ServerGame.LatestTurnStanding;
	for _,terr in pairs(standing.Territories) do
		if not (terr.IsNeutral) then
			Count = terr.NumArmies.NumArmies;
			terrMod2=WL.TerritoryModification.Create(terr.ID);
			terrMod2.SetArmiesTo=math.max(Count-Mod.Settings.PestilenceStrength,0);
			addOrder(WL.GameOrderEvent.Create(terr.OwnerPlayerID,'Pestilence',{},{terrMod2}));
			if (Count<=Mod.Settings.PestilenceStrength) then
				terrMod = WL.TerritoryModification.Create(terr.ID);
				terrMod.SetOwnerOpt=WL.PlayerID.Neutral;
				addOrder(WL.GameOrderEvent.Create(terr.OwnerPlayerID,"Pestilence",{},{terrMod}));
			end
			
		end
	end

end
