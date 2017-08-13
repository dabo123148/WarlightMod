function GetMoney(Spieler,pGameData,game)
	if(pGameData[Spieler] ~= nil)then
		if(Mod.Settings.BasicMoneySystem == nil or Mod.Settings.BasicMoneySystem == false)then
			return pGameData[Spieler].Money;
		else
			if(game.ServerGame.Game.Players[Spieler].Resources[WL.ResourceType.Gold] == nil or game.ServerGame.Game.Players[Spieler].Resources[WL.ResourceType.Gold] == 0)then
				return 0;
			else
				return game.ServerGame.Game.Players[Spieler].Resources[WL.ResourceType.Gold];
			end
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
		if(game.ServerGame.Game.Players[Spieler].Resources[WL.ResourceType.Gold] == nil)then
			--game.ServerGame.Game.Players[Spieler].Resources[WL.ResourceType.Gold] = ;
		end
		pGameData[Spieler].Money = pGameData[Spieler].Money + Amout;
	end
end
function RemoveMoney(Spieler,Amout,pGameData,game)
	if(Mod.Settings.BasicMoneySystem == nil or Mod.Settings.BasicMoneySystem == false)then
		pGameData[Spieler].Money = pGameData[Spieler].Money - Amout;
	else
		pGameData[Spieler].Money = pGameData[Spieler].Money - Amout;
	end
end
