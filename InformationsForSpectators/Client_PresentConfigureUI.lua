
function Client_PresentConfigureUI(rootParent)
	rootParentobj = rootParent;
	JustSpectatorinit = Mod.Settings.JustSpectator;
	if(JustSpectatorinit == nil)then
		JustSpectatorinit = true;
	end
	ShowUI();
end
function ShowUI()
	local horz = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputJustSpectator = UI.CreateCheckBox(horz).SetText('Just Spectators can see the data').SetIsChecked(JustSpectatorinit);
end
