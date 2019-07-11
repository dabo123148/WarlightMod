function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)	
	if(order.proxyType == 'GameOrderDeploy')then
		if(order.PlayerID ~= WL.PlayerID.Neutral)then
			if(game.ServerGame.Game.Players[order.PlayerID].IsAIOrHumanTurnedIntoAI == true)then
				skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);
			end
		end
	end
end