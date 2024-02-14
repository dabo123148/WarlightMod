local payload = 'NeutralMoves_ServerAdvanceTurnEnd';
local executed = false;

function Server_AdvanceTurn_Start(game, addNewOrder)
	if Mod.PublicGameData.cantRun ~= nil then
		return;
	end

	local publicGD = Mod.PublicGameData;
	local cantRun = false;
	local maxTerrs = 500;
	local terrCount = 0;

	for _ in pairs(game.Map.Territories) do
		terrCount = terrCount + 1;

		if terrCount > maxTerrs then
			cantRun = true;
			break;
		end
	end

	publicGD.cantRun = cantRun;
	Mod.PublicGameData = publicGD;
end

function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	if Mod.PublicGameData.cantRun then
		return;
	end

	if order.proxyType == 'GameOrderCustom' and order.Payload == payload then
		-- like this so that mod receives correct standing and no other mods change it
		skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);

		if not executed then
			main(game, addNewOrder);
			executed = true;
		end
	end
end

function Server_AdvanceTurn_End(game, addNewOrder)
	addNewOrder(WL.GameOrderCustom.Create(getFirstPlayer(game), '', payload));
end

function getFirstPlayer(game)
	-- neutral isn't allowed for game order custom
	for playerId in pairs(game.ServerGame.Game.Players) do
		return playerId;
	end
end

function main(game, addNewOrder)
	if Mod.PublicGameData.cantRun then
		return;
	end

	local armiesRemaining = {};
	local armiesAdded = {};

	for _, terr in pairs(game.ServerGame.LatestTurnStanding.Territories) do
		if terr.OwnerPlayerID == WL.PlayerID.Neutral then
			for _, conn in pairs(game.Map.Territories[terr.ID].ConnectedTo) do
				local connTerr = game.ServerGame.LatestTurnStanding.Territories[conn.ID];

				if connTerr.OwnerPlayerID == WL.PlayerID.Neutral then
					local remaining = armiesRemaining[terr.ID] or terr.NumArmies.NumArmies;
					local taken = math.random(0, remaining);

					if taken > 0 then
						armiesRemaining[terr.ID] = remaining - taken;
						armiesRemaining[conn.ID] = (armiesRemaining[conn.ID] or connTerr.NumArmies.NumArmies) + taken;

						armiesAdded[terr.ID] = (armiesAdded[terr.ID] or 0) - taken;
						armiesAdded[conn.ID] = (armiesAdded[conn.ID] or 0) + taken;
					end
				end
			end
		end
	end

	local terrMods = {};

	for terrId, armiesToAdd in pairs(armiesAdded) do
		if armiesToAdd ~= 0 then
			local terrMod = WL.TerritoryModification.Create(terrId);
			terrMod.AddArmies = armiesToAdd;
			table.insert(terrMods, terrMod);
		end
	end

	addNewOrder(WL.GameOrderEvent.Create(WL.PlayerID.Neutral, 'Neutral_Move', {}, terrMods));
end
