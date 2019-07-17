function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	if(order.proxyType == "GameOrderCustom")then
		if(order.Message == "Buy Gift Card")then
			if(order.CostOpt[WL.ResourceType.Gold]== Mod.Settings.GiftCardCost)then
				if(game.Settings.Cards[WL.CardID.Gift] ~= nil)then
					local cardinstance = WL.NoParameterCardInstance.Create(WL.CardID.Gift);
					addNewOrder(WL.GameOrderReceiveCard.Create(order.PlayerID, {cardinstance}));
				else
					--somehow the card got purchased even though it is not in the game
					skipThisOrder(WL.ModOrderControl.Skip);
					return;
				end
			else
				--price got manipulated
				skipThisOrder(WL.ModOrderControl.Skip);
				return;
			end
		end
		if(order.Message == "Buy Spy Card")then
			if(order.CostOpt[WL.ResourceType.Gold]== Mod.Settings.SpyCardCost)then
				if(game.Settings.Cards[WL.CardID.Spy] ~= nil)then
					local cardinstance = WL.NoParameterCardInstance.Create(WL.CardID.Spy);
					addNewOrder(WL.GameOrderReceiveCard.Create(order.PlayerID, {cardinstance}));
				else
					--somehow the card got purchased even though it is not in the game
					skipThisOrder(WL.ModOrderControl.Skip);
					return;
				end
			else
				--price got manipulated
				skipThisOrder(WL.ModOrderControl.Skip);
				return;
			end
		end
		if(order.Message == "Buy Emergency Blockade Card")then
			if(order.CostOpt[WL.ResourceType.Gold]== Mod.Settings.EmergencyBlockadeCardCost)then
				if(game.Settings.Cards[WL.CardID.EmergencyBlockade] ~= nil)then
					local cardinstance = WL.NoParameterCardInstance.Create(WL.CardID.EmergencyBlockade);
					addNewOrder(WL.GameOrderReceiveCard.Create(order.PlayerID, {cardinstance}));
				else
					--somehow the card got purchased even though it is not in the game
					skipThisOrder(WL.ModOrderControl.Skip);
					return;
				end
			else
				--price got manipulated
				skipThisOrder(WL.ModOrderControl.Skip);
				return;
			end
		end
		if(order.Message == "Buy Blockade Card")then
			if(order.CostOpt[WL.ResourceType.Gold]== Mod.Settings.BlockadeCardCost)then
				if(game.Settings.Cards[WL.CardID.Blockade] ~= nil)then
					local cardinstance = WL.NoParameterCardInstance.Create(WL.CardID.Blockade);
					addNewOrder(WL.GameOrderReceiveCard.Create(order.PlayerID, {cardinstance}));
				else
					--somehow the card got purchased even though it is not in the game
					skipThisOrder(WL.ModOrderControl.Skip);
					return;
				end
			else
				--price got manipulated
				skipThisOrder(WL.ModOrderControl.Skip);
				return;
			end
		end
		if(order.Message == "Buy Order Priority Card")then
			if(order.CostOpt[WL.ResourceType.Gold]== Mod.Settings.OrderPriorityCardCost)then
				if(game.Settings.Cards[WL.CardID.OrderPriority] ~= nil)then
					local cardinstance = WL.NoParameterCardInstance.Create(WL.CardID.OrderPriority);
					addNewOrder(WL.GameOrderReceiveCard.Create(order.PlayerID, {cardinstance}));
				else
					--somehow the card got purchased even though it is not in the game
					skipThisOrder(WL.ModOrderControl.Skip);
					return;
				end
			else
				--price got manipulated
				skipThisOrder(WL.ModOrderControl.Skip);
				return;
			end
		end
		if(order.Message == "Buy Order Delay Card")then
			if(order.CostOpt[WL.ResourceType.Gold]== Mod.Settings.OrderDelayCardCost)then
				if(game.Settings.Cards[WL.CardID.OrderDelay] ~= nil)then
					local cardinstance = WL.NoParameterCardInstance.Create(WL.CardID.OrderDelay);
					addNewOrder(WL.GameOrderReceiveCard.Create(order.PlayerID, {cardinstance}));
				else
					--somehow the card got purchased even though it is not in the game
					skipThisOrder(WL.ModOrderControl.Skip);
					return;
				end
			else
				--price got manipulated
				skipThisOrder(WL.ModOrderControl.Skip);
				return;
			end
		end
		if(order.Message == "Buy Airlift Card")then
			if(order.CostOpt[WL.ResourceType.Gold]== Mod.Settings.AirliftCardCost)then
				if(game.Settings.Cards[WL.CardID.Airlift] ~= nil)then
					local cardinstance = WL.NoParameterCardInstance.Create(WL.CardID.Airlift);
					addNewOrder(WL.GameOrderReceiveCard.Create(order.PlayerID, {cardinstance}));
				else
					--somehow the card got purchased even though it is not in the game
					skipThisOrder(WL.ModOrderControl.Skip);
					return;
				end
			else
				--price got manipulated
				skipThisOrder(WL.ModOrderControl.Skip);
				return;
			end
		end
		if(order.Message == "Buy Diplomacy Card")then
			if(order.CostOpt[WL.ResourceType.Gold]== Mod.Settings.DiplomacyCardCost)then
				if(game.Settings.Cards[WL.CardID.Diplomacy] ~= nil)then
					local cardinstance = WL.NoParameterCardInstance.Create(WL.CardID.Diplomacy);
					addNewOrder(WL.GameOrderReceiveCard.Create(order.PlayerID, {cardinstance}));
				else
					--somehow the card got purchased even though it is not in the game
					skipThisOrder(WL.ModOrderControl.Skip);
					return;
				end
			else
				--price got manipulated
				skipThisOrder(WL.ModOrderControl.Skip);
				return;
			end
		end
		if(order.Message == "Buy Sanctions Card")then
			if(order.CostOpt[WL.ResourceType.Gold]== Mod.Settings.SanctionsCardCost)then
				if(game.Settings.Cards[WL.CardID.Sanctions] ~= nil)then
					local cardinstance = WL.NoParameterCardInstance.Create(WL.CardID.Sanctions);
					addNewOrder(WL.GameOrderReceiveCard.Create(order.PlayerID, {cardinstance}));
				else
					--somehow the card got purchased even though it is not in the game
					skipThisOrder(WL.ModOrderControl.Skip);
					return;
				end
			else
				--price got manipulated
				skipThisOrder(WL.ModOrderControl.Skip);
				return;
			end
		end
		if(order.Message == "Buy Reconnaissance Card")then
			if(order.CostOpt[WL.ResourceType.Gold]== Mod.Settings.ReconnaissanceCardCost)then
				if(game.Settings.Cards[WL.CardID.Reconnaissance] ~= nil)then
					local cardinstance = WL.NoParameterCardInstance.Create(WL.CardID.Reconnaissance);
					addNewOrder(WL.GameOrderReceiveCard.Create(order.PlayerID, {cardinstance}));
				else
					--somehow the card got purchased even though it is not in the game
					skipThisOrder(WL.ModOrderControl.Skip);
					return;
				end
			else
				--price got manipulated
				skipThisOrder(WL.ModOrderControl.Skip);
				return;
			end
		end
		if(order.Message == "Buy Surveillance Card")then
			if(order.CostOpt[WL.ResourceType.Gold]== Mod.Settings.SurveillanceCardCost)then
				if(game.Settings.Cards[WL.CardID.Surveillance] ~= nil)then
					local cardinstance = WL.NoParameterCardInstance.Create(WL.CardID.Surveillance);
					addNewOrder(WL.GameOrderReceiveCard.Create(order.PlayerID, {cardinstance}));
				else
					--somehow the card got purchased even though it is not in the game
					skipThisOrder(WL.ModOrderControl.Skip);
					return;
				end
			else
				--price got manipulated
				skipThisOrder(WL.ModOrderControl.Skip);
				return;
			end
		end
		if(order.Message == "Buy Bomb Card")then
			if(order.CostOpt[WL.ResourceType.Gold]== Mod.Settings.BombCardCost)then
				if(game.Settings.Cards[WL.CardID.Bomb] ~= nil)then
					local cardinstance = WL.NoParameterCardInstance.Create(WL.CardID.Bomb);
					addNewOrder(WL.GameOrderReceiveCard.Create(order.PlayerID, {cardinstance}));
				else
					--somehow the card got purchased even though it is not in the game
					skipThisOrder(WL.ModOrderControl.Skip);
					return;
				end
			else
				--price got manipulated
				skipThisOrder(WL.ModOrderControl.Skip);
				return;
			end
		end
	end
end
function tablelength(T)
	local count = 0;
	for _,elem in pairs(T)do
		count = count + 1;
	end
	return count;
end
function stringtochararray(variable)
	chartable = {};
	while(string.len(variable)>0)do
		chartable[tablelength(chartable)] = string.sub(variable, 1 , 1);
		variable = string.sub(variable, 2);
	end
	return chartable;
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
