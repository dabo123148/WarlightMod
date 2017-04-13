function Server_StartDistribution(game, standing)
    for _, terr in pairs(standing.Territories) do
		if not overriddenTerris[terr.ID]==nil then
			if overriddenTerris[terr.ID]==true and terr.IsNeutral then
				terr.NumArmies = Mod.Settings.TroopValue;
			end
		end
	end
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end