function GetMoney(Spieler,pGameData,game)
	if(pGameData[Spieler] ~= nil)then
		if(Mod.Settings.BasicMoneySystem == nil or Mod.Settings.BasicMoneySystem == false or game.ServerGame.Settings.CommerceGame == false)then
			return pGameData[Spieler].Money;
		else
			if(pGameData[Spieler].Money ~= 0)then
				game.ServerGame.SetPlayerResource(Spieler, WL.ResourceType.Gold,GetMoney(Spieler,pGameData,game)+pGameData[Spieler].Money);
				pGameData[Spieler].Money = 0;
			end
			return game.ServerGame.Game.Players[Spieler].Resources[WL.ResourceType.Gold];
		end
	end
	return 0;
end
function Pay(Spieler1,Spieler2,Amout,pGameData,game)
	if(Amout > 0)then
		if(GetMoney(Spieler1,pGameData,game) >= Amout)then
			if(Mod.Settings.BasicMoneySystem == nil or Mod.Settings.BasicMoneySystem == false)then
				AddMoney(Spieler1,Amout,pGameData,game);
				RemoveMoney(Spieler2,Amout,pGameData,game);
			else
				AddMoney(Spieler1,Amout,pGameData,game);
				RemoveMoney(Spieler2,Amout,pGameData,game);
			end
		end
	else
		if(Amout < 0)then
			if(GetMoney(Spieler2,pGameData,game) >= Amout*-1)then
				if(Mod.Settings.BasicMoneySystem == nil or Mod.Settings.BasicMoneySystem == false)then
					RemoveMoney(Spieler1,-Amout,pGameData,game);
					AddMoney(Spieler2,Amout,pGameData,game);
				else
					RemoveMoney(Spieler1,Amout,pGameData,game);
					AddMoney(Spieler2,Amout,pGameData,game);
				end
			end
		end
	end
end
function AddMoney(Spieler,Amout,pGameData,game)
	if(Mod.Settings.BasicMoneySystem == nil or Mod.Settings.BasicMoneySystem == false)then
		pGameData[Spieler].Money = pGameData[Spieler].Money + Amout;
	else
		if(game.ServerGame.Settings.CommerceGame)then
			game.ServerGame.SetPlayerResource(Spieler, WL.ResourceType.Gold,GetMoney(Spieler,pGameData,game)+Amout);
		end
	end
end
function RemoveMoney(Spieler,Amout,pGameData,game)
	if(Mod.Settings.BasicMoneySystem == nil or Mod.Settings.BasicMoneySystem == false)then
		pGameData[Spieler].Money = pGameData[Spieler].Money - Amout;
	else
		if(game.ServerGame.Settings.CommerceGame)then
			game.ServerGame.SetPlayerResource(Spieler, WL.ResourceType.Gold,GetMoney(Spieler,pGameData,game)+Amout);
		end
	end
end
