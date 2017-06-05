function Client_PresentMenuUI(rootParent, setMaxSize, setScrollable, game)
	horzobjlist = {};
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
		vert = UI.CreateVerticalLayoutGroup(rootParent);
		UI.CreateLabel(vert).SetText("You cannot use the Diplomacy game, cause you aren't in the game");
		return;
	end
  	horz = UI.CreateHorizontalLayoutGroup(root);
 	moneyobj = UI.CreateLabel(horz).SetText('Current Money: ' .. Mod.PlayerGameData.Money);
	mainmenu = UI.CreateButton(horz).SetText("Main Menu").SetOnClick(OpenMenu);
	vert = UI.CreateVerticalLayoutGroup(rootParent);
	OpenMenu(rootParent);
end
function OpenOfferPeace()
	DeleteUI();
	horzobjlist[0] = UI.CreateHorizontalLayoutGroup(root);
	textelem = UI.CreateLabel(horzobjlist[0]).SetText("Offer peace to: ");
	TargetPlayerBtn = UI.CreateButton(horzobjlist[0]).SetText("Select player...").SetOnClick(TargetPlayerClickedOfferPeace);
	horzobjlist[1] = UI.CreateHorizontalLayoutGroup(root);
	commitbutton = UI.CreateButton(horzobjlist[1]).SetText("Offer").SetOnClick(commitofferpeace);
end
function commitofferpeace()
	local offerto = TargetPlayerBtn.GetText();
	local myID = Game.Us.ID;
	local Preis = 0;
	if(offerto == "Select player...")then
		UI.Alert('You need to choose a player first');
	else
		local payload = {};
		payload.Message = "Peace";
		payload.TargetPlayerID = getplayerid(offerto,Game);
		payload.Preis = Preis;
		Game.SendGameCustomMessage("Sending request...", payload, function(returnvalue)
			UI.Alert(returnvalue.Message);
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
	openshopbutton = UI.CreateButton(vert).SetText("Shop").SetOnClick(Openshop);
 	--UI.CreateLabel(horz).SetText("Declare War");
	declarewarbutton = UI.CreateButton(vert).SetText("Declare War").SetOnClick(OpenDeclarWar);
	--UI.CreateLabel(horz).SetText("Offer Peace");
	offerpeacebutton = UI.CreateButton(vert).SetText("Offer Peace").SetOnClick(OpenOfferPeace);
	--UI.CreateLabel(horz).SetText("Offer Allianze");
	offerallianzebutton = UI.CreateButton(vert).SetText("Offer Alliance").SetOnClick(OpenOfferAlliance);
  	--UI.CreateLabel(horz).SetText("Pending Requests");
	pendingrequestbutton = UI.CreateButton(vert).SetText("Pending Requests").SetOnClick(OpenPendingRequests);
end
function OpenPendingRequests()
	DeleteUI();
	if(Mod.PlayerGameData.Peaceoffers~=nil)then
		local peacesplit = stringtotable(Mod.PlayerGameData.Peaceoffers);
		local num = 1;
		--for _,obj in pairs(peacesplit)do
		--	horz = UI.CreateHorizontalLayoutGroup(root);
		--	UI.CreateLabel(horz).SetText("Test " .. obj);
		--end
		RecentPlayerID={};
		AllEvilFuncs={};
		
		while(peacesplit[num] ~= nil and peacesplit[num+1] ~= nil)do
			RecentPlayerID[num]=tonumber(peacesplit[num]);
			horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
			UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("Peace Offer by " .. toname(tonumber(peacesplit[num]),Game));
			horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
			local requiredmoney = tonumber(peacesplit[num+1]);
			if(requiredmoney == 0)then
				UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("This Peace Offer is for free");
			else
				if(requiredmoney > 0)then
					UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("You need to pay " .. peacesplit[num+1] .. " Coins if you accept");
				else
					UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("He will pay you " .. peacesplit[num+1] .. " Coins if you accept");
				end
			end
			local mymoney = tonumber(Mod.PlayerGameData.Money);
			horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
			if(requiredmoney > mymoney)then
				UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("You haven't the money to accept this offer.");
			else
				
				AllEvilFuncs[num]=function() AcceptPeaceOffer(num); end;
				local button = UI.CreateButton(horzobjlist[tablelength(horzobjlist)-1]).SetText("Accept").SetOnClick(AllEvilFuncs[num]);
				
			end
			num = num +2;
		end
	end
end

function AcceptPeaceOffer(playerID)
	UI.Alert('Accept Peace Offer Test '..tostring(playerID));
end


function AcceptorDeny(knopf)
	UI.Alert(knopf.GetText());
end
function toname(playerid,game)
	for _,playerinfo in pairs(game.Game.Players)do
		if(playerid == playerinfo.ID)then
			return playerinfo.DisplayName(nil, false);
		end
	end
	return "Error. Please report to dabo1.";
end
function Openshop(rootParent)
	--DeleteUI();
end
function OpenDeclarWar()
	DeleteUI();
	horzobjlist[0] = UI.CreateHorizontalLayoutGroup(root);
	textelem = UI.CreateLabel(horzobjlist[0]).SetText("Declare war on: ");
	TargetPlayerBtn = UI.CreateButton(horzobjlist[0]).SetText("Select player...").SetOnClick(TargetPlayerClicked);
	horzobjlist[1] = UI.CreateHorizontalLayoutGroup(root);
	commitbutton = UI.CreateButton(horzobjlist[1]).SetText("Declare").SetOnClick(declare);
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
		table.insert(orders, WL.GameOrderCustom.Create(myID, "Declared war on " .. declareon, getplayerid(declareon,Game)));
	end
	Game.Orders = orders;
end
function getplayerid(playername,game)
	for _,playerinfo in pairs(game.Game.Players)do
		local name = playerinfo.DisplayName(nil, false);
		if(name == playername)then
			return playerinfo.ID;
		end
	end
	return 0;
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
	for _,horzobj in pairs(horzobjlist)do
		UI.Destroy(horzobj);
	end
	horzobjlist = {};
end
function  tablelength(T)
	local count = 0;
	for _, elem in pairs(T)do
		count = count + 1;
	end
	return count;
end
