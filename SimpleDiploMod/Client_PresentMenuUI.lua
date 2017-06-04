function Client_PresentMenuUI(rootParent, setMaxSize, setScrollable, game)
	TargetPlayerBtn = nil;
	declarebutton=nil;
	declarewarbutton=nil;
	textelem=nil;
	commitbutton =nil;
	openshopbutton = nil;
	offerpeacebutton = nil;
	offerallianzebutton = nil;
	pendingrequestbutton = nil;
	Game = game;
	root = rootParent;
	setMaxSize(450, 350);
	if (game.Us == nil) then
		UI.CreateLabel(vert).SetText("You cannot use the Diplomacy game, cause you aren't in the game");
		return;
	end
  	horz = UI.CreateHorizontalLayoutGroup(root);
 	moneyobj = UI.CreateLabel(horz).SetText('Current Money: ' .. Mod.PlayerGameData.Money);
	mainmenu = UI.CreateButton(horz).SetText("Main Menu").SetOnClick(OpenMenu);
	horz = UI.CreateHorizontalLayoutGroup(root);
	OpenMenu(rootParent);
end
function OpenOfferPeace()
	DeleteUI();
	textelem = UI.CreateLabel(horz).SetText("Offer peace to: ");
	TargetPlayerBtn = UI.CreateButton(horz).SetText("Select player...").SetOnClick(TargetPlayerClickedOfferPeace);
	horz = UI.CreateHorizontalLayoutGroup(root);
	commitbutton = UI.CreateButton(horz).SetText("Offer").SetOnClick(commitofferpeace);
end
function commitofferpeace()
	local offerto = TargetPlayerBtn.GetText();
	local myID = Game.Us.ID;
	local Preis = 0;
	if(offerto == "Select player...")then
		UI.Alert('You need to choose a player first');
	else
		print('Test1');
		Game.SendGameCustomMessage("Sending request...", "Peace " .. offerto .. " ", function(returnvalue)
			UI.Alert("Proposal sent!");
			end);
		print('Test2');
	end
end
function TargetPlayerClickedOfferPeace()
	if(Mod.PublicGameData.War ~= nil and Mod.PublicGameData.War[Game.Us.ID] ~= nil)then
		local options = {};
		local inwarwith = stringtotable(Mod.PublicGameData.War[Game.Us.ID]);
		for _,playerinstanze in pairs(Game.Game.Players)do
			for _,with in pairs(inwarwith)do
				if(tostring(with) == tostring(playerinstanze.ID))then
					table.insert(options,playerinstanze);
				end
			end
		end
		options = map(options, PlayerButton);
		UI.PromptFromList("Select the player you'd like to offer the peace to", options);
	else	
		UI.Alert('You are currently with noone in war');
	end
end
function OpenMenu()
	DeleteUI();
	--UI.CreateLabel(horz).SetText("Shop");
	openshopbutton = UI.CreateButton(horz).SetText("Shop").SetOnClick(Openshop);
 	horz = UI.CreateHorizontalLayoutGroup(root);
 	--UI.CreateLabel(horz).SetText("Declare War");
	declarewarbutton = UI.CreateButton(horz).SetText("Declare War").SetOnClick(OpenDeclarWar);
 	horz = UI.CreateHorizontalLayoutGroup(root);
	--UI.CreateLabel(horz).SetText("Offer Peace");
	offerpeacebutton = UI.CreateButton(horz).SetText("Offer Peace").SetOnClick(OpenOfferPeace);
	horz = UI.CreateHorizontalLayoutGroup(root);
	--UI.CreateLabel(horz).SetText("Offer Allianze");
	offerallianzebutton = UI.CreateButton(horz).SetText("Offer Alliance").SetOnClick(OpenOfferAlliance);
  	horz = UI.CreateHorizontalLayoutGroup(root);
  	--UI.CreateLabel(horz).SetText("Pending Requests");
	pendingrequestbutton = UI.CreateButton(horz).SetText("Pending Requests").SetOnClick(OpenPendingRequests);
