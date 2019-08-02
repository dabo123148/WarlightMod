function Client_PresentMenuUI(rootParent, setMaxSize, setScrollable, game)
	Game = game;
	root = rootParent;
	setMaxSize(450, 350);
	if(Mod.PublicGameData.War ==nil)then
		UI.CreateLabel(horz).SetText("This menu is not avalible in distribution");
		return;
	end
	--printing in order to visualize the bug
	print("Testlenght " .. tablelength(Mod.PublicGameData.War));
	for key,pd in pairs(Mod.PublicGameData.War)do
		print("Key(playerid out of Server_StartGame.lua: " .. key);
	end
	for _,pd in pairs(Game.Game.PlayingPlayers)do
		print("Playerid in  Client_PresentMenuUI.lua: " .. pd.ID);
		if(Mod.PublicGameData.War[Game.Us.ID] == {} or Mod.PublicGameData.War[pd.ID] ~= nil)then
			vert = UI.CreateVerticalLayoutGroup(rootParent);
			UI.CreateLabel(vert).SetText("If this is printed then there is no bug existend, otherwise the mod can not see the data that is stored with the same playerid");
			print("If this is printed then there is no bug existend, otherwise it can not see the data that is stored with the same playerid");
		end
	end
	vert2 = UI.CreateVerticalLayoutGroup(rootParent);
	UI.CreateLabel(vert2).SetText("If you only see this message, then the data is using a different playerid");
end
function  tablelength(T)
	local count = 0;
	if(T==nil)then
		return 0;
	end
	for _, elem in pairs(T)do
		count = count + 1;
	end
	return count;
end
