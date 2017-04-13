function Server_Created(game, settings)
    local overriddenBonuses = {};
	overriddenTerris = {};
    for _, bonus in pairs(game.Map.Bonuses) do
		--skip negative bonuses unless AllowNegative was checked
		if (bonus.Amount > 0 or Mod.Settings.AllowNegative) then 
			--local rndAmount = math.random(-Mod.Settings.BonusValue, Mod.Settings.BonusValue);

			--if (rndAmount ~= 0) then --don't do anything if we're not changing the bonus.  We could leave this check off and it would work, but it show up in Settings as an overridden bonus when it's not.

				local newValue = bonus.Amount;

				-- don't take a positive or zero bonus negative unless AllowNegative was checked.
				--if (newValue < 0 and not Mod.Settings.AllowNegative) then
				--	newValue = 0;
				--end
				rndAmount=math.random(1,100);
				if (rndAmount<=Mod.Settings.Chance) then
					if (tablelength(bonus.Territories)<=Mod.Settings.MaxBonus) then
						newValue=Mod.Settings.BonusValue*tablelength(bonus.Territories);
						for _, terr in pairs(bonus.Territories) do
							overriddenTerris[terr.ID]=true;
						end
					end
				end
				-- -1000 to +1000 is the maximum allowed range for overridden bonuses, never go beyond that
				if (newValue < -1000) then newValue = -1000 end;
				if (newValue > 1000) then newValue = 1000 end;
		
				overriddenBonuses[bonus.ID] = newValue;
			--end
		end
    end

    settings.OverriddenBonuses = overriddenBonuses;

end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end