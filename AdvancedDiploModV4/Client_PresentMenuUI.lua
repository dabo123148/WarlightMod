require('History');
function Client_PresentMenuUI(rootParent, setMaxSize, setScrollable, game)
	showedreturnmessage = true;
	horzobjlist = {};
	TargetPlayerBtn = nil;
	declarebutton=nil;
	declarewarbutton=nil;
	textelem=nil;
	commitbutton =nil;
	offerpeacebutton = nil;
	offerallianzebutton = nil;
	pendingrequestbutton = nil;
	publichistorybutton = nil;
	privatehistorybutton = nil;
	cancelallianzebutton = nil;
	SelectedData = {};
	Game = game;
	root = rootParent;
	setMaxSize(450, 350);
	if(game.Us == nil) then
		vert = UI.CreateVerticalLayoutGroup(rootParent);
		UI.CreateLabel(vert).SetText("You cannot use the Diplomacy Mod, cause you aren't in the game");
		return;
	end
	horz = UI.CreateHorizontalLayoutGroup(root);
	if(game.Game.PlayingPlayers[game.Us.ID] == nil)then
		UI.CreateLabel(horz).SetText("You have been eliminated, so you are no longer able to interact with the mod");
		return;
	end
	mainmenu = UI.CreateButton(horz).SetText("Main Menu").SetOnClick(OpenMenu);
	deleteme =  UI.CreateButton(horz).SetText("Test").SetOnClick(function()
		WL.SendGameCustomMessage.Create(Game.Us.ID, "Test", function(returnvalue) showedreturnmessage = false; UI.Alert("TEST") end);
	end);
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
	if(offerto == "Select player...")then
		UI.Alert('You need to choose a player first');
	else
		local payload = {};
		payload.Message = "Peace";
		payload.TargetPlayerID = SelectedData[1];
		Game.SendGameCustomMessage("Sending request...", payload, function(returnvalue)
			showedreturnmessage = false;
			UI.Alert(returnvalue.Message);
			end);
		TargetPlayerBtn.SetText("Select player...");
	end
end
function TargetPlayerClickedOfferPeace()
	if(Mod.PublicGameData.War ~= nil and Mod.PublicGameData.War[Game.Us.ID] ~= nil)then--maybe unnessacary if(code in if still required)
		local options = {};
		for _,playerinstanze in pairs(Game.Game.PlayingPlayers)do
			for _,with in pairs(Mod.PublicGameData.War[Game.Us.ID])do
				if(tostring(with) == tostring(playerinstanze.ID))then
					table.insert(options,playerinstanze);
				end
			end
		end
		options = zusammen(options,PlayerButtonCustom,TargetPlayerBtn,1);
		UI.PromptFromList("Select the player you'd like to offer the peace to", options);
	end
