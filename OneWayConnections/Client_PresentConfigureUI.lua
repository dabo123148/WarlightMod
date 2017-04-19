
function Client_PresentConfigureUI(rootParent)
	local initialValue = Mod.Settings.TotalRemovedConnections;
	if initialValue == nil then
		initialValue = 1;
	end
    
    local horz = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(horz).SetText('Total removed Connections ');
    InputStartArmies = UI.CreateNumberInputField(horz)
		.SetSliderMinValue(0)
		.SetSliderMaxValue(100)
		.SetValue(initialValue);
	local num = 1;
	local RCstring = Mod.Settings.RemovedConnections;
	if(RCstring == nil)then
		RCstring = ",";
	end
	local RC = {};
	local savedarraynum = 0;
	for _, elem in pairs(RCstring)do
		if(elem == ',')then
			savedarraynum = savedarraynum +1;
			RC[savedarraynum] = "";
		else
			RC[savedarraynum] = RC[savedarraynum] .. elem;
		end
	end
	RemovedConnectionsFields = {};
	while(num < initialValue*2)do
		 local removedconn1 = UI.CreateHorizontalLayoutGroup(rootParent);
		 UI.CreateLabel(removedconn1).SetText('From ');
		 local enteredtext =  RC[num];
		 if(enteredtext == nil)then
			 enteredtext = "";
		 end
		 RemovedConnectionsFields[num] = UI.CreateTextInputField(removedconn1).SetText(enteredtext).SetPreferredWidth(100);
		 UI.CreateLabel(removedconn1).SetText('To ');
		 enteredtext =  RC[num+1];
		 if(enteredtext == nil)then
			 enteredtext = "";
		 end
		  RemovedConnectionsFields[num+1] = UI.CreateTextInputField(removedconn1).SetText(enteredtext).SetPreferredWidth(100);
		num = num+2;
	end
end
