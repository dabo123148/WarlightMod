
function Client_PresentConfigureUI(rootParent)
	PubRoot=rootParent;
	local initialValue1 = Mod.Settings.Campaign;
	if initialValue1 == nil then initialValue1 = {}; end
	
	lineCount=0;
	
        vert1 = UI.CreateVerticalLayoutGroup(PubRoot);
	UI.CreateLabel(vert1).SetText('Your Campaign. Enter Commands.');
	button1 = UI.CreateButton(vert1);
	button1.SetText('Add Line');
	button1.SetOnClick(AddLine);
	lines = {};
	fields = {};

end

function AddLine()
	lineCount=lineCount+1;
	UI.Destroy(button1);
	lines[lineCount]=UI.CreateHorizontalLayoutGroup(PubRoot);
	local Numberindex=UI.CreateLabel(lines[lineCount]).SetText('lineCount');
	fields[lineCount] = UI.CreateTextInputField(lines[lineCount]).SetPreferredWidth(500).SetPreferredHeight(30).SetPlaceholderText('Add Command');
	button1 = UI.CreateButton(vert1);
	button1.SetText('Add Line');
	button1.SetOnClick(AddLine);
end
