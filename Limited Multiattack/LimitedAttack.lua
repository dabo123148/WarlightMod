function LimitedAttack(game, standing)
   	local Maximaleangriffe = Mod.Settings.MaxAttacks;
	if (Maximaleangriffe < 1) then Maximaleangriffe = 1 end;
	if (Maximaleangriffe > 100000) then Maximaleangriffe = 100000 end;
	Mod.Settings.UbrigeAngriffe = {};
	for _, allterritory in pairs(game.Map.Territories) do
		Mod.Settings.UbrigeAngriffe[allterritory.ID] = Maximaleangriffe;
	end
end