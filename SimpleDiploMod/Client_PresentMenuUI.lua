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
	OpenMenu(rootParent);
end
function OpenMenu(rootParent)
	DeleteUI();
	local horz = UI.CreateHorizontalLayoutGroup(vert);
	--UI.CreateLabel(horz).SetText("Shop");
	openshopbutton = UI.CreateButton(horz).SetText("Shop").SetOnClick(Openshop);
 	local horz = UI.CreateHorizontalLayoutGroup(vert);
 	--UI.CreateLabel(horz).SetText("Declare War");
	declarewarbutton = UI.CreateButton(horz).SetText("Declare War").SetOnClick(OpenDeclarWar);
 	local horz = UI.CreateHorizontalLayoutGroup(vert);
	--UI.CreateLabel(horz).SetText("Offer Peace");
	offerpeacebutton = UI.CreateButton(horz).SetText("Offer Peace").SetOnClick(OpenOfferPeace);
	local horz = UI.CreateHorizontalLayoutGroup(vert);
	--UI.CreateLabel(horz).SetText("Offer Allianze");
	offerallianzebutton = UI.CreateButton(horz).SetText("Offer Alliance").SetOnClick(OpenOfferAlliance);
  	local horz = UI.CreateHorizontalLayoutGroup(vert);
  	--UI.CreateLabel(horz).SetText("Pending Requests");
	pendingrequestbutton = UI.CreateButton(horz).SetText("Pending Requests").SetOnClick(OpenPendingRequests);
end
function Openshop(rootParent)
	--DeleteUI();
end
function OpenDeclarWar(rootParent)
	DeleteUI();
end
function DeleteUI()
	if(openshopbutton ~= nil)then
		UI.Destroy(openshopbutton);
		openshopbutton = nil;
	end
	if(declarewarbutton ~= nil)then
		UI.Destroy(declarewarbutton);
		declarewarbutton = nil;
	end
	if(offerpeacebutton ~= nil)then
		UI.Destroy(offerpeacebutton);
		offerpeacebutton = nil;
	end
	if(offerallianzebutton ~= nil)then
		UI.Destroy(offerallianzebutton);
		offerallianzebutton = nil;
	end
	if(pendingrequestbutton ~= nil)then
		UI.Destroy(pendingrequestbutton);
		pendingrequestbutton = nil;
	end
end
function  tablelength(T)
	local count = 0;
	for _, elem in pairs(T)do
		count = count + 1;
	end
	return count;
end
