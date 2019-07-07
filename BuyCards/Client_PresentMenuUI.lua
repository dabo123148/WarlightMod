function Client_PresentMenuUI(rootParent, setMaxSize, setScrollable, game)
	print(game.GetTurn);
	turn = game.GetTurn;
	print(turn().TurnNumber);
	Game = game;
	root = rootParent;
	setMaxSize(450, 350);
	if (game.Settings.CommerceGame == false) then
		UI.CreateLabel(vert).SetText("This mod only works in commerce games.  This isn't a commerce game.");
		return;
	end
	if(game.Us == nil) then
		horz = UI.CreateHorizontalLayoutGroup(rootParent);
		UI.CreateLabel(horz).SetText("You cannot use the mod, cause you aren't in the game");
		return;
	end
	if(game.Game.PlayingPlayers[game.Us.ID] == nil)then
		horz = UI.CreateHorizontalLayoutGroup(root);
		UI.CreateLabel(horz).SetText("You have been eliminated, so you are no longer able to interact with the mod");
		return;
	end
	if(game.GetTurn() == nil)then
		horz = UI.CreateHorizontalLayoutGroup(root);
		UI.CreateLabel(horz).SetText("This mod can not be used during distribution");
		return;
	end
	OpenMenu()
end
function OpenMenu()
	vert = UI.CreateVerticalLayoutGroup(root);
	buygiftcard = UI.CreateButton(vert).SetText("Buy Gift Card for " .. Mod.Settings.GiftCardCost).SetOnClick(function() 
		local goldHave = CalculateGoldUsed();
		if(goldHave<Mod.Settings.GiftCardCost)then
			UI.Alert("You dont have enough Gold to buy this card");
			return;
		end
		addOrder(WL.GameOrderCustom.Create(Game.Us.ID, "Buy Gift Card", "",{ [WL.ResourceType.Gold] = Mod.Settings.GiftCardCost }));
		CalcuateBuyPossiblities(); end);
	buyspycard = UI.CreateButton(vert).SetText("Buy Spy Card for " .. Mod.Settings.SpyCardCost).SetOnClick(function() 
		local goldHave = CalculateGoldUsed();
		if(goldHave<Mod.Settings.SpyCardCost)then
			UI.Alert("You dont have enough Gold to buy this card");
			return;
		end
		addOrder(WL.GameOrderCustom.Create(Game.Us.ID, "Buy Spy Card", "",{ [WL.ResourceType.Gold] = Mod.Settings.SpyCardCost }));
		CalcuateBuyPossiblities(); end);
	buyemergencyblockardcard = UI.CreateButton(vert).SetText("Buy Emergecy Blockade Card for " .. Mod.Settings.EmergencyBlockadeCardCost).SetOnClick(function() 
		local goldHave = CalculateGoldUsed();
		if(goldHave<Mod.Settings.EmergencyBlockadeCardCost)then
			UI.Alert("You dont have enough Gold to buy this card");
			return;
		end
		addOrder(WL.GameOrderCustom.Create(Game.Us.ID, "Buy Emergency Blockade Card", "",{ [WL.ResourceType.Gold] = Mod.Settings.EmergencyBlockadeCardCost }));
		CalcuateBuyPossiblities(); end);
	buyblockardcard = UI.CreateButton(vert).SetText("Buy Blockade Card for " .. Mod.Settings.BlockadeCardCost).SetOnClick(function() 
		local goldHave = CalculateGoldUsed();
		if(goldHave<Mod.Settings.BlockadeCardCost)then
			UI.Alert("You dont have enough Gold to buy this card");
			return;
		end
		addOrder(WL.GameOrderCustom.Create(Game.Us.ID, "Buy Blockade Card", "",{ [WL.ResourceType.Gold] = Mod.Settings.BlockadeCardCost }));
		CalcuateBuyPossiblities(); end);
	buyorderprioritycard = UI.CreateButton(vert).SetText("Buy Order Priority Card for " .. Mod.Settings.OrderPriorityCardCost).SetOnClick(function() 
		local goldHave = CalculateGoldUsed();
		if(goldHave<Mod.Settings.OrderPriorityCardCost)then
			UI.Alert("You dont have enough Gold to buy this card");
			return;
		end
		addOrder(WL.GameOrderCustom.Create(Game.Us.ID, "Buy Order Priority Card", "",{ [WL.ResourceType.Gold] = Mod.Settings.OrderPriorityCardCost }));
		CalcuateBuyPossiblities(); end);
	buyorderdelaycard = UI.CreateButton(vert).SetText("Buy Order Delay Card for " .. Mod.Settings.OrderDelayCardCost).SetOnClick(function() 
		local goldHave = CalculateGoldUsed();
		if(goldHave<Mod.Settings.OrderDelayCardCost)then
			UI.Alert("You dont have enough Gold to buy this card");
			return;
		end
		addOrder(WL.GameOrderCustom.Create(Game.Us.ID, "Buy Order Delay Card", "",{ [WL.ResourceType.Gold] = Mod.Settings.OrderDelayCardCost }));
		CalcuateBuyPossiblities(); end);
	buyairliftcard = UI.CreateButton(vert).SetText("Buy Airlift Card for " .. Mod.Settings.AirliftCardCost).SetOnClick(function() 
		local goldHave = CalculateGoldUsed();
		if(goldHave<Mod.Settings.AirliftCardCost)then
			UI.Alert("You dont have enough Gold to buy this card");
			return;
		end
		addOrder(WL.GameOrderCustom.Create(Game.Us.ID, "Buy Airlift Card", "",{ [WL.ResourceType.Gold] = Mod.Settings.AirliftCardCost }));
		CalcuateBuyPossiblities(); end);
	buydiplomacycard = UI.CreateButton(vert).SetText("Buy Diplomacy Card for " .. Mod.Settings.DiplomacyCardCost).SetOnClick(function() 
		local goldHave = CalculateGoldUsed();
		if(goldHave<Mod.Settings.DiplomacyCardCost)then
			UI.Alert("You dont have enough Gold to buy this card");
			return;
		end
		addOrder(WL.GameOrderCustom.Create(Game.Us.ID, "Buy Diplomacy Card", "",{ [WL.ResourceType.Gold] = Mod.Settings.DiplomacyCardCost }));
		CalcuateBuyPossiblities(); end);
	buysanctioncard = UI.CreateButton(vert).SetText("Buy Sanctions Card for " .. Mod.Settings.SanctionsCardCost).SetOnClick(function() 
		local goldHave = CalculateGoldUsed();
		if(goldHave<Mod.Settings.SanctionsCardCost)then
			UI.Alert("You dont have enough Gold to buy this card");
			return;
		end
		addOrder(WL.GameOrderCustom.Create(Game.Us.ID, "Buy Sanctions Card", "",{ [WL.ResourceType.Gold] = Mod.Settings.SanctionsCardCost }));
		CalcuateBuyPossiblities(); end);
	buyreconnaissancecard = UI.CreateButton(vert).SetText("Buy Reconnaissance Card for " .. Mod.Settings.ReconnaissanceCardCost).SetOnClick(function() 
		local goldHave = CalculateGoldUsed();
		if(goldHave<Mod.Settings.ReconnaissanceCardCost)then
			UI.Alert("You dont have enough Gold to buy this card");
			return;
		end
		addOrder(WL.GameOrderCustom.Create(Game.Us.ID, "Buy Reconnaissance Card", "",{ [WL.ResourceType.Gold] = Mod.Settings.ReconnaissanceCardCost }));
		CalcuateBuyPossiblities(); end);
	buysurveillancecard = UI.CreateButton(vert).SetText("Buy Surveillance Card for " .. Mod.Settings.SurveillanceCardCost).SetOnClick(function() 
		local goldHave = CalculateGoldUsed();
		if(goldHave<Mod.Settings.SurveillanceCardCost)then
			UI.Alert("You dont have enough Gold to buy this card");
			return;
		end
		addOrder(WL.GameOrderCustom.Create(Game.Us.ID, "Buy Surveillance Card", "",{ [WL.ResourceType.Gold] = Mod.Settings.SurveillanceCardCost }));
		CalcuateBuyPossiblities(); end);
	buybombcard = UI.CreateButton(vert).SetText("Buy Bomb Card for " .. Mod.Settings.BombCardCost).SetOnClick(function() 
		local goldHave = CalculateGoldUsed();
		if(goldHave<Mod.Settings.BombCardCost)then
			UI.Alert("You dont have enough Gold to buy this card");
			return;
		end
		addOrder(WL.GameOrderCustom.Create(Game.Us.ID, "Buy Bomb Card", "",{ [WL.ResourceType.Gold] = Mod.Settings.BombCardCost }));
		CalcuateBuyPossiblities(); end);
	CalcuateBuyPossiblities();
