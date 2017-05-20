
function Client_PresentConfigureUI(rootParent)
	parant = rootParent;
	local num = 1;
	local RCstring = Mod.Settings.RemovedConnections;
	if(RCstring == nil)then
		RCstring = ",,";
	end
	local RC = stringtotable(RCstring);
	RemovedConnectionsFields = {};
	while(num <tablelength(RC))do
		 local enteredtext =  RC[num];
		 if(enteredtext == nil)then
			 enteredtext = "";
		 end
		 enteredtext2 =  RC[num+1];
		 if(enteredtext2 == nil)then
			 enteredtext2 = "";
		 end
		addnewline(rootParent,enteredtext,enteredtext2);
		num = num+2;
	end
	local buttonlayer = UI.CreateHorizontalLayoutGroup(rootParent);
	newlinebutton = UI.CreateButton(buttonlayer).SetText('new Line').SetOnClick(buttonnewline);
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
function buttonnewline()
	addnewline("","");
end
function addnewline(content1,content2)
	local removedconn1 = UI.CreateHorizontalLayoutGroup(parent);
	UI.CreateLabel(removedconn1).SetText('From ');
	RemovedConnectionsFields[tablelength(RemovedConnectionsFields)+1] = UI.CreateTextInputField(removedconn1).SetText(content1).SetPreferredWidth(200).SetPreferredHeight(30);
	UI.CreateLabel(removedconn1).SetText('To ');
	RemovedConnectionsFields[tablelength(RemovedConnectionsFields)+1] = UI.CreateTextInputField(removedconn1).SetText(content2).SetPreferredWidth(200).SetPreferredHeight(30);
end
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
