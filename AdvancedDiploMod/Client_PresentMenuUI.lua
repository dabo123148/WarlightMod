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
		UI.CreateLabel(vert).SetText("You cannot use the Diplomacy game, cause you aren't in the game");
		return;
	end
	if(Mod.PlayerGameData == nil or Mod.PlayerGameData.Money == nil)then
		vert = UI.CreateVerticalLayoutGroup(rootParent);
		UI.CreateLabel(vert).SetText("You cannot use this menu in the distribution phase");
		return;
	end
  	horz = UI.CreateHorizontalLayoutGroup(root);
	if((Mod.Settings.StartMoney ~= 0 or Mod.Settings.MoneyPerTurn ~= 0 or Mod.Settings.MoneyPerKilledArmy ~= 0 or Mod.Settings.MoneyPerCapturedTerritory ~= 0 or Mod.Settings.MoneyPerCapturedBonus ~= 0) or (Mod.Settings.BasicMoneySystem ~= nil and Mod.Settings.BasicMoneySystem == true))then
 		if(Mod.Settings.BasicMoneySystem == nil or Mod.Settings.BasicMoneySystem == false or Game.Settings.CommerceGame == false)then
			moneyobj = UI.CreateLabel(horz).SetText('Current Money: ' .. Mod.PlayerGameData.Money);
		else
			moneyobj = UI.CreateLabel(horz).SetText('Current Money: ' .. Game.LatestStanding.NumResources(Game.Us.ID, WL.ResourceType.Gold));
		end
	else
		moneyobj = UI.CreateLabel(horz).SetText('The money system is disabled');
	end
	mainmenu = UI.CreateButton(horz).SetText("Main Menu").SetOnClick(OpenMenu);
	vert = UI.CreateVerticalLayoutGroup(rootParent);
	OpenMenu(rootParent);
