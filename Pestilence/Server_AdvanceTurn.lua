
function Server_AdvanceTurn_End(game,addOrder)
    standing=game.ServerGame.LatestTurnStanding;
	CurrentIndex=1;
	PestilenceOrder={};
	for _,terr in pairs(standing.Territories) do
		if not (terr.IsNeutral) then
			Count = terr.NumArmies.NumArmies;
			terrMod2=WL.TerritoryModification.Create(terr.ID);
			terrMod2.SetArmiesTo=math.max(Count-Mod.Settings.PestilenceStrength,0);
			PestilenceOrder[CurrentIndex]=terrMod2;
			CurrentIndex=CurrentIndex+1;
			--addOrder(WL.GameOrderEvent.Create(terr.OwnerPlayerID,'Pestilence',{},{terrMod2}));
			if (Count<=Mod.Settings.PestilenceStrength) and terr.NumArmies.SpecialUnits=={} then
					
				terrMod = WL.TerritoryModification.Create(terr.ID);
				terrMod.SetOwnerOpt=WL.PlayerID.Neutral;
				PestilenceOrder[CurrentIndex]=terrMod;
				CurrentIndex=CurrentIndex+1;
				
				--addOrder(WL.GameOrderEvent.Create(terr.OwnerPlayerID,"Pestilence",{},{terrMod}));
			end
			
		end
	end
	addOrder(WL.GameOrderEvent.Create(WL.PlayerID.Neutral,'Pestilence',nil,PestilenceOrder));

end
