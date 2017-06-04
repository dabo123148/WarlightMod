function Server_AdvanceTurn_Order(game,gameOrder,result,skip,add)
	Mod.PlayerGameData[gameOrder.PlayerID].SuccessfullyAttacked=false;
	if(gameOrder.proxyType=='GameOrderAttackTransfer')then
		if(result.IsSuccessful)then
			if(Mod.Settings.PestCardIn)then
				Mod.PlayerGameData[gameOrder.PlayerID].SuccessfullyAttacked=true;
				
			end
		end
	end
end


function Server_AdvanceTurn_End(game,addOrder)
	for playerID in pairs(game.ServerGame.Game.PlayingPlayers) do
		if(Mod.PlayerGameData[playerID].SuccessfullyAttacked)then
			if(Mod.PlayerGameData[gameOrder.PlayerID].PestCardPieces==nil)then
				Mod.PlayerGameData[gameOrder.PlayerID].PestCardPieces=0;
			end
			Mod.PlayerGameData[gameOrder.PlayerID].PestCardPieces=Mod.PlayerGameData[gameOrder.PlayerID].PestCardPiecesNeeded+1;
			if(Mod.PlayerGameData[gameOrder.PlayerID].PestCardPieces>=Mod.Settings.PestCardPiecesNeeded)then
				if(Mod.PlayerGameData[gameOrder.PlayerID].PestCards==nil)then
					Mod.PlayerGameData[gameOrder.PlayerID].PestCards=0;
				end
				Mod.PlayerGameData[gameOrder.PlayerID].PestCards=Mod.PlayerGameData[gameOrder.PlayerID].PestCards+1;
				Mod.PlayerGameData[gameOrder.PlayerID].PestCardPieces=0;
			end
			addOrder(WL.GameOrderCustom.Create(playerID,'Added Pestilence Card Piece',''));
		end
	end
--    standing=game.ServerGame.LatestTurnStanding;
--	CurrentIndex=1;
--	PestilenceOrder={};
--	for _,terr in pairs(standing.Territories) do
--		if not (terr.IsNeutral) then
--			Count = terr.NumArmies.NumArmies;
--			terrMod2=WL.TerritoryModification.Create(terr.ID);
--			terrMod2.SetArmiesTo=math.max(Count-Mod.Settings.PestilenceStrength,0);
--			PestilenceOrder[CurrentIndex]=terrMod2;
--			CurrentIndex=CurrentIndex+1;
--			--addOrder(WL.GameOrderEvent.Create(terr.OwnerPlayerID,'Pestilence',{},{terrMod2}));
--			if (Count<=Mod.Settings.PestilenceStrength) and tablelength(terr.NumArmies.SpecialUnits)<1 then
--					
--				terrMod = WL.TerritoryModification.Create(terr.ID);
--				terrMod.SetOwnerOpt=WL.PlayerID.Neutral;
--				PestilenceOrder[CurrentIndex]=terrMod;
--				CurrentIndex=CurrentIndex+1;
--				
--				--addOrder(WL.GameOrderEvent.Create(terr.OwnerPlayerID,"Pestilence",{},{terrMod}));
--			end
--			
--		end
--	end
--	addOrder(WL.GameOrderEvent.Create(WL.PlayerID.Neutral,'Pestilence',nil,PestilenceOrder));

	
end
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
