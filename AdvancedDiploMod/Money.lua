function GetMoney(Spieler,pGameData,game)
	if(pGameData[Spieler] ~= nil)then
		if(Mod.Settings.BasicMoneySystem == nil or Mod.Settings.BasicMoneySystem == false or game.ServerGame.Settings.CommerceGame == false)then
			return pGameData[Spieler].Money;
		else
			return game.ServerGame.LatestTurnStanding.NumResources(Spieler, WL.ResourceType.Gold);
		end
	end
	return 0;
end
function Pay(Spieler1,Spieler2,Amout,pGameData,game,openedfromcustommessage)
	if(Amout > 0)then
		if(GetMoney(Spieler2,pGameData,game) >= Amout)then
			if(Mod.Settings.BasicMoneySystem == nil or Mod.Settings.BasicMoneySystem == false or game.ServerGame.Settings.CommerceGame == false)then
				AddMoney(Spieler1,Amout,pGameData,game);
				RemoveMoney(Spieler2,Amout,pGameData,game,openedfromcustommessage);
			else
				AddMoney(Spieler1,Amout,pGameData,game);
				RemoveMoney(Spieler2,Amout,pGameData,game,openedfromcustommessage);
			end
		end
	else
		if(Amout < 0)then
			if(GetMoney(Spieler2,pGameData,game) >= Amout*-1)then
				if(Mod.Settings.BasicMoneySystem == nil or Mod.Settings.BasicMoneySystem == false or game.ServerGame.Settings.CommerceGame == false)then
					RemoveMoney(Spieler1,-Amout,pGameData,game,openedfromcustommessage);
					AddMoney(Spieler2,-Amout,pGameData,game);
				else
					RemoveMoney(Spieler1,-Amout,pGameData,game,openedfromcustommessage);
					AddMoney(Spieler2,-Amout,pGameData,game);
				end
			end
		end
	end
end
function AddMoney(Spieler,Amout,pGameData,game)
	pGameData[Spieler].Money = pGameData[Spieler].Money + Amout;
end
function RemoveMoney(Spieler,Amout,pGameData,game,openedfromcustommessage)
	if(openedfromcustommessage == nil or Mod.Settings.BasicMoneySystem == nil or Mod.Settings.BasicMoneySystem == false or game.ServerGame.Settings.CommerceGame == false)then
		pGameData[Spieler].Money = pGameData[Spieler].Money - Amout;
	else
		--game.SetPlayerResource(Spieler,WL.ResourceType.Gold,game.ServerGame.Game.Players[Spieler].Resources[WL.ResourceType.Gold]-Amout);
	end
end
