function Client_PresentMenuUI(rootParent, setMaxSize, setScrollable, game)
	root = rootParent;
	setMaxSize(450, 350);
	if(Mod.PublicGameData.War ==nil)then
		UI.CreateLabel(horz).SetText("This menu is not avalible in distribution");
		return;
	end
	--printing in order to visualize the bug
	for key,pd in pairs(Mod.PublicGameData.War)do
		print(key .. " " .. pd);
		vert = UI.CreateVerticalLayoutGroup(rootParent);
		UI.CreateLabel(vert).SetText("Key " .. key .. " Real Key: " .. pd);
	end
end
