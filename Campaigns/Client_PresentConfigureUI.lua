
function Client_PresentConfigureUI(rootParent)
	PubRoot=rootParent;
	local initialValue1 = Mod.Settings.Campaign;
	if initialValue1 == nil then initialValue1 = {}; end
	
	lineCount=0;
	lines = {};
	fields = {};
	
        vert1 = UI.CreateVerticalLayoutGroup(PubRoot);
	UI.CreateLabel(vert1).SetText('Your Campaign. Enter Commands.');
	horz=UI.CreateHorizontalLayoutGroup(vert1);
	button1 = UI.CreateButton(horz);
	button1.SetText('Add Line');
	button1.SetOnClick(AddLine);
	button2 = UI.CreateButton(horz);
	button2.SetText('Delete Line');
	button2.SetOnClick(AddLine);
	numbin1 = UI.CreateNumberInputField(horz).SetValue(1).SetPreferredWidth(50).SetPreferredHeight(30).SetSliderMinValue(1).SetSliderMaxValue(1);
	lineCount=lineCount+1;
	lines[lineCount]=UI.CreateHorizontalLayoutGroup(PubRoot);
	local Numberindex=UI.CreateLabel(lines[lineCount]).SetText('l'..lineCount..':');
	fields[lineCount] = UI.CreateTextInputField(lines[lineCount]).SetPreferredWidth(500).SetPreferredHeight(30).SetPlaceholderText('Add Command');
	

end

function AddLine()
	lineCount=lineCount+1;
	lines[lineCount]=UI.CreateHorizontalLayoutGroup(PubRoot);
	local Numberindex=UI.CreateLabel(lines[lineCount]).SetText('l'..lineCount..':');
	fields[lineCount] = UI.CreateTextInputField(lines[lineCount]).SetPreferredWidth(500).SetPreferredHeight(30).SetPlaceholderText('Add Command');
	UI.Destroy(numbin1);
	numbin1 = UI.CreateNumberInputField(horz).SetValue(1).SetPreferredWidth(50).SetPreferredHeight(30).SetSliderMinValue(1).SetSliderMaxValue(lineCount);
end
