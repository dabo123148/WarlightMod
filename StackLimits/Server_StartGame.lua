function Server_StartGame(game, standing)
	local Stacklimit = Mod.Settings.StackLimit;
	local EffectNeutral = Mod.Settings.IncludeNeutral;
	for _, territory in pairs(standing.Territories) do
		local armiesonterritoy = territory.NumArmies.NumArmies;
		if(armiesonterritoy > Stacklimit)then
			if(territory.OwnerPlayerID ~= WL.PlayerID.Neutral or (territory.OwnerPlayerID == WL.PlayerID.Neutral and EffectNeutral == false))then
				territory.NumArmies = WL.Armies.Create(Stacklimit,territory.NumArmies.SpecialUnits);
			end
        end
  	end
end