end
function Openshop(rootParent)
	--DeleteUI();
end
function OpenDeclarWar()
	DeleteUI();
	horz = UI.CreateHorizontalLayoutGroup(root);
	textelem = UI.CreateLabel(horz).SetText("Declare war on: ");
	TargetPlayerBtn = UI.CreateButton(horz).SetText("Select player...").SetOnClick(TargetPlayerClicked);
	horz = UI.CreateHorizontalLayoutGroup(root);
	commitbutton = UI.CreateButton(horz).SetText("Declare").SetOnClick(declare);
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
function TargetPlayerClicked()
	local options = {};
	if(Mod.PublicGameData.War ~= nil and Mod.PublicGameData.War[Game.Us.ID] ~= nil)then
		print('Test');
		local inwarwith = stringtotable(Mod.PublicGameData.War[Game.Us.ID]);
		for _,playerinstanze in pairs(Game.Game.Players)do
			print('Test2');
			local Match = false;
			for _,with in pairs(inwarwith)do
				if(tostring(with) == tostring(playerinstanze.ID))then
					Match = true;
				end
			end
			if(Match == false)then
				print('insert');
				if(playerinstanze.ID ~= Game.Us.ID)then
					table.insert(options,playerinstanze);
				end
			end
		end
	else	
		if(Mod.PublicGameData.War ~=nil)then
			print(Mod.PublicGameData.War[Game.Us.ID]);
		else
			print('neu?');
		end
		print('Test3');
		for _,playerinstanze in pairs(Game.Game.Players)do
			if(playerinstanze.ID ~= Game.Us.ID)then
				table.insert(options,playerinstanze);
			end
		end
	end
	options = map(options, PlayerButton);
	UI.PromptFromList("Select the player you'd like to declare war on", options);
end
function declare()
	local declareon = TargetPlayerBtn.GetText();
	local orders = Game.Orders;
	local myID = Game.Us.ID;
	if(declareon == "Select player...")then
		UI.Alert('You need to choose a player first');
	else
		table.insert(orders, WL.GameOrderCustom.Create(myID, "Declared war on " .. declareon, ""));
	end
	Game.Orders = orders;
end
function map(array, func)
	local new_array = {};
	local i = 1;
	for _,v in pairs(array) do
		new_array[i] = func(v);
		i = i + 1;
	end
	return new_array;
end
function PlayerButton(player)
	local name = player.DisplayName(nil, false);
	local ret = {};
	ret["text"] = name;
	ret["selected"] = function() 
		TargetPlayerBtn.SetText(name);
		TargetPlayerID = player.ID;
	end
	return ret;
end
function DeleteUI()
	--horz = UI.CreateHorizontalLayoutGroup(root);
	if(textelem ~= nil)then
		UI.Destroy(textelem);
		textelem = nil;
	end
	if(TargetPlayerBtn ~= nil)then
		UI.Destroy(TargetPlayerBtn);
		TargetPlayerBtn = nil;
	end
	if(commitbutton ~= nil)then
		UI.Destroy(commitbutton);
		commitbutton = nil;
	end
	if(openshopbutton ~= nil)then
		UI.Destroy(openshopbutton);
		openshopbutton = nil;
	end
	if(declarewarbutton ~= nil)then
		UI.Destroy(declarewarbutton);
		declarewarbutton = nil;
	end
	if(offerpeacebutton ~= nil)then
		UI.Destroy(offerpeacebutton);
		offerpeacebutton = nil;
	end
	if(offerallianzebutton ~= nil)then
		UI.Destroy(offerallianzebutton);
		offerallianzebutton = nil;
	end
	if(pendingrequestbutton ~= nil)then
		UI.Destroy(pendingrequestbutton);
		pendingrequestbutton = nil;
	end
end
function  tablelength(T)
	local count = 0;
	for _, elem in pairs(T)do
		count = count + 1;
	end
	return count;
end
