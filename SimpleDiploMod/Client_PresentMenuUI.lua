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
	if(Mod.PlayerGameData == nil or Mod.PlayerGameData.Money == nil)then
		vert = UI.CreateVerticalLayoutGroup(rootParent);
		UI.CreateLabel(vert).SetText("You cannot use this menu in the distribution phase");
		return;
	end
  	horz = UI.CreateHorizontalLayoutGroup(root);
	if(Mod.Settings.StartMoney ~= 0 or Mod.Settings.MoneyPerTurn ~= 0 or Mod.Settings.MoneyPerKilledArmy ~= 0 or Mod.Settings.MoneyPerCapturedTerritory ~= 0 or Mod.Settings.MoneyPerCapturedBonus ~= 0)then
 		moneyobj = UI.CreateLabel(horz).SetText('Current Money: ' .. Mod.PlayerGameData.Money);
	else
		moneyobj = UI.CreateLabel(horz).SetText('The money system is disabled');
	end
	mainmenu = UI.CreateButton(horz).SetText("Main Menu").SetOnClick(OpenMenu);
	vert = UI.CreateVerticalLayoutGroup(rootParent);
	OpenMenu(rootParent);
end
function OpenOfferPeace()
	DeleteUI();
	if(Mod.Settings.StartMoney ~= 0 or Mod.Settings.MoneyPerTurn ~= 0 or Mod.Settings.MoneyPerKilledArmy ~= 0 or Mod.Settings.MoneyPerCapturedTerritory ~= 0 or Mod.Settings.MoneyPerCapturedBonus ~= 0)then
		horzobjlist[0] = UI.CreateHorizontalLayoutGroup(root);
		textelem = UI.CreateLabel(horzobjlist[0]).SetText("AIs won't take your money or pay you money");
	end
	horzobjlist[1] = UI.CreateHorizontalLayoutGroup(root);
	textelem = UI.CreateLabel(horzobjlist[1]).SetText("Offer peace to: ");
	TargetPlayerBtn = UI.CreateButton(horzobjlist[1]).SetText("Select player...").SetOnClick(TargetPlayerClickedOfferPeace);
	if(Mod.Settings.StartMoney ~= 0 or Mod.Settings.MoneyPerTurn ~= 0 or Mod.Settings.MoneyPerKilledArmy ~= 0 or Mod.Settings.MoneyPerCapturedTerritory ~= 0 or Mod.Settings.MoneyPerCapturedBonus ~= 0)then
		horzobjlist[2] = UI.CreateHorizontalLayoutGroup(root);
		UI.CreateLabel(horzobjlist[2]).SetText('How much money are you willing to pay for peace');
		Moneyyoupayforpeace = UI.CreateNumberInputField(horzobjlist[2]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(0);
		horzobjlist[3] = UI.CreateHorizontalLayoutGroup(root);
		UI.CreateLabel(horzobjlist[3]).SetText('How much money do you want for peace');
		Moneyyougetforpeace = UI.CreateNumberInputField(horzobjlist[3]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(0);
	end
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
	if(Moneyyoupayforpeace ~= nil)then
		if(Moneyyoupayforpeace.GetValue() ~= 0)then
			Preis = -Moneyyoupayforpeace.GetValue();
		else
			Preis = Moneyyougetforpeace.GetValue();
		end
		if(Moneyyoupayforpeace.GetValue() ~= 0 and Moneyyougetforpeace.GetValue() ~= 0)then
			UI.Alert('You cannot want money and pay money for peace at the same time');
			return;
		end
		if(Moneyyoupayforpeace.GetValue() < 0 or Moneyyougetforpeace.GetValue() < 0)then
			UI.Alert('Money can not be negative');
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
				Game.SendGameCustomMessage("Sending request...", payload, function(returnvalue)
					UI.Alert(returnvalue.Message);
					end);
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
	openshopbutton = UI.CreateButton(vert).SetText("Trading").SetOnClick(Openshop);
	declarewarbutton = UI.CreateButton(vert).SetText("Declare War").SetOnClick(OpenDeclarWar);
	offerpeacebutton = UI.CreateButton(vert).SetText("Offer Peace").SetOnClick(OpenOfferPeace);
	offerallianzebutton = UI.CreateButton(vert).SetText("Offer Alliance - not implemented").SetOnClick(OpenOfferAlliance);
	pendingrequestbutton = UI.CreateButton(vert).SetText("Pending Requests").SetOnClick(OpenPendingRequests);
	oldermessagesbutton =  UI.CreateButton(vert).SetText("Mod History").SetOnClick(function()
		if(Mod.PlayerGameData.Nachrichten ~=nil)then
			local Nachricht = " ";
			local Nachrichtensplit = stringtotable(Mod.PlayerGameData.Nachrichten);
			local num = 1;
			while(Nachrichtensplit[num] ~= nil and Nachrichtensplit[num+1] ~= nil and Nachrichtensplit[num+2] ~= nil and Nachrichtensplit[num+3] ~= nil)do
				if(Nachrichtensplit[num+1] == "0")then
					Nachricht = Nachricht .. "\n" .. toname(Nachrichtensplit[num],Game) .. " declared war on " .. toname(Nachrichtensplit[num+3],Game) .. " in turn " .. Nachrichtensplit[num+2];
				end
				if(Nachrichtensplit[num+1] == "1")then
					if(tonumber(Nachrichtensplit[num+2])>1)then
						Nachricht = Nachricht .. "\n" .. toname(Nachrichtensplit[num],Game) .. " offered " .. toname(Nachrichtensplit[num+3],Game) .. " peace for " .. Nachrichtensplit[num+2] .. " turns";
					else
						Nachricht = Nachricht .. "\n" .. toname(Nachrichtensplit[num],Game) .. " offered " .. toname(Nachrichtensplit[num+3],Game) .. " peace for " .. Nachrichtensplit[num+2] .. " turn";
					end
				end
				if(Nachrichtensplit[num+1] == "2")then
					Nachricht = Nachricht .. "\n" .. toname(Nachrichtensplit[num],Game) .. " accepted the peace offer by " .. toname(tNachrichtensplit[num+3],Game) .. " until turn " .. tostring(tonumber(Nachrichtensplit[num+2])+1);
				end
				if(Nachrichtensplit[num+1] == "3")then
					Nachricht = Nachricht .. "\n" .. toname(Nachrichtensplit[num],Game) .. " declined the peace offer by " .. toname(Nachrichtensplit[num+3],Game);
				end
				if(Nachrichtensplit[num+1] == "4")then
					Nachricht = Nachricht .. "\n" .. "You declined the territory sell offer of " .. toname(Nachrichtensplit[num],Game) .. " for " .. Game.Map.Territories[tonumber(Nachrichtensplit[num+3])].Name .. " in turn " .. Nachrichtensplit[num+3];
				end
				if(Nachrichtensplit[num+1] == "5")then
					Nachricht = Nachricht .. "\n" .. toname(Nachrichtensplit[num],Game) .. " declined your territory sell offer for " .. Game.Map.Territories[tonumber(Nachrichtensplit[num+3])].Name .. " in turn " .. Nachrichtensplit[num+3];
				end
				num = num + 4;
			end
			UI.Alert(Nachricht);
		else
			UI.Alert("There is currently no history for this Mod");
		end
	end);
end
function OpenOfferAlliance()
	DeleteUI();
	horzobjlist[0] = UI.CreateHorizontalLayoutGroup(root);
	textelem = UI.CreateLabel(horzobjlist[0]).SetText("Offer Allianze To: ");
	TargetPlayerBtn = UI.CreateButton(horzobjlist[0]).SetText("Select player...").SetOnClick(TargetPlayerClickedOfferAllianze);
	horzobjlist[1] = UI.CreateHorizontalLayoutGroup(root);
	commitbutton = UI.CreateButton(horzobjlist[1]).SetText("Offer").SetOnClick(declare);
end
function TargetPlayerClickedOfferAllianze()
	local inwarwith = {};
	if(Mod.PublicGameData.War ~= nil and Mod.PublicGameData.War[Game.Us.ID] ~= nil)then
		inwarwith = stringtotable(Mod.PublicGameData.War[Game.Us.ID]);
	end
	local allianzesplit = {};
	if(Mod.PlayerGameData.Allianze ~= nil)then
		local allianzesplit = stringtotable(Mod.PlayerGameData.Allianze);
	end
	local options = {};
	local match2 = false;
	for _,playerinstanze in pairs(Game.Game.Players)do
		local match = false;
		for _,with in pairs(inwarwith)do
			if(tostring(with) == tostring(playerinstanze.ID))then
				match=true;
			end
		end
		for _,with in pairs(allianzesplit)do
			if(tostring(with) == tostring(playerinstanze.ID))then
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
	AllEvilFuncs={};
	if(Mod.PlayerGameData.Peaceoffers~=nil)then
		local peacesplit = stringtotable(Mod.PlayerGameData.Peaceoffers);
		if(tablelength(peacesplit) == 1)then
			horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
			UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("You have no offer");
		end
		local num = 1;
		--for _,obj in pairs(peacesplit)do
		--	horz = UI.CreateHorizontalLayoutGroup(root);
		--	UI.CreateLabel(horz).SetText("Test " .. obj);
		--end
		RecentPlayerID={};
		
		while(peacesplit[num] ~= nil and peacesplit[num+1] ~= nil and peacesplit[num+1] ~= "")do
			RecentPlayerID[num]=tonumber(peacesplit[num]);
			horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
			UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText(" ");
			horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
			UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("Peace Offer by " .. toname(tonumber(peacesplit[num]),Game));
			if(Mod.Settings.StartMoney ~= 0 or Mod.Settings.MoneyPerTurn ~= 0 or Mod.Settings.MoneyPerKilledArmy ~= 0 or Mod.Settings.MoneyPerCapturedTerritory ~= 0 or Mod.Settings.MoneyPerCapturedBonus ~= 0)then
				horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
			end
			local requiredmoney = tonumber(peacesplit[num+1]);
			if(requiredmoney == 0)then
				if(Mod.Settings.StartMoney ~= 0 or Mod.Settings.MoneyPerTurn ~= 0 or Mod.Settings.MoneyPerKilledArmy ~= 0 or Mod.Settings.MoneyPerCapturedTerritory ~= 0 or Mod.Settings.MoneyPerCapturedBonus ~= 0)then
					UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("This Peace Offer is for free");
				end
			else
				if(requiredmoney > 0)then
					UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("You need to pay " .. peacesplit[num+1] .. " Coins if you accept");
				else
					UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("He will pay you " .. peacesplit[num+1]*-1 .. " Coins if you accept");
				end
			end
			horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
			UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("The Peace will last for " .. tonumber(peacesplit[num+2]) .. " Turns. After that you can declare again war on him.");
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
				AllEvilFuncs[tablelength(AllEvilFuncs)+1]=function() local InNum = locNum; AcceptPeaceOffer(InNum); end;
				button.SetOnClick(AllEvilFuncs[tablelength(AllEvilFuncs)]);
				local buttonzwei = UI.CreateButton(horzobjlist[tablelength(horzobjlist)-1]).SetText("Deny");
				local locNumzwei= {};
				locNumzwei.Spieler = tonumber(peacesplit[num]);
				locNumzwei.Message = "Decline Peace";
				AllEvilFuncs[tablelength(AllEvilFuncs)+1]=function() local InNumzwei = locNumzwei; AcceptPeaceOffer(InNumzwei); end;
				buttonzwei.SetOnClick(AllEvilFuncs[tablelength(AllEvilFuncs)]);
				
			end
			num = num +2;
		end
	else
		horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
		UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("You have no offer");
	end
	horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
	UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText(" ",Game);
	horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
	UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("Territories you can buy");
	if(Mod.PlayerGameData.Terrselloffers ~= nil)then
		local territorysellsplit = stringtotable(Mod.PlayerGameData.Terrselloffers);
		num = 1;
		if(tablelength(territorysellsplit) == 1)then
			horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
			UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("You have no offer");
		end
		while(territorysellsplit[num] ~= nil and territorysellsplit[num+1] ~= nil and territorysellsplit[num+2] ~= nil)do
			horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
			UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText(" ");
			horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
			UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText(toname(tonumber(territorysellsplit[num]),Game) .. ' wants to sell you ' .. Game.Map.Territories[tonumber(territorysellsplit[num+1])].Name);
			horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
			local Price = tonumber(territorysellsplit[num+2]);
			if(Price ~= 0)then
				if(Price > 0)then
					UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("If you want to accept, you need to pay " .. Price);
				else
					UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("If you want to accept, he will pay you" .. (Preis*-1));
				end
			else
				if(Mod.Settings.StartMoney ~= 0 or Mod.Settings.MoneyPerTurn ~= 0 or Mod.Settings.MoneyPerKilledArmy ~= 0 or Mod.Settings.MoneyPerCapturedTerritory ~= 0 or Mod.Settings.MoneyPerCapturedBonus ~= 0)then
					UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("The offer is for free");
				end
			end
			if(Price > tonumber(Mod.PlayerGameData.Money))then
				horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
				UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("You have not the money to pay for that territory");
			else
				horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
				local button = UI.CreateButton(horzobjlist[tablelength(horzobjlist)-1]).SetText("Accept");
				local num2 = num;
				AllEvilFuncs[tablelength(AllEvilFuncs)+1]=function()
					local newnum = num2;
					local territorybuyorder = WL.GameOrderCustom.Create(Game.Us.ID, "Buying Territory " .. Game.Map.Territories[tonumber(territorysellsplit[newnum+1])].Name, "," .. territorysellsplit[newnum] .. "," .. territorysellsplit[newnum+1]);
					local orders = Game.Orders;
					table.insert(orders, territorybuyorder);
					Game.Orders=orders;
				end;
				button.SetOnClick(AllEvilFuncs[tablelength(AllEvilFuncs)]);
				button = UI.CreateButton(horzobjlist[tablelength(horzobjlist)-1]).SetText("Deny");
				local num3 = num;
				AllEvilFuncs[tablelength(AllEvilFuncs)+1]=function()
					local newnum = num3;
					local payload = {};
					payload.Message = "Deny Territory Sell";
					payload.TargetPlayerID = tonumber(territorysellsplit[newnum]);
					payload.TargetTerritoryID = tonumber(territorysellsplit[newnum+1]);
					Game.SendGameCustomMessage("Sending data...", payload, function(returnvalue)	UI.Alert("You succesfully declined the offer"); end);
					OpenPendingRequests();
				end;
				button.SetOnClick(AllEvilFuncs[tablelength(AllEvilFuncs)]);
			end
			num = num + 3;
		end
	else
		horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
		UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("You have no offer");
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
	if(playerid~=nil)then
		return game.Game.Players[tonumber(playerid)].DisplayName(nil, false);
	else
		return "Bug"
	end
end
function Openshop(rootParent)
	DeleteUI();
	AllFuncs={};
	if(Mod.Settings.StartMoney ~= 0 or Mod.Settings.MoneyPerTurn ~= 0 or Mod.Settings.MoneyPerKilledArmy ~= 0 or Mod.Settings.MoneyPerCapturedTerritory ~= 0 or Mod.Settings.MoneyPerCapturedBonus ~= 0)then
		horzobjlist[0] = UI.CreateHorizontalLayoutGroup(root);
		textelem = UI.CreateLabel(horzobjlist[0]).SetText("Buy Armies");
		horzobjlist[1] = UI.CreateHorizontalLayoutGroup(root);
		territory1 = UI.CreateButton(horzobjlist[1]).SetText("Select territory...");
		AllFuncs[0]=function() TargetTerritoryClicked(territory1); end;
		territory1.SetOnClick(AllFuncs[0]);
		horzobjlist[2] = UI.CreateHorizontalLayoutGroup(root);
		UI.CreateLabel(horzobjlist[2]).SetText('Army number: ');
		Countobj = UI.CreateNumberInputField(horzobjlist[2]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(1);
		horzobjlist[3] = UI.CreateHorizontalLayoutGroup(root);
		commitbutton = UI.CreateButton(horzobjlist[3]).SetText("Add Order").SetOnClick(function() 
			if(territory1.GetText() == "Select territory...")then
				UI.Alert('You need to select a territory first');
			else
				local Anzahl = Countobj.GetValue();
				if(Anzahl< 1)then
					UI.Alert('Invailid Count');
				else
					for _,terr in pairs(Game.Map.Territories)do
						--UI.Alert(terr.Name .. " " .. territory1.GetText());
						if(terr.Name == territory1.GetText())then
							local pay = "," .. terr.ID .. "," .. Anzahl;
							local Nachricht = "Buy Armies (" .. Anzahl .. ") for " .. terr.Name;
							local armybuyorder = WL.GameOrderCustom.Create(Game.Us.ID, Nachricht, pay);
							local orders = Game.Orders;
							table.insert(orders, armybuyorder);
							Game.Orders=orders;
						end
					end
				end
			end
		end)
		horzobjlist[4] = UI.CreateHorizontalLayoutGroup(root);
		textelem = UI.CreateLabel(horzobjlist[4]).SetText(" ");
	end
	--horzobjlist[5] = UI.CreateHorizontalLayoutGroup(root);
	--textelem = UI.CreateLabel(horzobjlist[5]).SetText("Buy Territory");
	--horzobjlist[6] = UI.CreateHorizontalLayoutGroup(root);
	--territoryeins = UI.CreateLabel(horzobjlist[6]).SetText("Select a territory");
	--horzobjlist[7] = UI.CreateHorizontalLayoutGroup(root);
	--textelem = UI.CreateLabel(horzobjlist[7]).SetText("Select a player, you want to buy it from");
	--if(Mod.Settings.StartMoney ~= 0 or Mod.Settings.MoneyPerTurn ~= 0 or Mod.Settings.MoneyPerKilledArmy ~= 0 or Mod.Settings.MoneyPerCapturedTerritory ~= 0 or Mod.Settings.MoneyPerCapturedBonus ~= 0)then
	--	horzobjlist[8] = UI.CreateHorizontalLayoutGroup(root);
	--	textelem = UI.CreateLabel(horzobjlist[8]).SetText("What are you willing to pay");
	--	Moneyyoupayforterritorybuy = UI.CreateNumberInputField(horzobjlist[8]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(0);
	--	horzobjlist[9] = UI.CreateHorizontalLayoutGroup(root);
	--	textelem = UI.CreateLabel(horzobjlist[9]).SetText("What do you want for the territory");
	--	Moneyyougetterritorybuy = UI.CreateNumberInputField(horzobjlist[9]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(0);
	--end
	--horzobjlist[10] = UI.CreateHorizontalLayoutGroup(root);
	--textelem = UI.CreateLabel(horzobjlist[10]).SetText("Send request");
	--horzobjlist[11] = UI.CreateHorizontalLayoutGroup(root);
	--textelem = UI.CreateLabel(horzobjlist[11]).SetText(" ");
	horzobjlist[12] = UI.CreateHorizontalLayoutGroup(root);
	textelem = UI.CreateLabel(horzobjlist[12]).SetText("Sell Territory");
	horzobjlist[13] = UI.CreateHorizontalLayoutGroup(root);
	territory2 = UI.CreateButton(horzobjlist[13]).SetText("Select territory...");
	AllFuncs[1]=function() TargetTerritoryClicked(territory2); end;
	territory2.SetOnClick(AllFuncs[1]);
	horzobjlist[14] = UI.CreateHorizontalLayoutGroup(root);
	textelem = UI.CreateLabel(horzobjlist[14]).SetText("Select a player, you want to offer it to");
	SelectPlayerBtn2 = UI.CreateButton(horzobjlist[14]).SetText("Select Player...").SetOnClick(function() 
			local options = {};
			options[0] = "everyone(does not include persons you are in war with)";
			if(Mod.PublicGameData.War ~= nil and Mod.PublicGameData.War[Game.Us.ID] ~= nil)then
				local inwarwith = stringtotable(Mod.PublicGameData.War[Game.Us.ID]);
				for _,playerinstanze in pairs(Game.Game.Players)do
					local Match = false;
					for _,with in pairs(inwarwith)do
						if(tostring(with) == tostring(playerinstanze.ID))then
							Match = true;
						end
					end
					if(Match == false)then
						if(playerinstanze.ID ~= Game.Us.ID)then
							if(playerinstanze.IsAI == false)then
								table.insert(options,playerinstanze.DisplayName(nil, false));
							end
						end
					end
				end
			else	
				for _,playerinstanze in pairs(Game.Game.Players)do
					if(playerinstanze.ID ~= Game.Us.ID)then
						if(playerinstanze.IsAI == false)then
							table.insert(options,playerinstanze.DisplayName(nil, false));
						end
					end
				end
			end
			options = zusammen(options, PlayerButtonCustom,SelectPlayerBtn2);
			UI.PromptFromList("Select the player you'd like to declare war on", options);
		end);
	if(Mod.Settings.StartMoney ~= 0 or Mod.Settings.MoneyPerTurn ~= 0 or Mod.Settings.MoneyPerKilledArmy ~= 0 or Mod.Settings.MoneyPerCapturedTerritory ~= 0 or Mod.Settings.MoneyPerCapturedBonus ~= 0)then
		horzobjlist[15] = UI.CreateHorizontalLayoutGroup(root);
		textelem = UI.CreateLabel(horzobjlist[15]).SetText("What are you willing to pay");
		Moneyyoupayforterritorysellzwei = UI.CreateNumberInputField(horzobjlist[15]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(0);
		horzobjlist[16] = UI.CreateHorizontalLayoutGroup(root);
		textelem = UI.CreateLabel(horzobjlist[16]).SetText("What do you want for the territory");
		Moneyyougetforterritorysellzwei = UI.CreateNumberInputField(horzobjlist[16]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(0);
	end
	horzobjlist[17] = UI.CreateHorizontalLayoutGroup(root);
	--textelem = UI.CreateLabel(horzobjlist[17]).SetText("Send request");
	UI.CreateButton(horzobjlist[17]).SetText("Send request").SetOnClick(function() 
			if(Moneyyoupayforterritorysellzwei~=nil and Moneyyoupayforterritorysellzwei.GetValue() ~= 0 and Moneyyougetforterritorysellzwei.GetValue() ~= 0)then
				UI.Alert('You cannot pay and get money at the same time');
				return;
			end
			if(Moneyyoupayforterritorysell~=nil and Moneyyoupayforterritorysellzwei.GetValue() < 0 and Moneyyougetforterritorysellzwei.GetValue() < 0)then
				UI.Alert('Negative Money is banned.');
				return;
			end
			if(SelectPlayerBtn2.GetText() == "Select Player...")then
				UI.Alert('You need to select a player first.');
				return;
			end
			if(territory2.GetText() == "Select territory...")then
				UI.Alert('You need to select a territory first.');
				return;
			end
			local Preis = 0;
			if(Moneyyoupayforterritorysellzwei ~=nil)then
				if(Moneyyoupayforterritorysellzwei.GetValue() > 0)then
					Preis = Moneyyoupayforterritorysellzwei.GetValue();
				else
					Preis = -Moneyyougetforterritorysellzwei.GetValue();
				end
			end
			local PlayerID = getplayerid(SelectPlayerBtn2.GetText(),Game);
			local TargetTerritoryID = getterritoryid(territory2.GetText());
			print(TargetTerritoryID);
			local payload = {};
			payload.Message = "Territory Sell";
			payload.TargetPlayerID = PlayerID;
			payload.TargetTerritoryID = TargetTerritoryID;
			payload.Preis = Preis;
			Game.SendGameCustomMessage("Sending request...", payload, function(returnvalue)
					UI.Alert(returnvalue.Message);
				end);
		end)
end
function getterritoryid(name)
	for _,terr in pairs(Game.Map.Territories)do
		if(terr.Name == name)then
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
		local inwarwith = stringtotable(Mod.PublicGameData.War[Game.Us.ID]);
		for _,playerinstanze in pairs(Game.Game.Players)do
			local Match = false;
			for _,with in pairs(inwarwith)do
				if(tostring(with) == tostring(playerinstanze.ID))then
					Match = true;
				end
			end
			if(Match == false)then
				if(playerinstanze.ID ~= Game.Us.ID)then
					table.insert(options,playerinstanze);
				end
			end
		end
	else	
		for _,playerinstanze in pairs(Game.Game.Players)do
			if(playerinstanze.ID ~= Game.Us.ID)then
				table.insert(options,playerinstanze);
			end
		end
	end
	options = map(options, PlayerButton);
	UI.PromptFromList("Select the player you'd like to declare war on", options);
end
function TargetTerritoryClicked(knopf)
	local options = {};
	for _,terr in pairs(Game.LatestStanding.Territories)do
		if(terr.OwnerPlayerID  == Game.Us.ID)then
			table.insert(options,Game.Map.Territories[terr.ID]);
		end
	end
	options = zusammen(options, TerritoryButtonCustom,knopf);
	UI.PromptFromList("Select the territory you'd like to place the armies on", options);
end
function TerritoryButton(terr)
	local name = terr.Name;
	local ret = {};
	ret["text"] = name;
	ret["selected"] = function() 
		territory.SetText(name);
	end
	return ret;
end
function TerritoryButtonCustom(terr,knopf)
	local name = terr.Name;
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
	--horz = UI.CreateHorizontalLayoutGroup(root);
	if(Mod.Settings.StartMoney ~= 0 or Mod.Settings.MoneyPerTurn ~= 0 or Mod.Settings.MoneyPerKilledArmy ~= 0 or Mod.Settings.MoneyPerCapturedTerritory ~= 0 or Mod.Settings.MoneyPerCapturedBonus ~= 0)then
		moneyobj.SetText('Current Money: ' .. Mod.PlayerGameData.Money);
	end
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
