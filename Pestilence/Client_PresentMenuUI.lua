function Client_PresentMenuUI(rootParent, setMaxSize, setScrollable, game)
	Game = game;
	setMaxSize(450, 250);
	vert = UI.CreateVerticalLayoutGroup(rootParent);
	if (game.Us == nil) then
		UI.CreateLabel(vert).SetText("You cannot use the Auto Deployer cause you aren't in the game");
		return;
	end
	local horz = UI.CreateHorizontalLayoutGroup(vert);
	UI.CreateLabel(horz).SetText("Auto Deployer");
	makeorderbutton = UI.CreateButton(horz).SetText("Run").SetOnClick(makeorders);
end
function makeorders()
	local orders = Game.Orders;
	local myID = Game.Us.ID;
	for _, terr in pairs(Game.LatestStanding.Territories)do
		if(terr.OwnerPlayerID == myID and tablelength(terr.NumArmies.SpecialUnits)==0)then
			table.insert(orders, WL.GameOrderDeploy.Create(myID, Mod.Settings.PestilenceStrength, terr.ID));
		end
	end
	Game.Orders = orders;
end
function  tablelength(T)
	local count = 0;
	for _, elem in pairs(T)do
		count = count + 1;
	end
	return count;
end
