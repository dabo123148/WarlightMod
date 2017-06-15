function Server_AdvanceTurn_Order(game,gameOrder,result,skip,addOrder)
	
	if(gameOrder.proxyType=='GameOrderAttackTransfer')then
		local playerID=gameOrder.PlayerID;
		if(gameOrder.PlayerID>50)then
			if(result.IsSuccessful and result.IsAttack)then
				local PGD=Mod.PlayerGameData;
				PGD[gameOrder.PlayerID].SuccessfullyAttacked=1;
				Mod.PlayerGameData=PGD;
			end
		end
	end
	if(gameOrder.proxyType=='GameOrderCustom')then
		if(gameOrder.Payload~=nil)then
			if(split(gameOrder.Payload,'|')[1]=='Pestilence')then
				PGD=Mod.PublicGameData;
				PGD.PestilenceStadium[tonumber(split(gameOrder.Payload,'|')[2])]=1;
				PlGD=Mod.PlayerGameData;
				PlGD[gameOrder.PlayerID].PestCards=PlGD[gameOrder.PlayerID].PestCards-1;
				Mod.PlayerGameData=PlGD;
				Mod.PublicGameData=PGD;
			end
		end
	end
end


function Server_AdvanceTurn_End(game,addOrder)
	PGD = Mod.PlayerGameData;
	PuGD = Mod.PublicGameData;
	for playerID in pairs(game.ServerGame.Game.PlayingPlayers) do
		--addOrder(WL.GameOrderCustom.Create(playerID,'Added Pestilence Card Piece (TEST 1)',''));
		if(playerID>50)then
			--addOrder(WL.GameOrderCustom.Create(playerID,'Added Pestilence Card Piece (TEST 2)' .. Mod.PlayerGameData[playerID].SuccessfullyAttacked,''));
			if(Mod.PlayerGameData[playerID].SuccessfullyAttacked==1)then
				--addOrder(WL.GameOrderCustom.Create(playerID,'Added Pestilence Card Piece (TEST 3)',''));
				if(Mod.Settings.PestCardIn)then
					PGD[playerID].PestCardPieces=Mod.PlayerGameData[playerID].PestCardPieces+1;
					if(Mod.PlayerGameData[playerID].PestCardPieces+1>=Mod.Settings.PestCardPiecesNeeded)then
						PGD[playerID].PestCards=Mod.PlayerGameData[playerID].PestCards+1;
						PGD[playerID].PestCardPieces=0;
					end
					addOrder(WL.GameOrderCustom.Create(playerID,'Added Pestilence Card Piece. You now have '..PGD[playerID].PestCards..' Cards and '..PGD[playerID].PestCardPieces..'/'..Mod.Settings.PestCardPiecesNeeded..' Pieces.',''));
				end
				if(Mod.Settings.NukeCardIn ~=nil and Mod.Settings.NukeCardIn)then
					PGD[playerID].NukeCardPieces=Mod.PlayerGameData[playerID].NukeCardPieces+1;
					if(Mod.PlayerGameData[playerID].NukeCardPieces+1>=Mod.Settings.NukeCardPiecesNeeded)then
						PGD[playerID].NukeCards=Mod.PlayerGameData[playerID].NukeCards+1;
						PGD[playerID].NukeCardPieces=0;
					end
					addOrder(WL.GameOrderCustom.Create(playerID,'Added Nuke Card Piece. You now have '..PGD[playerID].NukeCards..' Cards and '..PGD[playerID].NukeCardPieces..'/'..Mod.Settings.NukeCardPiecesNeeded..' Pieces.',''));
				end
			end
		end
		--print(tostring(Mod.PublicGameData.PestilenceStadium));
		if(Mod.PublicGameData.PestilenceStadium[playerID]~=nil)then
			PestTerrs={};
			if(Mod.PublicGameData.PestilenceStadium[playerID]==1)then
				PuGD.PestilenceStadium[playerID]=2;
			else
				if(Mod.PublicGameData.PestilenceStadium[playerID]==2)then
					standing=game.ServerGame.LatestTurnStanding;
					CurrentIndex=1;
					PestilenceOrder={};
					for _,terr in pairs(standing.Territories) do
						if terr.OwnerPlayerID==playerID then
							Count = terr.NumArmies.NumArmies;
							terrMod2=WL.TerritoryModification.Create(terr.ID);
							terrMod2.SetArmiesTo=math.max(Count-Mod.Settings.PestCardStrength,0);
							PestilenceOrder[CurrentIndex]=terrMod2;
							CurrentIndex=CurrentIndex+1;
			--addOrder(WL.GameOrderEvent.Create(terr.OwnerPlayerID,'Pestilence',{},{terrMod2}));
							if (Count<=Mod.Settings.PestCardStrength) and tablelength(terr.NumArmies.SpecialUnits)<1 then
						
								terrMod = WL.TerritoryModification.Create(terr.ID);
								terrMod.SetOwnerOpt=WL.PlayerID.Neutral;
								PestilenceOrder[CurrentIndex]=terrMod;
								CurrentIndex=CurrentIndex+1;
				
				--addOrder(WL.GameOrderEvent.Create(terr.OwnerPlayerID,"Pestilence",{},{terrMod}));
							end
			
						end
					end
					addOrder(WL.GameOrderEvent.Create(playerID,'Pestilence',nil,PestilenceOrder));
					PuGD.PestilenceStadium[playerID]=0;
				end
			end
			
		end
	end
	Mod.PublicGameData=PuGD;
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
function split(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end