end
function OpenMenu()
	DeleteUI();
	declarewarbutton = UI.CreateButton(vert).SetText("Declare War").SetOnClick(OpenDeclarWar);
	offerpeacebutton = UI.CreateButton(vert).SetText("Offer Peace").SetOnClick(OpenOfferPeace);
	offerallianzebutton = UI.CreateButton(vert).SetText("Offer Alliance").SetOnClick(OpenOfferAlliance);
	cancelallianzebutton = UI.CreateButton(vert).SetText("Cancel Alliance").SetOnClick(OpenCancelAlliance);
	pendingrequestbutton = UI.CreateButton(vert).SetText("Pending Requests").SetOnClick(OpenPendingRequests);
	publichistorybutton =  UI.CreateButton(vert).SetText("Public Mod History").SetOnClick(function()
		ShowHistory(Mod.PublicGameData.History,Game,"showmessage");
	end);
	privatehistorybutton =  UI.CreateButton(vert).SetText("Private Mod History").SetOnClick(function()
		ShowHistory(Mod.PlayerGameData.PrivateHistory,Game,"showmessage");
	end);
	--Disableing buttons that have no function due to the diplomacy and showing the diplomacy
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
		offerpeacebutton.SetInteractable(true);
	end
	horzobjlist[3] = UI.CreateHorizontalLayoutGroup(root);
	horzobjlist[4] = UI.CreateVerticalLayoutGroup(root);
	local foundpossibleally = false;
	local haspeace = false;
	for _,pd in pairs(Game.Game.PlayingPlayers)do
		if(pd.ID ~= Game.Us.ID)then
			local match2 = false;
			for _,with in pairs(Mod.PublicGameData.War[Game.Us.ID])do
				if(with == pd.ID)then
					match2 = true;
				end
			end
			for _,with in pairs(Mod.PlayerGameData.Allianzen)do
				if(with == pd.ID)then
					match2 = true;
				end
			end
			if(match2 == false)then
				UI.CreateLabel(horzobjlist[4]).SetText("-" .. toname(pd.ID,Game));
				match = true;
				haspeace=true;
				if(pd.IsAI == false)then
					foundpossibleally=true;
				end
			end
		end
	end
	if(tablelength(Mod.PlayerGameData.Peaceoffers) == 0 and tablelength(Mod.PlayerGameData.AllyOffers)==0)then
		print(tablelength(Mod.PlayerGameData.Peaceoffers) .. " " .. tablelength(Mod.PlayerGameData.AllyOffers));
		pendingrequestbutton.SetInteractable(false);
	end
	if(haspeace)then
		UI.CreateLabel(horzobjlist[3]).SetText("You are currently in peace with the following player:");
		declarewarbutton.SetInteractable(true);
		offerallianzebutton.SetInteractable(true);
	else
		UI.CreateLabel(horzobjlist[3]).SetText("You are currently in peace with no one.");
		declarewarbutton.SetInteractable(false);
		offerallianzebutton.SetInteractable(false);
		UI.Destroy(horzobjlist[4]);
		horzobjlist[4] = nil;
	end
	if(foundpossibleally == false)then
		offerallianzebutton.SetInteractable(false);
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
	commitbutton = UI.CreateButton(horzobjlist[1]).SetText("Remove").SetOnClick(function()
			if(TargetPlayerBtn.GetText() == "Select player...")then
				UI.Alert('You need to choose a player first');
				return;
			end
			local cancelorder = WL.GameOrderCustom.Create(Game.Us.ID, "Cancel Alliance with " .. TargetPlayerBtn.GetText(), SelectedData[1]);
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
			payload.TargetPlayerID = SelectedData[1];
			Game.SendGameCustomMessage("Offering...", payload, function(returnvalue)	showedreturnmessage= false;UI.Alert(returnvalue.Message); end);
		end);
end
function TargetPlayerSelectCancelAlliance()
	local options = {};
	local match = false;
	for _,playerinstanze in pairs(Game.Game.PlayingPlayers)do
		for _,with in pairs(Mod.PlayerGameData.Allianzen)do
			if(with == playerinstanze.ID)then
				table.insert(options,playerinstanze);
				match = true;
			end
		end
	end
	if(match == false)then
		UI.Alert('You are not able to ally to anyone at the moment');
	else
		options = zusammen(options,PlayerButtonCustom,TargetPlayerBtn,1);
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
		options = zusammen(options,PlayerButtonCustom,TargetPlayerBtn,1);
		UI.PromptFromList("Select the player you'd like to offer an allianze to", options);
	end
end
function OpenPendingRequests()
	DeleteUI();
	local haspeaceoffer = false;
	local hasallyoffer = false;
	if(haspeaceoffer == true)then
		ShowPeaceOffers();
	end
	if(hasallyoffer == true)then
		ShowTerritorySellOffers();
	end
	if(haspeaceoffer == false)then
		ShowPeaceOffers();
	end
	if(hasallyoffer == false)then
		ShowAllyOffers();
	end
end
function ShowPeaceOffers()
	horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
	UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("Peace Offers");
	local hasoffer =false;
	for _,offer in pairs(Mod.PlayerGameData.Peaceoffers)do
		hasoffer = true;
		horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
		UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText(toname(offer.Offerby,Game) .. " offers you peace");
		horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
		button = UI.CreateButton(horzobjlist[tablelength(horzobjlist)-1]).SetText("Deny");
		local onclick=function()
			local payload = {};
			payload.Message = "Decline Peace";
			payload.Spieler = offer.Offerby;
			AcceptPeaceOffer(payload);
			end;
		button.SetOnClick(onclick);
		button = UI.CreateButton(horzobjlist[tablelength(horzobjlist)-1]).SetText("Accept");
		local onclick2=function()
			local payload = {};
			payload.Message = "Accept Peace";
			payload.Spieler = offer.Offerby;
			AcceptPeaceOffer(payload);
			end;
		button.SetOnClick(onclick2);
	end
	if(hasoffer == false)then
		horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
		UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("You have no peace offers");
	end
