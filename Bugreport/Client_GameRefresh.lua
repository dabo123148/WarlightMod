require('History');
function Client_GameRefresh(game)
	if(alreadyrefreshed == nil)then
		print("nil");
		ShowHistory(Mod.PlayerGameData.NeueNachrichten,game,Nachricht);
	else
		if(alreadyrefreshed == true)then
			print("Already refreshed");
			ShowHistory(Mod.PlayerGameData.NeueNachrichten,game,Nachricht);
		else
			print("Not refreshed yet");
			alreadyrefreshed = true;
		end
	end
	ShowHistory(game);
end
