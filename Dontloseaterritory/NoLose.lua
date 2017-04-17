function NoLose(game, standing)
	--Couting territorys
	local Territoryanzahl = tablelength(standing.Territories);
	--picking a random not neutral territory
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
	--giving every starting territory of the owner of the random player a commander
	local territory = standing.Territories[Zahl];
	Mod.Settings.Spieler = territory.OwnerPlayerID;--Saving the player(must be changed)
	if(Mod.Settings.StartArmies == nil) then
		Mod.Settings.StartArmies=5;
	end
   	local newArmiesCount = Mod.Settings.StartArmies;
	if (newArmiesCount < 0) then newArmiesCount = 0 end;
	if (newArmiesCount > 100000) then newArmiesCount = 100000 end;
	for _, allterritory in pairs(standing.Territories) do
		if(allterritory.OwnerPlayerID == Mod.Settings.Spieler) then
			allterritory.NumArmies = WL.Armies.Create(newArmiesCount,{WL.Commander.Create(Mod.Settings.Spieler)});
			--In a earlyer version of the mod, I saved the commander id for checking if the commander who tries to move is
			--one of the commander I created
		end
	end
end
--Counting the elements in a table
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
