
function Client_SaveConfigureUI(alert)
	print('Test');
    Mod.Settings.TotalRemovedConnections = InputStartArmies.GetValue();
	Mod.Settings.RemovedConnections = {};
	local num = 1;
	local setnum = 1;
	print('Test2');
	--while(num < InputStartArmies.GetValue()*2) do
	--	print(RemovedConnectionsFields[num]);
	--	print(RemovedConnectionsFields[num].GetText());
	--	if(RemovedConnectionsFields[num].GetText() ~= nil and RemovedConnectionsFields[num+1].GetText() ~= nil)then
	--		print('Test3');
	--		print(RemovedConnectionsFields[num].GetText());
	---		Mod.Settings.RemovedConnections[setnum] = RemovedConnectionsFields[num].GetText();
	--		Mod.Settings.RemovedConnections[setnum+1] = RemovedConnectionsFields[num+1].GetText();
	--		setnum = setnum +2;
	--	end
	--	num = num+2;
	--end
	print('Test4');
end