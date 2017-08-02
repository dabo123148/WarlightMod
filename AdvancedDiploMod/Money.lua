function GetMoney(Spieler,pGameData)
	if(pGameData[Spieler] ~= nil)then
		return pGameData[Spieler].Money;
	end
	return 0;
end
function Pay(Spieler1,Spieler2,Amout,pGameData)
	if(Amout > 0)then
		if(GetMoney(Spieler1,pGameData) >= Amout)then
			pGameData[Spieler1].Money = pGameData[Spieler1].Money - Amout;
			pGameData[Spieler2].Money = pGameData[Spieler2].Money + Amout;
		end
	else
		if(Amout < 0)then
			if(GetMoney(Spieler2,pGameData) >= Amout*-1)then
				pGameData[Spieler1].Money = pGameData[Spieler1].Money - Amout;
				pGameData[Spieler2].Money = pGameData[Spieler2].Money + Amout;
			end
		end
	end
end
function AddMoney(Spieler,Amout,pGameData)
	pGameData[Spieler].Money = pGameData[Spieler].Money + Amout;
end
function RemoveMoney( Spieler,Amout,pGameData)
	pGameData[Spieler].Money = pGameData[Spieler].Money - Amout;
end
