
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
	local RC = stringtotable(RCstring);
	RemovedConnectionsFields = {};
	while(num < initialValue*2)do
		 local removedconn1 = UI.CreateHorizontalLayoutGroup(rootParent);
		 UI.CreateLabel(removedconn1).SetText('From ');
		 local enteredtext =  RC[num];
		 if(enteredtext == nil)then
			 enteredtext = "";
		 end
		 RemovedConnectionsFields[num] = UI.CreateTextInputField(removedconn1).SetText(enteredtext).SetPreferredWidth(100).SetPreferredHeight(30);
		 UI.CreateLabel(removedconn1).SetText('To ');
		 enteredtext =  RC[num+1];
		 if(enteredtext == nil)then
			 enteredtext = "";
		 end
		 RemovedConnectionsFields[num+1] = UI.CreateTextInputField(removedconn1).SetText(enteredtext).SetPreferredWidth(100).SetPreferredHeight(30);
		num = num+2;
	end
end
function stringtotable(variable)
	chartable = {};
	while(string.len(variable)>0)do
		chartable[tablelength(chartable)] = string.sub(variable, 1 , 1);
		variable = string.sub(variable, 2);
	end
	local newtable = {};
	local tablepos = 0;
	local executed = false;
	for _, elem in pairs(chartable)do
		if(elem == ",")then
			tablepos = tablepos + 1;
			newtable[tablepos] = "";
			executed = true;
		else
			if(executed == false)then
				tablepos = tablepos + 1;
				newtable[tablepos] = "";
				executed = true;
			end
			if(newtable[tablepos] == nil)then
				newtable[tablepos] = elem;
			else
				newtable[tablepos] = newtable[tablepos] .. elem;
			end
		end
	end
	return newtable;
end
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
