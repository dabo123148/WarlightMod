
function Client_PresentConfigureUI(rootParent)
	local initialValue1 = Mod.Settings.Campaign;
	if initialValue1 == nil then initialValue1 = {}; end
	
	lineCount=0;

        vert1 = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(vert1).SetText('Your Campaign. Enter Commands.');
	button1 = UI.CreateButton(vert1);
	button1.SetText('Add Line');
	button1.SetOnClick(AddLine);
	lines = {};
	

end

function AddLine()
	lineCount=lineCount+1;
	UI.Destroy(button1);
	lines[lineCount]=UI.CreateTextInputField(vert1);
	button1 = UI.CreateButton(vert1);
	button1.SetText('Add Line');
	button1.SetOnClick(AddLine);
end
