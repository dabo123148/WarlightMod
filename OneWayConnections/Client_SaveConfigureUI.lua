
function Client_SaveConfigureUI(alert)
	print('Test');
    Mod.Settings.TotalRemovedConnections = InputStartArmies.GetValue();
	Mod.Settings.RemovedConnections = "";
	local num = 1;
	local setnum = 1;
	print('Test2');
	while(num < InputStartArmies.GetValue()*2) do
		print(RemovedConnectionsFields[num]);
		print(RemovedConnectionsFields[num].GetText());
		if(RemovedConnectionsFields[num].GetText() ~= nil and RemovedConnectionsFields[num+1].GetText() ~= nil)then
			print('Test3');
			bool Vorhanden = false;
			for _, elem in pairs(RemovedConnectionsFields[num].GetText())do
				if(elem == ',')then
					print('Test6');
					Vorhanden=true;
				end
			end
			for _, elem in pairs(RemovedConnectionsFields[num+1].GetText())do
				if(elem == ',')then
					print('Test5');
					Vorhanden=true;
				end
			end
			print(Vorhanden);
			if(Vorhanden == false)then
				print(RemovedConnectionsFields[num].GetText());
				Mod.Settings.RemovedConnections = Mod.Settings.RemovedConnections .. ',' ..RemovedConnectionsFields[num].GetText() .. ',';
				Mod.Settings.RemovedConnections = Mod.Settings.RemovedConnections .. RemovedConnectionsFields[num+1].GetText();
				setnum = setnum +2;
			end
		end
		num = num+2;
	end
	print(Mod.Settings.RemovedConnections);
	print('Test4');
end
