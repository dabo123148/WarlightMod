require('History');
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
	oldermessagesbutton = nil;
	cancelallianzebutton = nil;
	Game = game;
	root = rootParent;
	setMaxSize(450, 350);
	if (game.Us == nil) then
		vert = UI.CreateVerticalLayoutGroup(rootParent);
		UI.CreateLabel(vert).SetText("You cannot use the Diplomacy Mod, cause you aren't in the game");
		return;
	end
	if(Mod.PlayerGameData == nil or Mod.PlayerGameData.Money == nil)then
		vert = UI.CreateVerticalLayoutGroup(rootParent);
		UI.CreateLabel(vert).SetText("You cannot use this menu in the distribution phase");
		return;
	end
  	horz = UI.CreateHorizontalLayoutGroup(root);
	mainmenu = UI.CreateButton(horz).SetText("Main Menu").SetOnClick(OpenMenu);
	vert = UI.CreateVerticalLayoutGroup(rootParent);
	OpenMenu(rootParent);
end
function OpenOfferPeace()
	DeleteUI();
	if(Game.Settings.CommerceGame)then
		horzobjlist[0] = UI.CreateHorizontalLayoutGroup(root);
		textelem = UI.CreateLabel(horzobjlist[0]).SetText("AIs won't pay you money");
	end
	horzobjlist[1] = UI.CreateHorizontalLayoutGroup(root);
	textelem = UI.CreateLabel(horzobjlist[1]).SetText("Offer peace to: ");
	TargetPlayerBtn = UI.CreateButton(horzobjlist[1]).SetText("Select player...").SetOnClick(TargetPlayerClickedOfferPeace);
	if(Game.Settings.CommerceGame)then
		horzobjlist[3] = UI.CreateHorizontalLayoutGroup(root);
		UI.CreateLabel(horzobjlist[3]).SetText('How much money do you want for peace');
		Moneyyougetforpeace = UI.CreateNumberInputField(horzobjlist[3]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(0);
	end
	horzobjlist[4] = UI.CreateHorizontalLayoutGroup(root);
	UI.CreateLabel(horzobjlist[4]).SetText('How many turns should you both be not able to declare war on each other');
	peaceduration = UI.CreateNumberInputField(horzobjlist[4]).SetSliderMinValue(0).SetSliderMaxValue(10).SetValue(1);
	horzobjlist[5] = UI.CreateHorizontalLayoutGroup(root);
	commitbutton = UI.CreateButton(horzobjlist[5]).SetText("Offer").SetOnClick(commitofferpeace);
end
function commitofferpeace()
	local offerto = TargetPlayerBtn.GetText();
	local Preis = 0;
	local duration = peaceduration.GetValue();
	if(Moneyyougetforpeace ~= nil)then
		Preis = Moneyyougetforpeace.GetValue();
		if(Preis < 0)then
			UI.Alert("Price can't be negative");
			return;
		end
	end
	if(offerto == "Select player...")then
		UI.Alert('You need to choose a player first');
	else
		if(duration < 1)then
			UI.Alert('Duration must be at least 1 Turn');
		else
			if(duration > 10)then
				UI.Alert('To prevent this game from getting stuck, peace can not last longer than 10 turns');
			else
				local payload = {};
				payload.Message = "Peace";
				payload.TargetPlayerID = getplayerid(offerto,Game);
				payload.Preis = Preis;
				payload.duration = duration;
				if(game.Players[payload.TargetPlayerID].IsAI == true and Price ~= 0)then
					UI.Alert("AIs don't pay money");
					return;
				end
				Game.SendGameCustomMessage("Sending request...", payload, function(returnvalue)
					UI.Alert(returnvalue.Message);
					end);
			end
		end
	end
end
function TargetPlayerClickedOfferPeace()
	if(Mod.PublicGameData.War ~= nil and Mod.PublicGameData.War[Game.Us.ID] ~= nil)then--maybe unnessacary
		local options = {};
		for _,playerinstanze in pairs(Game.Game.PlayingPlayers)do
			for _,with in pairs(Mod.PublicGameData.War[Game.Us.ID])do
				if(tostring(with) == tostring(playerinstanze.ID))then
					table.insert(options,playerinstanze);
				end
			end
		end
		options = map(options, PlayerButton);
		UI.PromptFromList("Select the player you'd like to offer the peace to", options);
	end
end
function OpenMenu()
	DeleteUI();
	openshopbutton = UI.CreateButton(vert).SetText("Trading").SetOnClick(Openshop);
	declarewarbutton = UI.CreateButton(vert).SetText("Declare War").SetOnClick(OpenDeclarWar);
	offerpeacebutton = UI.CreateButton(vert).SetText("Offer Peace").SetOnClick(OpenOfferPeace);
	offerallianzebutton = UI.CreateButton(vert).SetText("Offer Alliance").SetOnClick(OpenOfferAlliance);
	cancelallianzebutton = UI.CreateButton(vert).SetText("Cancel Alliance").SetOnClick(OpenCancelAlliance);
	pendingrequestbutton = UI.CreateButton(vert).SetText("Pending Requests").SetOnClick(OpenPendingRequests);
	oldermessagesbutton =  UI.CreateButton(vert).SetText("Mod History").SetOnClick(function()
		if(tablelength(Mod.PlayerGameData.Nachrichten)~=0)then
			ShowHistory(Mod.PlayerGameData.Nachrichten,Game,"",true);
		else
			UI.Alert("There is currently no history for this Mod");
		end
	end);
	horzobjlist = {};
	horzobjlist[0] = UI.CreateHorizontalLayoutGroup(root);
	UI.CreateLabel(horzobjlist[0]).SetText("Your current diplomacy:");
	horzobjlist[1] = UI.CreateHorizontalLayoutGroup(root);
	horzobjlist[2] = UI.CreateVerticalLayoutGroup(root);
	local haswar = false;
	for _,with in pairs(Mod.PublicGameData.War[Game.Us.ID])do
		if(Game.Game.PlayingPlayers[with] ~= null)then
			UI.CreateLabel(horzobjlist[2]).SetText("-" .. toname(with,Game));
			haswar = true;
		end
	end
	if(haswar == false)then
		UI.Destroy(horzobjlist[2]);
		horzobjlist[2] = nil;
		UI.CreateLabel(horzobjlist[1]).SetText("You are currently in war with no one.");
		offerpeacebutton.SetInteractable(false);
	else
		UI.CreateLabel(horzobjlist[1]).SetText("You are currently in war with the following player:");
		horzobjlist[2] = UI.CreateVerticalLayoutGroup(root);
		offerpeacebutton.SetInteractable(true);
	end
	horzobjlist[3] = UI.CreateHorizontalLayoutGroup(root);
	if(tablelength(Game.Game.Players)-tablelength(Mod.PublicGameData.War[Game.Us.ID])-tablelength(Mod.PlayerGameData.Allianzen)~=0)then
		UI.CreateLabel(horzobjlist[3]).SetText("You are currently in peace with the following player:");
		horzobjlist[4] = UI.CreateVerticalLayoutGroup(root);
		declarewarbutton.SetInteractable(true);
		offerallianzebutton.SetInteractable(true);
	else
		UI.CreateLabel(horzobjlist[3]).SetText("You are currently in peace with no one.");
		declarewarbutton.SetInteractable(false);
		offerallianzebutton.SetInteractable(false);
	end
	for _,pd in pairs(Game.Game.PlayingPlayers)do
		if(pd.ID ~= Game.Us.ID)then
			local match2 = false;
			for _,with in pairs(Mod.PublicGameData.War[Game.Us.ID])do
				if(with == pd.ID)then
					match2 = true
				end
			end
			for _,with in pairs(Mod.PlayerGameData.Allianzen)do
				if(with == pd.ID)then
					match2 = true
				end
			end
			if(match2 == false)then
				UI.CreateLabel(horzobjlist[4]).SetText("-" .. toname(pd.ID,Game));
				match = true;
			end
		end
	end
	horzobjlist[5] = UI.CreateHorizontalLayoutGroup(root);
	horzobjlist[6] = UI.CreateVerticalLayoutGroup(root);
	local hasalliance = false;
	for _,with in pairs(Mod.PlayerGameData.Allianzen)do
		if(Game.Game.PlayingPlayers[with] ~= null)then
			UI.CreateLabel(horzobjlist[6]).SetText("-" .. toname(with,Game));
			hasalliance = true;
		end
	end
	if(hasalliance)then
		UI.CreateLabel(horzobjlist[5]).SetText("You are currently allied with the following player:");
		cancelallianzebutton.SetInteractable(true);
	else
		UI.Destroy(horzobjlist[6]);
		horzobjlist[6] = nil;
		UI.CreateLabel(horzobjlist[5]).SetText("You are currently allied with no one.");
		cancelallianzebutton.SetInteractable(false);
	end
end
function OpenCancelAlliance()
	DeleteUI();
	horzobjlist[0] = UI.CreateHorizontalLayoutGroup(root);
	textelem = UI.CreateLabel(horzobjlist[0]).SetText("Cancel alliance with: ");
	TargetPlayerBtn = UI.CreateButton(horzobjlist[0]).SetText("Select player...").SetOnClick(TargetPlayerSelectCancelAlliance);
	horzobjlist[1] = UI.CreateHorizontalLayoutGroup(root);
	commitbutton = UI.CreateButton(horzobjlist[1]).SetText("Offer").SetOnClick(function()
			if(TargetPlayerBtn.GetText() == "Select player...")then
				UI.Alert('You need to choose a player first');
				return;
			end
			local cancelorder = WL.GameOrderCustom.Create(Game.Us.ID, "Cancel Alliance with " .. TargetPlayerBtn.GetText(), getplayerid(TargetPlayerBtn.GetText() ,Game));
			local orders = Game.Orders;
			if(Game.Us.HasCommittedOrders == true)then
				UI.Alert("You need to uncommit first");
				return;
			end
			table.insert(orders, cancelorder);
			Game.Orders=orders;
		end);
end
function OpenOfferAlliance()
	DeleteUI();
	horzobjlist[0] = UI.CreateHorizontalLayoutGroup(root);
	textelem = UI.CreateLabel(horzobjlist[0]).SetText("Offer Allianze To: ");
	TargetPlayerBtn = UI.CreateButton(horzobjlist[0]).SetText("Select player...").SetOnClick(TargetPlayerClickedOfferAllianze);
	horzobjlist[1] = UI.CreateHorizontalLayoutGroup(root);
	commitbutton = UI.CreateButton(horzobjlist[1]).SetText("Offer").SetOnClick(function()
			if(TargetPlayerBtn.GetText() == "Select player...")then
				UI.Alert('You need to choose a player first');
				return;
			end
			local payload = {};
			payload.Message = "Offer Allianze";
			payload.TargetPlayerID = getplayerid(TargetPlayerBtn.GetText() ,Game);
			Game.SendGameCustomMessage("Offering...", payload, function(returnvalue)	UI.Alert(returnvalue.Message); end);
		end);
end
function TargetPlayerSelectCancelAlliance()
	local options = {};
	local match2 = false;
	for _,playerinstanze in pairs(Game.Game.PlayingPlayers)do
		for _,with in pairs(Mod.PlayerGameData.Allianzen)do
			if(with == playerinstanze.ID)then
				table.insert(options,playerinstanze);
				match2 = true;
			end
		end
	end
	if(match2 == false)then
		UI.Alert('You are not able to ally to anyone at the moment');
	else
		options = map(options, PlayerButton);
		UI.PromptFromList("Select the player you'd like to cancel the alliance with", options);
	end
end
function TargetPlayerClickedOfferAllianze()
	local options = {};
	local match2 = false;
	for _,playerinstanze in pairs(Game.Game.PlayingPlayers)do
		local match = false;
		for _,with in pairs(Mod.PublicGameData.War[Game.Us.ID])do
			if(with == playerinstanze.ID)then
				match=true;
			end
		end
		for _,with in pairs(Mod.PlayerGameData.Allianzen)do
			if(with == playerinstanze.ID)then
				match=true;
			end
		end
		if(match == false)then
			if(playerinstanze.IsAI == false and playerinstanze.ID ~= Game.Us.ID)then
				match2 = true;
				table.insert(options,playerinstanze);
			end
		end
	end
	if(match2 == false)then
		UI.Alert('You are not able to ally to anyone at the moment');
	else
		options = map(options, PlayerButton);
		UI.PromptFromList("Select the player you'd like to offer an allianze to", options);
	end
end
function OpenPendingRequests()
	DeleteUI();
	horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
	UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("Peace Offers",Game);
end

function toname(playerid,game)
	return game.Game.Players[tonumber(playerid)].DisplayName(nil, false);
end
function Openshop(rootParent)
	DeleteUI();
	AllFuncs={};
	if(Game.Settings.CommerceGame)then
		--Gifting Money
	end
	--Selling Territories
end
function getterritoryid(name)
	for _,terr in pairs(Game.Map.Territories)do
		if(terr.Name .. "(ID:" .. terr.ID .. ")" == name)then
			return terr.ID;
		end
	end
	UI.Alert('Territory could not be found. Please report this to dabo1');
	return 0;
end
function OpenDeclarWar()
	DeleteUI();
	horzobjlist[0] = UI.CreateHorizontalLayoutGroup(root);
	textelem = UI.CreateLabel(horzobjlist[0]).SetText("Declare war on: ");
	TargetPlayerBtn = UI.CreateButton(horzobjlist[0]).SetText("Select player...").SetOnClick(TargetPlayerClicked);
	horzobjlist[1] = UI.CreateHorizontalLayoutGroup(root);
	commitbutton = UI.CreateButton(horzobjlist[1]).SetText("Declare").SetOnClick(declare);
end
function TargetPlayerClicked()
	local options = {};
	for _,playerinstanze in pairs(Game.Game.PlayingPlayers)do
		local Match = false;
		for _,with in pairs(Mod.PublicGameData.War[Game.Us.ID])do
			if(with == playerinstanze.ID)then
				Match = true;
			end
		end
		for _,with in pairs(Mod.PlayerGameData.Allianzen)do
			if(with == playerinstanze.ID)then
				Match = true;
			end
		end
		if(Match == false)then
			if(playerinstanze.ID ~= Game.Us.ID)then
				table.insert(options,playerinstanze);
			end
		end
	end
	options = map(options, PlayerButton);
	UI.PromptFromList("Select the player you'd like to declare war on", options);
end
function TerritoryButtonCustom(terr,knopf)
	local name = terr.Name .. "(ID:" .. terr.ID .. ")";
	local ret = {};
	ret["text"] = name;
	ret["selected"] = function() 
		knopf.SetText(name);
	end
	return ret;
end
function declare()
	local declareon = TargetPlayerBtn.GetText();
	local orders = Game.Orders;
	local myID = Game.Us.ID;
	if(declareon == "Select player...")then
		UI.Alert('You need to choose a player first');
		return;
	end
	if(Game.Us.HasCommittedOrders == true)then
		UI.Alert("You need to uncommit first");
		return;
	end
	table.insert(orders, WL.GameOrderCustom.Create(myID, "Declared war on " .. declareon, getplayerid(declareon,Game)));
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
function zusammen(array, func,knopf)
	local new_array = {};
	local i = 1;
	for _,v in pairs(array) do
		new_array[i] = func(v,knopf);
		i = i + 1;
	end
	return new_array;
end
function PlayerButtonCustom(player,knopf)
	local ret = {};
	ret["text"] = player;
	ret["selected"] = function() 
		knopf.SetText(player);
	end
	return ret;
end
function PlayerButton(player)
	local name = player.DisplayName(nil, false);
	local ret = {};
	ret["text"] = name;
	ret["selected"] = function() 
		TargetPlayerBtn.SetText(name);
	end
	return ret;
end
function DeleteUI()
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
	if(cancelallianzebutton ~= nil)then
		UI.Destroy(cancelallianzebutton);
		cancelallianzebutton = nil;
	end
	if(oldermessagesbutton ~= nil)then
		UI.Destroy(oldermessagesbutton);
		oldermessagesbutton = nil;
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
