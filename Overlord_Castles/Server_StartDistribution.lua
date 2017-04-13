function Server_StartDistribution(game, standing)
	overriddenTerris=Mod.Settings.OverriddenTerris;

    for _, terr in pairs(standing.Territories) do
		print('ID: ' .. terr.ID .. ', Arr: ' .. overriddenTerris[terr.ID]);
		if (overriddenTerris[terr.ID]~=nil) then
			if (overriddenTerris[terr.ID]==1) then
				if(terr.IsNeutral) then
					print('Tried NumArmyChange');
					terr.NumArmies = WL.Armies.Create(Mod.Settings.TroopValue);
				end
			end
		end
	end
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
