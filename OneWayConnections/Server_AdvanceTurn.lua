
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	--result GameOrderAttackTransferResult
	--order GameOrderAttackTransfer
    if (order.proxyType == 'GameOrderAttackTransfer') then
		removedconns = Mod.Settings.RemovedConnections;
		local num = 1;
		local Match = false;
		local Fromterrname = string.upper(game.Map.Territories[order.From].Name);
		local Toterrname = string.upper(game.Map.Territories[order.To].Name);
		while(num < Mod.Settings.TotalRemovedConnections*2 and Match == false)do
			if(removedconns[num] ~=nil)then
				if(string.upper(removedconns[num]) == Fromterrname and string.upper(removedconns[num+1]) == Toterrname)then
					Match = true;
					skipThisOrder(WL.ModOrderControl.Skip);
				end
			end
			num = num + 2;
		end
	end
end