end
function CalculateGoldUsed()
	return Game.LatestStanding.NumResources(Game.Us.ID, WL.ResourceType.Gold);
end
--Calculates which cards can be bought
function CalcuateBuyPossiblities()
	if(Game.Settings.Cards[WL.CardID.Gift] == nil or Mod.Settings.GiftCardCost == 0)then
		buygiftcard.SetInteractable(false).SetText("Gift cards can not be purchased");
	end
	if(Game.Settings.Cards[WL.CardID.Spy] == nil or Mod.Settings.SpyCardCost == 0)then
		buyspycard.SetInteractable(false).SetText("Gift cards can not be purchased");
	end
	if(Game.Settings.Cards[WL.CardID.EmergencyBlockade] == nil or Mod.Settings.EmergencyBlockadeCardCost == 0)then
		buyemergencyblockardcard.SetInteractable(false).SetText("EmergencyBlockade cards can not be purchased");
	end
	if(Game.Settings.Cards[WL.CardID.Blockade] == nil or Mod.Settings.BlockadeCardCost == 0)then
		buyblockardcard.SetInteractable(false).SetText("Blockade cards can not be purchased");
	end
	if(Game.Settings.Cards[WL.CardID.OrderPriority] == nil or Mod.Settings.OrderPriorityCardCost == 0)then
		buyorderprioritycard.SetInteractable(false).SetText("Order Priority cards can not be purchased");
	end
	if(Game.Settings.Cards[WL.CardID.OrderDelay] == nil or Mod.Settings.OrderDelayCardCost == 0)then
		buyorderdelaycard.SetInteractable(false).SetText("Order Delay cards can not be purchased");
	end
	if(Game.Settings.Cards[WL.CardID.Airlift] == nil or Mod.Settings.AirliftCardCost == 0)then
		buyairliftcard.SetInteractable(false).SetText("Airlift cards can not be purchased");
	end
	if(Game.Settings.Cards[WL.CardID.Diplomacy] == nil or Mod.Settings.DiplomacyCardCost == 0)then
		buydiplomacycard.SetInteractable(false).SetText("Diplomacy cards can not be purchased");
	end
	if(Game.Settings.Cards[WL.CardID.Sanctions] == nil or Mod.Settings.SanctionsCardCost == 0)then
		buysanctioncard.SetInteractable(false).SetText("Sanctions cards can not be purchased");
	end
	if(Game.Settings.Cards[WL.CardID.Reconnaissance] == nil or Mod.Settings.ReconnaissanceCardCost == 0)then
		buyreconnaissancecard.SetInteractable(false).SetText("Reconnaissance cards can not be purchased");
	end
	if(Game.Settings.Cards[WL.CardID.Surveillance] == nil or Mod.Settings.SurveillanceCardCost == 0)then
		buysurveillancecard.SetInteractable(false).SetText("Surveillance cards can not be purchased");
	end
	if(Game.Settings.Cards[WL.CardID.Bomb] == nil or Mod.Settings.BombCardCost == 0)then
		buybombcard.SetInteractable(false).SetText("Bomb cards can not be purchased");
	end
end
function addOrder(order)
	local orders = Game.Orders;
	if(Game.Us.HasCommittedOrders == true)then
		UI.Alert("You need to uncommit first");
		return;
	end
	table.insert(orders, order);
	Game.Orders = orders;
end
function  tablelength(T)
	local count = 0;
	for _, elem in pairs(T)do
		count = count + 1;
	end
	return count;
end
