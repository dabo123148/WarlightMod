function Client_PresentMenuUI(rootParent, setMaxSize, setScrollable, game)
	Game = game;
	setMaxSize(450, 250);
	vert = UI.CreateVerticalLayoutGroup(rootParent);
	if (game.Us == nil) then
		UI.CreateLabel(vert).SetText("You cannot use the Diplomacy game, cause you aren't in the game");
		return;
	end
  	local horz = UI.CreateHorizontalLayoutGroup(vert);
 	UI.CreateLabel(horz).SetText('Current Money: ' .. Mod.PlayerGameData.Money);
	local horz = UI.CreateHorizontalLayoutGroup(vert);
	UI.CreateLabel(horz).SetText("Shop");
	openshopbutton = UI.CreateButton(horz).SetText("Shop").SetOnClick(Openshop);
 	local horz = UI.CreateHorizontalLayoutGroup(vert);
 	UI.CreateLabel(horz).SetText("Declar War");
	declarewarbutton = UI.CreateButton(horz).SetText("Declar War").SetOnClick(OpenDeclarWar);
 	local horz = UI.CreateHorizontalLayoutGroup(vert);
	UI.CreateLabel(horz).SetText("Auto Deployer");
	offerpeacebutton = UI.CreateButton(horz).SetText("Offer Peace").SetOnClick(OpenOfferPeace);
	local horz = UI.CreateHorizontalLayoutGroup(vert);
	UI.CreateLabel(horz).SetText("Offer Allianze");
	offerallianzebutton = UI.CreateButton(horz).SetText("Offer Allianze").SetOnClick(OpenOfferAllianze);
  	local horz = UI.CreateHorizontalLayoutGroup(vert);
  	UI.CreateLabel(horz).SetText("Pending Requests");
	offerallianzebutton = UI.CreateButton(horz).SetText("Pending Requests").SetOnClick(OpenPendingRequests);
end
function Openshop()
  DeleteUI();
end
function DeleteUI()

end
function  tablelength(T)
	local count = 0;
	for _, elem in pairs(T)do
		count = count + 1;
	end
	return count;
end
