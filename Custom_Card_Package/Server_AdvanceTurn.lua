function Server_AdvanceTurn_Order(game,gameOrder,result,skip,addOrder)
	
	if(gameOrder.proxyType=='GameOrderAttackTransfer')then
		local playerID=gameOrder.PlayerID;
		--addOrder(WL.GameOrderCustom.Create(playerID,'Test 1',''));
		if(gameOrder.PlayerID>50)then
			--addOrder(WL.GameOrderCustom.Create(playerID,'Test 2',''));
			--addOrder(WL.GameOrderCustom.Create(playerID,'Test 3',''));
			if(result.IsSuccessful and result.IsAttack)then
				--addOrder(WL.GameOrderCustom.Create(playerID,'Test 4',''));
				if(Mod.Settings.PestCardIn)then
					--addOrder(WL.GameOrderCustom.Create(playerID,'Test 5',''));
					local PGD=Mod.PlayerGameData;
					PGD[gameOrder.PlayerID].SuccessfullyAttacked=1;
					Mod.PlayerGameData=PGD;
				end
			end
		end
	end
end


function Server_AdvanceTurn_End(game,addOrder)
	PGD = Mod.PlayerGameData;
	for playerID in pairs(game.ServerGame.Game.PlayingPlayers) do
		--addOrder(WL.GameOrderCustom.Create(playerID,'Added Pestilence Card Piece (TEST 1)',''));
		if(playerID>50)then
			--addOrder(WL.GameOrderCustom.Create(playerID,'Added Pestilence Card Piece (TEST 2)' .. Mod.PlayerGameData[playerID].SuccessfullyAttacked,''));
			if(Mod.PlayerGameData[playerID].SuccessfullyAttacked==1)then
				--addOrder(WL.GameOrderCustom.Create(playerID,'Added Pestilence Card Piece (TEST 3)',''));
				
				PGD[playerID].PestCardPieces=Mod.PlayerGameData[playerID].PestCardPieces+1;
				if(Mod.PlayerGameData[playerID].PestCardPieces>=Mod.Settings.PestCardPiecesNeeded)then
					PGD[playerID].PestCards=Mod.PlayerGameData[playerID].PestCards+1;
					PGD[playerID].PestCardPieces=0;
				end
				addOrder(WL.GameOrderCustom.Create(playerID,'Added Pestilence Card Piece. You now have '..PGD[playerID].PestCards..' Cards and '..PGD[playerID].PestCardPieces..'/'..Mod.Settings.PestCardPiecesNeeded..' Pieces.',''));
			end
		end
	end
	Mod.PlayerGameData=PGD;
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
