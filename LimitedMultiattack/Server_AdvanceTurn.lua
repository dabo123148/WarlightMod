function Server_AdvanceTurn_Start (game,addNewOrder)
	boundtoacard=false;
	if(Mod.Settings.ReinforcementCard ~= nil)then
		if(Mod.Settings.ReinforcementCard)then
			boundtoacard=true;
		end
	end
	if(Mod.Settings.GiftCard ~= nil)then
		if(Mod.Settings.GiftCard)then
			boundtoacard=true;
		end
	end
	if(Mod.Settings.AirliftCard ~= nil)then
		if(Mod.Settings.AirliftCard)then
			boundtoacard=true;
		end
	end
	if(Mod.Settings.SpyCard ~= nil)then
		if(Mod.Settings.SpyCard)then
			boundtoacard=true;
		end
	end
	if(Mod.Settings.SurveillanceCard ~= nil)then
		if(Mod.Settings.SurveillanceCard)then
			boundtoacard=true;
		end
	end
	if(Mod.Settings.ReconnaisanceCard ~= nil)then
		if(Mod.Settings.ReconnaisanceCard)then
			boundtoacard=true;
		end
	end
	UbrigeAngriffe={};
	local Maximaleangriffe = Mod.Settings.MaxAttacks;
	if (Maximaleangriffe < 1) then Maximaleangriffe = 1 end;
	if (Maximaleangriffe > 100000) then Maximaleangriffe = 100000 end;
	activated = {};
	for _, terr in pairs(game.ServerGame.LatestTurnStanding.Territories) do
		activated[terr.OwnerPlayerID] = false;
		if(boundtoacard)then
			UbrigeAngriffe[terr.ID] = 1;
		else
			UbrigeAngriffe[terr.ID] = Maximaleangriffe;
		end
	end
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	--result GameOrderAttackTransferResult
	--order GameOrderAttackTransfer
	if(boundtoacard)then
		if(Mod.Settings.AirliftCard ~= nil)then
			if(Mod.Settings.AirliftCard)then
				if(order.proxyType == 'GameOrderPlayCardAirlift') then
					activated[order.PlayerID] = true;
					local Maximaleangriffe = Mod.Settings.MaxAttacks;
					if (Maximaleangriffe < 1) then Maximaleangriffe = 1 end;
					if (Maximaleangriffe > 100000) then Maximaleangriffe = 100000 end;
					for _, terr in pairs(game.ServerGame.LatestTurnStanding.Territories) do
						if(terr.OwnerPlayerID == order.PlayerID)then
							UbrigeAngriffe[terr.ID] = Maximaleangriffe;
						end
					end
				end
			end
		end
		if(Mod.Settings.ReinforcementCard ~= nil)then
			if(Mod.Settings.ReinforcementCard)then
				if(order.proxyType == 'GameOrderPlayCardReinforcement') then
					activated[order.PlayerID] = true;
					local Maximaleangriffe = Mod.Settings.MaxAttacks;
					if (Maximaleangriffe < 1) then Maximaleangriffe = 1 end;
					if (Maximaleangriffe > 100000) then Maximaleangriffe = 100000 end;
					for _, terr in pairs(game.ServerGame.LatestTurnStanding.Territories) do
						if(terr.OwnerPlayerID == order.PlayerID)then
							UbrigeAngriffe[terr.ID] = Maximaleangriffe;
						end
					end
				end
			end
		end
		if(Mod.Settings.GiftCard ~= nil)then
			if(Mod.Settings.GiftCard)then
				if(order.proxyType == 'GameOrderPlayCardGift') then
					activated[order.PlayerID] = true;
					local Maximaleangriffe = Mod.Settings.MaxAttacks;
					if (Maximaleangriffe < 1) then Maximaleangriffe = 1 end;
					if (Maximaleangriffe > 100000) then Maximaleangriffe = 100000 end;
					for _, terr in pairs(game.ServerGame.LatestTurnStanding.Territories) do
						if(terr.OwnerPlayerID == order.PlayerID)then
							UbrigeAngriffe[terr.ID] = Maximaleangriffe;
						end
					end
				end
			end
		end
		if(Mod.Settings.SpyCard ~= nil)then
			if(Mod.Settings.SpyCard)then
				if(order.proxyType == 'GameOrderPlayCardSpy') then
					activated[order.PlayerID] = true;
					local Maximaleangriffe = Mod.Settings.MaxAttacks;
					if (Maximaleangriffe < 1) then Maximaleangriffe = 1 end;
					if (Maximaleangriffe > 100000) then Maximaleangriffe = 100000 end;
					for _, terr in pairs(game.ServerGame.LatestTurnStanding.Territories) do
						if(terr.OwnerPlayerID == order.PlayerID)then
							UbrigeAngriffe[terr.ID] = Maximaleangriffe;
						end
					end
				end
			end
		end
		if(Mod.Settings.ReconnaisanceCard ~= nil)then
			if(Mod.Settings.ReconnaisanceCard)then
				if(order.proxyType == 'GameOrderPlayCardReconnaissance') then
					activated[order.PlayerID] = true;
					local Maximaleangriffe = Mod.Settings.MaxAttacks;
					if (Maximaleangriffe < 1) then Maximaleangriffe = 1 end;
					if (Maximaleangriffe > 100000) then Maximaleangriffe = 100000 end;
					for _, terr in pairs(game.ServerGame.LatestTurnStanding.Territories) do
						if(terr.OwnerPlayerID == order.PlayerID)then
							UbrigeAngriffe[terr.ID] = Maximaleangriffe;
						end
					end
				end
			end
		end
		if(Mod.Settings.SurveillanceCard ~= nil)then
			if(Mod.Settings.SurveillanceCard)then
				if(order.proxyType == 'GameOrderPlayCardSurveillance') then
					activated[order.PlayerID] = true;
					local Maximaleangriffe = Mod.Settings.MaxAttacks;
					if (Maximaleangriffe < 1) then Maximaleangriffe = 1 end;
					if (Maximaleangriffe > 100000) then Maximaleangriffe = 100000 end;
					for _, terr in pairs(game.ServerGame.LatestTurnStanding.Territories) do
						if(terr.OwnerPlayerID == order.PlayerID)then
							UbrigeAngriffe[terr.ID] = Maximaleangriffe;
						end
					end
				end
			end
		end
	end
	if(order.proxyType == 'GameOrderAttackTransfer') then
		-- it says in the mod configuration that when MaxAttacks set to 0 there is unlimited multi attacks, but I believe you get an alert of you set it to 0
		if(UbrigeAngriffe[order.From] > 0 or (activated[order.PlayerID] and Mod.Settings.MaxAttacks == 0))then
			if(result.IsSuccessful)then
				-- check if the attack was a transfer, if this is the case do nothing
				-- Warzone itself makes sure these armies are not able to move again
				if(game.ServerGame.LatestTurnStanding.Territories[order.From].OwnerPlayerID ~= game.ServerGame.LatestTurnStanding.Territories[order.To].OwnerPlayerID)then
					-- order was an attack, so we can set the table value at order.To to the table value at order.From - 1
					UbrigeAngriffe[order.To] = UbrigeAngriffe[order.From] - 1;
				end
			else
				if(order.PlayerID == game.ServerGame.LatestTurnStanding.Territories[order.From].OwnerPlayerID)then
					if(Mod.Settings.ContinueAttackIfFailed == nil or Mod.Settings.ContinueAttackIfFailed == false)then
						UbrigeAngriffe[order.From] = -1;
					end
				end
			end
		else
			skipThisOrder(WL.ModOrderControl.Skip);
		end
	end
end
