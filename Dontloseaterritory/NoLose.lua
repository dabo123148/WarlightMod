function NoLose(game, standing)
	local Territoryanzahl = 0;
	for _, terr in pairs(standing.Territories) do
		Territoryanzahl = Territoryanzahl+1;
	end
	local Zahl = math.random(0,Territoryanzahl-1);
	while(standing.Territories[Zahl] == nil) do
		Zahl = math.random(0,Territoryanzahl-1);
	end
	while(standing.Territories[Zahl].OwnerPlayerID == WL.PlayerID.Neutral) do
		Zahl = math.random(0,Territoryanzahl-1);
		while(standing.Territories[Zahl] == nil)do
			Zahl = math.random(0,Territoryanzahl-1);
		end
	end
	local territory = standing.Territories[Zahl];
	Mod.Settings.Spieler = territory.OwnerPlayerID;
	if(Mod.Settings.StartArmies == nil) then
		Mod.Settings.StartArmies=5;
	end
   	local newArmiesCount = Mod.Settings.StartArmies;
	if (newArmiesCount < 0) then newArmiesCount = 0 end;
	if (newArmiesCount > 100000) then newArmiesCount = 100000 end;
	Mod.Settings.CreatedCommander = {};
	for _, allterritory in pairs(standing.Territories) do
		if(allterritory.OwnerPlayerID == Mod.Settings.Spieler) then
			allterritory.NumArmies = WL.Armies.Create(newArmiesCount,{WL.Commander.Create(Mod.Settings.Spieler)});
			for _, sunit in pairs(allterritory.NumArmies.SpecialUnits) do
				Mod.Settings.CreatedCommander[tablelength(Mod.Settings.CreatedCommander)] = sunit;
			end
		end
	end
end
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
