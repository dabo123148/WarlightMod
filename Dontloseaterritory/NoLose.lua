function NoLose(game, standing)
print('test0');
	local Territoryanzahl = 0;
	for _, terr in pairs(standing.Territories) do
		Territoryanzahl = Territoryanzahl+1;
	end
	print('testabc');
	local Zahl = math.random(0,Territoryanzahl-1);
	while(standing.Territories[Zahl].OwnerPlayerID == WL.PlayerID.Neutral) do
		Zahl = math.random(0,Territoryanzahl-1);
	end
	print('testtedas');
	local territory = standing.Territories[Zahl];
	print('test1');
	Mod.Settings.Spieler = territory.OwnerPlayerID;
	if(Mod.Settings.StartArmies == nil) then
		Mod.Settings.StartArmies=5;
	end
    local newArmiesCount = Mod.Settings.StartArmies;
	print('test2');
	if (newArmiesCount < 0) then newArmiesCount = 0 end;
	if (newArmiesCount > 100000) then newArmiesCount = 100000 end;
	print('test3');
	for _, allterritory in pairs(standing.Territories) do
	print('test4');
		if(allterritory.OwnerPlayerID == Mod.Settings.Spieler) then
		print('test5');
			allterritory.NumArmies = WL.Armies.Create(newArmiesCount,{WL.Commander.Create(Mod.Settings.Spieler)});
			print('test6');
		end
	end
end