end
function OpenOfferPeace()
	DeleteUI();
	if((Mod.Settings.StartMoney ~= 0 or Mod.Settings.MoneyPerTurn ~= 0 or Mod.Settings.MoneyPerKilledArmy ~= 0 or Mod.Settings.MoneyPerCapturedTerritory ~= 0 or Mod.Settings.MoneyPerCapturedBonus ~= 0) or (Mod.Settings.BasicMoneySystem ~= nil and Mod.Settings.BasicMoneySystem == true))then
		horzobjlist[0] = UI.CreateHorizontalLayoutGroup(root);
		textelem = UI.CreateLabel(horzobjlist[0]).SetText("AIs won't take your money or pay you money");
	end
	horzobjlist[1] = UI.CreateHorizontalLayoutGroup(root);
	textelem = UI.CreateLabel(horzobjlist[1]).SetText("Offer peace to: ");
	TargetPlayerBtn = UI.CreateButton(horzobjlist[1]).SetText("Select player...").SetOnClick(TargetPlayerClickedOfferPeace);
	if((Mod.Settings.StartMoney ~= 0 or Mod.Settings.MoneyPerTurn ~= 0 or Mod.Settings.MoneyPerKilledArmy ~= 0 or Mod.Settings.MoneyPerCapturedTerritory ~= 0 or Mod.Settings.MoneyPerCapturedBonus ~= 0) or (Mod.Settings.BasicMoneySystem ~= nil and Mod.Settings.BasicMoneySystem == true))then
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
		for _,playerinstanze in pairs(Game.Game.PlayingPlayers)do
			for _,with in pairs(Mod.PublicGameData.War[Game.Us.ID])do
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
	offerallianzebutton = UI.CreateButton(vert).SetText("Offer Alliance").SetOnClick(OpenOfferAlliance);
	cancelallianzebutton = UI.CreateButton(vert).SetText("Cancel Alliance").SetOnClick(OpenCancelAlliance);
	pendingrequestbutton = UI.CreateButton(vert).SetText("Pending Requests").SetOnClick(OpenPendingRequests);
	oldermessagesbutton =  UI.CreateButton(vert).SetText("Latest Mod History").SetOnClick(function()
		if(tablelength(Mod.PlayerGameData.NeueNachrichten)~=0)then
			ShowHistory(Mod.PlayerGameData.NeueNachrichten,Game,"");
		else
			UI.Alert("There is currently no history for this Mod in the last turns for older history check the game history");
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
	AllEvilFuncs={};
	if(tablelength(Mod.PlayerGameData.Peaceoffers)~=0)then
		for _,peaceoffer in pairs(Mod.PlayerGameData.Peaceoffers)do
			horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
			UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText(" ");
			horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
			UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("Peace Offer by " .. toname(peaceoffer.Offerby,Game));
			if((Mod.Settings.StartMoney ~= 0 or Mod.Settings.MoneyPerTurn ~= 0 or Mod.Settings.MoneyPerKilledArmy ~= 0 or Mod.Settings.MoneyPerCapturedTerritory ~= 0 or Mod.Settings.MoneyPerCapturedBonus ~= 0) or (Mod.Settings.BasicMoneySystem ~= nil and Mod.Settings.BasicMoneySystem == true))then
				horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
				local requiredmoney = tonumber(peaceoffer.Preis);
				if(requiredmoney == 0)then
					UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("This Peace Offer is for free");
				else
					if(requiredmoney > 0)then
						UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("You need to pay " .. tostring(peaceoffer.Preis) .. " money if you accept");
					else
						UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("He will pay you " .. tostring(peaceoffer.Preis*-1) .. " money if you accept");
					end
				end
			end
			horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
			UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("The Peace will last for " .. tostring(peaceoffer.Duration) .. " Turns. After that you can declare again war on him.");
			local mymoney = 0;
			if(Mod.Settings.BasicMoneySystem == nil or Mod.Settings.BasicMoneySystem == false or Game.Settings.CommerceGame == false)then
				mymoney = tonumber(Mod.PlayerGameData.Money);
			else
				mymoney = tonumber(tonumber(Game.LatestStanding.NumResources(Game.Us.ID, WL.ResourceType.Gold)));
			end
			horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
			if(peaceoffer.Preis > mymoney)then
				UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("You haven't the money to accept this offer.");
			else
				local button = UI.CreateButton(horzobjlist[tablelength(horzobjlist)-1]).SetText("Accept");
				local locNum= {};
				locNum.Spieler = peaceoffer.Offerby;
				locNum.Message = "Accept Peace";
				AllEvilFuncs[tablelength(AllEvilFuncs)+1]=function() local InNum = locNum; AcceptPeaceOffer(InNum); end;
				button.SetOnClick(AllEvilFuncs[tablelength(AllEvilFuncs)]);
				local buttonzwei = UI.CreateButton(horzobjlist[tablelength(horzobjlist)-1]).SetText("Deny");
				local locNumzwei= {};
				locNumzwei.Spieler = peaceoffer.Offerby;
				locNumzwei.Message = "Decline Peace";
				AllEvilFuncs[tablelength(AllEvilFuncs)+1]=function() local InNumzwei = locNumzwei; AcceptPeaceOffer(InNumzwei); end;
				buttonzwei.SetOnClick(AllEvilFuncs[tablelength(AllEvilFuncs)]);
			end
		end
	else
		horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
		UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("You have no offer");
	end
	horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
	UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("");
	horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
	UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("Territories you can buy");
	if(tablelength(Mod.PlayerGameData.TerritorySellOffers) ~= 0)then
		for _,player in pairs(Mod.PlayerGameData.TerritorySellOffers)do
			for _,terroffer in pairs(player)do
				if(Game.Map.Territories[terroffer.terrID] ~= nil)then
				horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
				UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText(" ");
				horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
				UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText(toname(terroffer.Player,Game) .. ' wants to sell you ' .. Game.Map.Territories[terroffer.terrID].Name);
				if((Mod.Settings.StartMoney ~= 0 or Mod.Settings.MoneyPerTurn ~= 0 or Mod.Settings.MoneyPerKilledArmy ~= 0 or Mod.Settings.MoneyPerCapturedTerritory ~= 0 or Mod.Settings.MoneyPerCapturedBonus ~= 0) or (Mod.Settings.BasicMoneySystem ~= nil and Mod.Settings.BasicMoneySystem == true))then
					horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
					Price = terroffer.Preis;
					if(Price ~= 0)then
						if(Price > 0)then
							UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("If you want to accept, you need to pay " .. Price);
						else
							UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("If you want to accept, he will pay you" .. (Preis*-1));
						end
					else
						UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("The offer is for free");
					end
				end
				--if(Price ~= 0)then
				--	if(Mod.Settings.BasicMoneySystem == nil or Mod.Settings.BasicMoneySystem == false or Game.Settings.CommerceGame == false)then
				--		if(Price > tonumber(Mod.PlayerGameData.Money))then
				--			horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
				--			UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("You have not the money to pay for that territory");
				--		end
				--	else
				--		if(Price > tonumber(Game.Game.Players[Game.Us.ID].Resources[WL.ResourceType.Gold]))then
				--			horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
				--			UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("You have not the money to pay for that territory");
				--		end
				--	end
				--else
					horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
					local button = UI.CreateButton(horzobjlist[tablelength(horzobjlist)-1]).SetText("Accept");
					AllEvilFuncs[tablelength(AllEvilFuncs)+1]=function()
						local territorybuyorder = WL.GameOrderCustom.Create(Game.Us.ID, "Buy Territory " .. Game.Map.Territories[terroffer.terrID].Name .. " from " .. toname(terroffer.Player,Game), "," .. terroffer.Player .. "," .. terroffer.terrID);
						local orders = Game.Orders;
						if(Game.Us.HasCommittedOrders == true)then
							UI.Alert("You need to uncommit first");
							return;
						end
						table.insert(orders, territorybuyorder);
						Game.Orders=orders;
					end;
					button.SetOnClick(AllEvilFuncs[tablelength(AllEvilFuncs)]);
					button = UI.CreateButton(horzobjlist[tablelength(horzobjlist)-1]).SetText("Deny");
					AllEvilFuncs[tablelength(AllEvilFuncs)+1]=function()
						local payload = {};
						payload.Message = "Deny Territory Sell";
						payload.TargetPlayerID = terroffer.Player;
						payload.TargetTerritoryID = terroffer.terrID;
						Game.SendGameCustomMessage("Sending data...", payload, function(returnvalue)	UI.Alert(returnvalue.Message); end);
						OpenPendingRequests();
					end;
					button.SetOnClick(AllEvilFuncs[tablelength(AllEvilFuncs)]);
				--end
				end
			end
		end
	else
		horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
		UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("You have no offer");
	end
	horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
	UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("");
	horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
	UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText("Alliance Offers");
	if(tablelength(Mod.PlayerGameData.AllyOffers) ~= 0)then
		for _,allyoffer in pairs(Mod.PlayerGameData.AllyOffers)do
			horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
			UI.CreateLabel(horzobjlist[tablelength(horzobjlist)-1]).SetText(toname(allyoffer.OfferedBy,Game) .. " offers you an alliance");
			horzobjlist[tablelength(horzobjlist)] = UI.CreateHorizontalLayoutGroup(root);
			button = UI.CreateButton(horzobjlist[tablelength(horzobjlist)-1]).SetText("Deny");
			local onclick=function()
				local payload = {};
				payload.Message = "Deny Allianze";
				payload.OfferedBy = allyoffer.OfferedBy;
				Game.SendGameCustomMessage("Sending data...", payload, function(returnvalue)	UI.Alert(returnvalue.Message); end);
				OpenPendingRequests();
				end;
			button.SetOnClick(onclick);
			button = UI.CreateButton(horzobjlist[tablelength(horzobjlist)-1]).SetText("Accept");
			local onclick2=function()
				local payload = {};
				payload.Message = "Accept Allianze";
				payload.OfferedBy = allyoffer.OfferedBy;
				Game.SendGameCustomMessage("Sending data...", payload, function(returnvalue)	UI.Alert(returnvalue.Message); end);
				OpenPendingRequests();
				end;
			button.SetOnClick(onclick2);
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
					if(returnvalue.Message == 1)then
						UI.Alert("The Peace Offer doesn't exist any longer");
					else
						if(data.Message == "Decline Peace")then
							UI.Alert('You declined ' .. toname(data.Spieler,Game) .. " Peace Offer");
						else
							UI.Alert("You are now again in peace with " .. toname(data.Spieler,Game));
						end
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
	if((Mod.Settings.StartMoney ~= 0 or Mod.Settings.MoneyPerTurn ~= 0 or Mod.Settings.MoneyPerKilledArmy ~= 0 or Mod.Settings.MoneyPerCapturedTerritory ~= 0 or Mod.Settings.MoneyPerCapturedBonus ~= 0) or (Mod.Settings.BasicMoneySystem ~= nil and Mod.Settings.BasicMoneySystem == true))then
		if(Mod.Settings.MoneyPerBoughtArmy~=0)then
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
							if(terr.Name .. "(ID:" .. terr.ID .. ")" == territory1.GetText())then
								local pay = "," .. terr.ID .. "," .. Anzahl;
								local Nachricht = "Buy Armies (" .. Anzahl .. ") for " .. terr.Name;
								local armybuyorder = WL.GameOrderCustom.Create(Game.Us.ID, Nachricht, pay);
								local orders = Game.Orders;
								if(Game.Us.HasCommittedOrders == true)then
									UI.Alert("You need to uncommit first");
									return;
								end
								table.insert(orders, armybuyorder);
								Game.Orders=orders;
							end
						end
					end
				end
			end)
		end
		horzobjlist[4] = UI.CreateHorizontalLayoutGroup(root);
		textelem = UI.CreateLabel(horzobjlist[4]).SetText(" ");
		horzobjlist[5] = UI.CreateHorizontalLayoutGroup(root);
		textelem = UI.CreateLabel(horzobjlist[5]).SetText("Gift Money");
		horzobjlist[6] = UI.CreateHorizontalLayoutGroup(root);
		textelem = UI.CreateLabel(horzobjlist[6]).SetText("Select the player you'd like to gift the money to");
		SelectPlayerBtn3 = UI.CreateButton(horzobjlist[6]).SetText("Select Player...").SetOnClick(function() 
			local options = {};
			for _,playerinstanze in pairs(Game.Game.PlayingPlayers)do
				if(playerinstanze.IsAI == false)then
					table.insert(options,playerinstanze.DisplayName(nil, false));
				end
			end
			options = zusammen(options, PlayerButtonCustom,SelectPlayerBtn3);
			UI.PromptFromList("Select the player you'd like to gift the money to", options);
		end);
		horzobjlist[7] = UI.CreateHorizontalLayoutGroup(root);
		GiftMoneyValue = UI.CreateNumberInputField(horzobjlist[7]).SetSliderMinValue(1).SetSliderMaxValue(100).SetValue(1);
		horzobjlist[8] = UI.CreateHorizontalLayoutGroup(root);
		UI.CreateButton(horzobjlist[8]).SetText("Send Money").SetOnClick(function()
			local money = GiftMoneyValue.GetValue();
			if(money < 1)then
				UI.Alert("Money must be positive");
				return;
			end
			if(Mod.Settings.BasicMoneySystem == nil or Mod.Settings.BasicMoneySystem == false or Game.Settings.CommerceGame == false)then
				if(money > tonumber(Mod.PlayerGameData.Money))then
					UI.Alert("You haven't the money");
					return;
				end
			else
				if(money > tonumber(Game.LatestStanding.NumResources(Game.Us.ID, WL.ResourceType.Gold)))then
					UI.Alert("You haven't the money");
					return;
				end
			end
			if(SelectPlayerBtn3.GetText() == "Select Player...")then
				UI.Alert("You need to select a player first");
				return;
			end
			local payload = {};
			payload.Message = "Gift Money";
			payload.Wert = money;
			payload.TargetPlayerID = getplayerid(SelectPlayerBtn3.GetText(),Game);
			Game.SendGameCustomMessage("Sending request...", payload, function(returnvalue) 
				UI.Alert(returnvalue.Message);
			end);
		end);
		horzobjlist[9] = UI.CreateHorizontalLayoutGroup(root);
		textelem = UI.CreateLabel(horzobjlist[9]).SetText(" ");
	end
	--horzobjlist[5] = UI.CreateHorizontalLayoutGroup(root);
	--textelem = UI.CreateLabel(horzobjlist[5]).SetText("Buy Territory");
	--horzobjlist[6] = UI.CreateHorizontalLayoutGroup(root);
	--territoryeins = UI.CreateLabel(horzobjlist[6]).SetText("Select a territory");
	--horzobjlist[7] = UI.CreateHorizontalLayoutGroup(root);
	--textelem = UI.CreateLabel(horzobjlist[7]).SetText("Select a player, you want to buy it from");
	--if((Mod.Settings.StartMoney ~= 0 or Mod.Settings.MoneyPerTurn ~= 0 or Mod.Settings.MoneyPerKilledArmy ~= 0 or Mod.Settings.MoneyPerCapturedTerritory ~= 0 or Mod.Settings.MoneyPerCapturedBonus ~= 0) or (Mod.Settings.BasicMoneySystem ~= nil and Mod.Settings.BasicMoneySystem == true))then
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
				for _,playerinstanze in pairs(Game.Game.PlayingPlayers)do
					local Match = false;
					for _,with in pairs(Mod.PublicGameData.War[Game.Us.ID])do
						if(with == playerinstanze.ID)then
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
				for _,playerinstanze in pairs(Game.Game.PlayingPlayers)do
					if(playerinstanze.ID ~= Game.Us.ID)then
						if(playerinstanze.IsAI == false)then
							table.insert(options,playerinstanze.DisplayName(nil, false));
						end
					end
				end
			end
			options = zusammen(options, PlayerButtonCustom,SelectPlayerBtn2);
			UI.PromptFromList("Select the player you'd like to offer it to", options);
		end);
	if((Mod.Settings.StartMoney ~= 0 or Mod.Settings.MoneyPerTurn ~= 0 or Mod.Settings.MoneyPerKilledArmy ~= 0 or Mod.Settings.MoneyPerCapturedTerritory ~= 0 or Mod.Settings.MoneyPerCapturedBonus ~= 0) or (Mod.Settings.BasicMoneySystem ~= nil and Mod.Settings.BasicMoneySystem == true))then
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
					Preis = -Moneyyoupayforterritorysellzwei.GetValue();
				else
					Preis = Moneyyougetforterritorysellzwei.GetValue();
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
	local name = terr.Name .. "(ID:" .. terr.ID .. ")";
	local ret = {};
	ret["text"] = name;
	ret["selected"] = function() 
		territory.SetText(name);
	end
	return ret;
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
	--horz = UI.CreateHorizontalLayoutGroup(root);
	if((Mod.Settings.StartMoney ~= 0 or Mod.Settings.MoneyPerTurn ~= 0 or Mod.Settings.MoneyPerKilledArmy ~= 0 or Mod.Settings.MoneyPerCapturedTerritory ~= 0 or Mod.Settings.MoneyPerCapturedBonus ~= 0) or (Mod.Settings.BasicMoneySystem ~= nil and Mod.Settings.BasicMoneySystem == true))then
		if(Mod.Settings.BasicMoneySystem == nil or Mod.Settings.BasicMoneySystem == false or Game.Settings.CommerceGame == false)then
			moneyobj.SetText('Current Money: ' .. Mod.PlayerGameData.Money);
		else
			moneyobj.SetText('Current Money: ' .. Game.LatestStanding.NumResources(Game.Us.ID, WL.ResourceType.Gold));
		end
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