end
function ShowAllyOffers()
	horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
	UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("Ally Offers");
	local hasoffer =false;
	for _,offer in pairs(Mod.PlayerGameData.AllyOffers)do
		hasoffer = true;
		horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
		UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText(toname(offer.OfferedBy,Game) .. " offers you an alliance");
		horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
		button = UI.CreateButton(horzobjlist[tablelength(horzobjlist)-1]).SetText("Deny");
		local onclick=function()
			local payload = {};
			payload.Message = "Deny Allianze";
			payload.OfferedBy = offer.OfferedBy;
			Game.SendGameCustomMessage("Sending data...", payload, function(returnvalue)	showedreturnmessage=false;UI.Alert(returnvalue.Message); end);
			OpenPendingRequests();
			end;
		button.SetOnClick(onclick);
		button = UI.CreateButton(horzobjlist[tablelength(horzobjlist)-1]).SetText("Accept");
		local onclick2=function()
			local payload = {};
			payload.Message = "Accept Allianze";
			payload.OfferedBy = offer.OfferedBy;
			Game.SendGameCustomMessage("Sending data...", payload, function(returnvalue)	showedreturnmessage=false;UI.Alert(returnvalue.Message); end);
			OpenPendingRequests();
			end;
		button.SetOnClick(onclick2);
	end
	if(hasoffer == false)then
		horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
		UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("You have no alliance offer");
	end
end
function AcceptPeaceOffer(data)
	local payload = {};
	payload.Message = data.Message;
	payload.TargetPlayerID = data.Spieler;
	Game.SendGameCustomMessage("Sending data...", payload, function(returnvalue)	
		showedreturnmessage = false;
		if(returnvalue.Message == 1)then
			UI.Alert("The Peace Offer doesn't exist any longer");
		else
			if(data.Message == "Decline Peace")then
				UI.Alert('You declined ' .. toname(data.Spieler,Game) .. " Peace Offer");
			else
				UI.Alert("You are now again in peace with " .. toname(data.Spieler,Game));
			end
		end
	end);
	OpenPendingRequests();
end
function toname(playerid,game)
	return game.Game.Players[tonumber(playerid)].DisplayName(nil, false);
end
function OpenDeclarWar()
	DeleteUI();
	horzobjlist[0] = UI.CreateHorizontalLayoutGroup(root);
	textelem = UI.CreateLabel(horzobjlist[0]).SetText("Declare war on: ");
	TargetPlayerBtn = UI.CreateButton(horzobjlist[0]).SetText("Select player...").SetOnClick(TargetPlayerClickedDeclareWar);
	horzobjlist[1] = UI.CreateHorizontalLayoutGroup(root);
	commitbutton = UI.CreateButton(horzobjlist[1]).SetText("Declare").SetOnClick(declare);
end
function TargetPlayerClickedDeclareWar()
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
			--don't add, if already declare order existing
				if(ContainsDeclareWarOrder(playerinstanze.ID) == false)then
					table.insert(options,playerinstanze);
				end
			end
		end
	end
	options = zusammen(options,PlayerButtonCustom,TargetPlayerBtn,1);
	UI.PromptFromList("Select the player you'd like to declare war on", options);
end
function ContainsDeclareWarOrder(playerid)
	local gameorders = Game.Orders;
	for _,order in pairs(gameorders)do
		if(order.proxyType == "GameOrderCustom")then
			if(order.Payload == tostring(playerid))then
				return true;
			end
		end
	end
	return false;
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
	table.insert(orders, WL.GameOrderCustom.Create(myID, "Declared war on " .. declareon, SelectedData[1]));
	Game.Orders = orders;
	TargetPlayerBtn.SetText("Select player...");
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
function zusammen(array, func,knopf,knopfid)
	local new_array = {};
	local i = 1;
	for _,v in pairs(array) do
		new_array[i] = func(v,knopf,knopfid);
		i = i + 1;
	end
	return new_array;
end
function PlayerButtonCustom(player,knopf,knopfid)
	local ret = {};
	ret["text"] = toname(player.ID,Game);
	ret["selected"] = function() 
		SelectedData[knopfid] = player.ID;
		knopf.SetText(ret["text"]);
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
	if(publichistorybutton ~= nil)then
		UI.Destroy(publichistorybutton);
		publichistorybutton = nil;
	end
	if(privatehistorybutton ~= nil)then
		UI.Destroy(privatehistorybutton);
		privatehistorybutton = nil;
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
