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
	print('T1');
	print('T2');
	for _, terr in pairs(Game.LatestStanding.Territories)do
		print('T3');
		if(terr.OwnerPlayerID == myID)then
			print('T4');
			print(myID);
			print('T5');
			--print(Mod.Settings.PestilenceStrength);
			print('T6');
			print(terr.ID);
			print('T7');
			--print(WL.GameOrderDeploy.Create(myID, Mod.Settings.PestilenceStrength, terr.ID));
			print('T8');
			table.insert(orders, WL.GameOrderDeploy.Create(myID, 1, terr.ID));
			print('T9');
		end
	end
end
function  tablelength(T)
	local count = 0;
	for _, elem in pairs(T)do
		count = count + 1;
	end
	return count;
end
