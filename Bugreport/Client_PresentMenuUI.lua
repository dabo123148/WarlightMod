require('History');
function Client_PresentMenuUI(rootParent, setMaxSize, setScrollable, game)
	alreadyrefreshed = true;
	Game = game;
	root = rootParent;
	setMaxSize(450, 350);
	if(game.Us == nil) then
		vert = UI.CreateVerticalLayoutGroup(rootParent);
		UI.CreateLabel(vert).SetText("You cannot use the mod, cause you aren't in the game");
		return;
	end
	horz = UI.CreateHorizontalLayoutGroup(root);
	if(game.Game.PlayingPlayers[game.Us.ID] == nil)then
		UI.CreateLabel(horz).SetText("You have been eliminated, so you are no longer able to interact with the mod");
		return;
	end
	UI.CreateButton(horz).SetText("Send message").SetOnClick(sendmessagetoserver);
end
function sendmessagetoserver()
	Game.SendGameCustomMessage("Sending request...", payload, function(returnvalue)
		alreadyrefreshed = false;
		UI.Alert(returnvalue.Message);
	end);
end