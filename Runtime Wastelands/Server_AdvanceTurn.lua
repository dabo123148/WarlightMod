
function Server_AdvanceTurn_End(game,addOrder)
    CurrentIndex=0;
	possibleTerrs={};
	Transaction={};
	standing = game.ServerGame.LatestTurnStanding;
	for _,terr in pairs(standing.Territories) do
		if ((terr.IsNeutral) and (terr.NumArmies.NumArmies~=game.Settings.WastelandSize)) then
			CurrentIndex=CurrentIndex+1;
			possibleTerrs[CurrentIndex]=terr.ID;
		end
	end
	if tablelength(possibleTerrs)<=Mod.Settings.WastelandsPerTurn then
		TransactionCounter= 0;
		for _,id in pairs(possibleTerrs) do
			TransactionCounter=TransactionCounter+1;
			terrMod=WL.TerritoryModification.Create(id);
			terrMod.SetArmiesTo=game.Settings.WastelandSize;
			Transaction[TransactionCounter]=terrMod;
		end
	else
		TransactionCounter=0;
		rand=0;
		for i=1,Mod.Settings.WastelandsPerTurn,1 do
			TransactionCounter=TransactionCounter+1;
			rand=math.random(1,tablelength(possibleTerrs));
			terrMod=WL.TerritoryModification.Create(possibleTerrs[rand]);
			terrMod.SetArmiesTo=game.Settings.WastelandSize;
			Transaction[TransactionCounter]=terrMod;
			possibleTerrs=deleteFromArray(possibleTerrs,rand);
			
		end
	end
	addOrder(WL.GameOrderEvent.Create(WL.PlayerID.Neutral,"Created " .. tablelength(Transaction) .. "new Wastelands",nil,Transaction));
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function deleteFromArray(T,Slot)
	local T2={};
	local id=0;
	for count=1,tablelength(T),1 do
		if(count~=Slot)then
			id=id+1;
			T2[id]=T[id];
		end
	end
	return T2;
end

function  printArr(T)
	out='';
	for count=1,tablelength(T),1 do
		out=out..','..T[count];
	end 
	print(out);
end
