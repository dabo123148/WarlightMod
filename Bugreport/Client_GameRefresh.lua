require('History');
function Client_GameRefresh(game)
	if(alreadyrefreshed == nil)then
		print("nil");
			ShowHistory(game);
	else
		if(alreadyrefreshed == true)then
			print("Already refreshed");
				ShowHistory(game);
		else
			print("Not refreshed yet");
			alreadyrefreshed = true;
		end
	end
end
