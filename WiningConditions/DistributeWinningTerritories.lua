function DistributeItems(game, standing)

    for _,condition in pairs(Mod.Settings.terrcondition)do
	local terrid = getterrid(game,condition.Terrname);
      if(terrid ~= -1) then
        local s = standing.Territories[terrid].Structures;
        if (s == nil) then 
          s = {}; 
        end;
        if(s[WL.StructureType.Arena] == nil) then
          s[WL.StructureType.Arena] = 1;
        end
        standing.Territories[terrid].Structures = s;
      end
    end

end
function getterrid(game,name)
	for _,terr in pairs(game.Map.Territories)do
		if(terr.Name == name)then
			return terr.ID;
		end
	end
	return -1;
end
