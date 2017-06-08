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
	textelem = UI.CreateLabel(horzobjlist[0]).SetText("AIs won't take your money or pay you money");
	horzobjlist[1] = UI.CreateHorizontalLayoutGroup(root);
	textelem = UI.CreateLabel(horzobjlist[1]).SetText("Offer peace to: ");
	TargetPlayerBtn = UI.CreateButton(horzobjlist[1]).SetText("Select player...").SetOnClick(TargetPlayerClickedOfferPeace);
	horzobjlist[2] = UI.CreateHorizontalLayoutGroup(root);
	UI.CreateLabel(horzobjlist[2]).SetText('How much money are you willing to pay for peace');
	Moneyyoupayforpeace = UI.CreateNumberInputField(horzobjlist[2]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(0);
	horzobjlist[3] = UI.CreateHorizontalLayoutGroup(root);
	UI.CreateLabel(horzobjlist[3]).SetText('How much money do you want for peace');
	Moneyyougetforpeace = UI.CreateNumberInputField(horzobjlist[3]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(0);
	horzobjlist[4] = UI.CreateHorizontalLayoutGroup(root);
	UI.CreateLabel(horzobjlist[4]).SetText('How many turns do you want to last your peace');
	peaceduration = UI.CreateNumberInputField(horzobjlist[4]).SetSliderMinValue(0).SetSliderMaxValue(10).SetValue(1);
	horzobjlist[5] = UI.CreateHorizontalLayoutGroup(root);
	commitbutton = UI.CreateButton(horzobjlist[5]).SetText("Offer").SetOnClick(commitofferpeace);
end
function commitofferpeace()
	local offerto = TargetPlayerBtn.GetText();
	local Preis = 0;
	local duration = peaceduration.GetValue();
	if(Moneyyoupayforpeace.GetValue() ~= 0)then
		Preis = -Moneyyoupayforpeace.GetValue();
	else
		Preis = Moneyyougetforpeace.GetValue();
	end
	if(offerto == "Select player...")then
		UI.Alert('You need to choose a player first');
	else
		if(Moneyyoupayforpeace.GetValue() ~= 0 and Moneyyougetforpeace.GetValue() ~= 0)then
			UI.Alert('You cannot want money and pay money for peace at the same time');
		else
			if(Moneyyoupayforpeace.GetValue() < 0 or Moneyyougetforpeace.GetValue() < 0)then
				UI.Alert('Money can not be negative');
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
						Game.SendGameCustomMessage("Sending request...", payload, function(returnvalue)
							UI.Alert(returnvalue.Message);
							end);
					end
				end
			end
		end
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
	oldermessagesbutton =  UI.CreateButton(vert).SetText("Mod History").SetOnClick(function()
		if(Mod.PlayerGameData.Nachrichten ~=nil)then
			local Nachricht = " ";
			local Nachrichtensplit = stringtotable(Mod.PlayerGameData.Nachrichten);
			local num = 1;
			while(Nachrichtensplit[num] ~= nil and Nachrichtensplit[num+1] ~= nil and Nachrichtensplit[num+2] ~= nil and Nachrichtensplit[num+3] ~= nil)do
				if(Nachrichtensplit[num+1] == "0")then
					Nachricht = Nachricht .. "\n" .. toname(tonumber(Nachrichtensplit[num]),Game) .. " declared war on " .. toname(tonumber(Nachrichtensplit[num+3]),Game) .. " in turn " .. Nachrichtensplit[num+2];
				end
				if(Nachrichtensplit[num+1] == "1")then
					Nachricht = Nachricht .. "\n" .. toname(tonumber(Nachrichtensplit[num]),Game) .. " accepted the peace offer by " .. toname(tonumber(Nachrichtensplit[num+3]),Game) .. " until turn " .. Nachrichtensplit[num+2];
				end
				num = num + 4;
			end
			UI.Alert(Nachricht);
		else
			UI.Alert("There is currently no history for this Mod");
		end
	end);
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
		
		while(peacesplit[num] ~= nil and peacesplit[num+1] ~= nil and peacesplit[num+1] ~= "")do
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
					UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("He will pay you " .. peacesplit[num+1]*-1 .. " Coins if you accept");
				end
			end
			horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
			UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("The Peace will last for " .. toname(tonumber(peacesplit[num+2]),Game) .. " Turns. After that you can declare again war on him.");
			local mymoney = tonumber(Mod.PlayerGameData.Money);
			horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
			if(requiredmoney > mymoney)then
				UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("You haven't the money to accept this offer.");
			else
				local button = UI.CreateButton(horzobjlist[tablelength(horzobjlist)-1]).SetText("Accept");
				local locNum= {};
				locNum.Spieler = tonumber(peacesplit[num]);
				locNum.Message = "Accept Peace";
				--= {Knopf=button,spieler=tonumber(peacesplit[num])};
				AllEvilFuncs[num]=function() local InNum = locNum; AcceptPeaceOffer(InNum); end;
				button.SetOnClick(AllEvilFuncs[num]);
				local buttonzwei = UI.CreateButton(horzobjlist[tablelength(horzobjlist)-1]).SetText("Deny");
				local locNumzwei= {};
				locNumzwei.Spieler = tonumber(peacesplit[num]);
				locNumzwei.Message = "Decline Peace";
				AllEvilFuncs[num+1]=function() local InNumzwei = locNumzwei; AcceptPeaceOffer(InNumzwei); end;
				buttonzwei.SetOnClick(AllEvilFuncs[num+1]);
				
			end
			num = num +2;
		end
	end
end

function AcceptPeaceOffer(data)
	local payload = {};
	payload.Message = data.Message;
	payload.TargetPlayerID = data.Spieler;
	Game.SendGameCustomMessage("Sending data...", payload, function(returnvalue)	
				if(returnvalue.Message == 0)then
					UI.Alert("I am sorry, but " .. toname(data.Spieler,Game) .. " hasn't the money to pay you");
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


function AcceptorDeny(knopf)
	UI.Alert(knopf.GetText());
end
function toname(playerid,game)
	return game.Game.Players[playerid].DisplayName(nil, false);
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
	moneyobj.SetText('Current Money: ' .. Mod.PlayerGameData.Money);
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
