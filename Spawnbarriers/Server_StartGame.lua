require('Spawnbarriers')

function Server_StartGame(game, standing)

	--Don't do anything in StartGame if we're a manual dist game (the wastelands would already have been randomized in Server_StartDistribution, we don't want to change them again or it would be a big surprise after picks)
	if (game.Settings.AutomaticTerritoryDistribution) then
		Spawnbarriers(game, standing);
	end

end

