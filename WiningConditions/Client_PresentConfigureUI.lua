
function Client_PresentConfigureUI(rootParent)
	rootParentobj = rootParent;
	Conditionsrequiredforwinit = Mod.Settings.Conditionsrequiredforwin;
	if(Conditionsrequiredforwinit == nil)then
		Conditionsrequiredforwinit = 1;
	end
	Capturedterritoriesinit = Mod.Settings.Capturedterritories;
	if(Capturedterritoriesinit == nil)then
		Capturedterritoriesinit = 0;
	end
	Lostterritoriesinit = Mod.Settings.Lostterritories;
	if(Lostterritoriesinit == nil)then
		Lostterritoriesinit = 0;
	end
	Ownedterritoriesinit = Mod.Settings.Ownedterritories;
	if(Ownedterritoriesinit == nil)then
		Ownedterritoriesinit = 0;
	end
	Capturedbonusesinit = Mod.Settings.Capturedbonuses;
	if(Capturedbonusesinit == nil)then
		Capturedbonusesinit = 0;
	end
	Lostbonusesinit = Mod.Settings.Lostbonuses;
	if(Lostbonusesinit == nil)then
		Lostbonusesinit = 0;
	end
	Ownedbonusesinit = Mod.Settings.Ownedbonuses;
	if(Ownedbonusesinit == nil)then
		Ownedbonusesinit = 0;
	end
	Killedarmiesinit = Mod.Settings.Killedarmies;
	if(Killedarmiesinit == nil)then
		Killedarmiesinit = 0;
	end
	Lostarmiesinit = Mod.Settings.Lostarmies;
	if(Lostarmiesinit == nil)then
		Lostarmiesinit = 0;
	end
	Ownedarmiesinit = Mod.Settings.Ownedarmies;
	if(Ownedarmiesinit == nil)then
		Ownedarmiesinit = 0;
	end
	Eleminateaisinit = Mod.Settings.Eleminateais;
	if(Eleminateaisinit == nil)then
		Eleminateaisinit = 0;
	end
	Eleminateplayersinit = Mod.Settings.Eleminateplayers;
	if(Eleminateplayersinit == nil)then
		Eleminateplayersinit = 0;
	end
	Eleminateaisandplayersinit = Mod.Settings.Eleminateaisandplayers;
	if(Eleminateaisandplayersinit == nil)then
		Eleminateaisandplayersinit = 0;
	end
	terrconditioninit = Mod.Settings.terrcondition
	if(terrconditioninit == nil)then
		terrconditioninit = {};
	end
	ShowUI();
end
function ShowUI()
	hotzlist = {};
	local num = 0;
	local conditionnumber = 14;
	while(num <= conditionnumber)do
		hotzlist[num] = UI.CreateHorizontalLayoutGroup(rootParentobj);
		num = num + 1;
	end
	UI.CreateLabel(hotzlist[0]).SetText('To disable a condition, set it to 0(except territory conditions, they are disabled through the remove button)');
	UI.CreateLabel(hotzlist[1]).SetText('Conditions required for win');
	inputConditionsrequiredforwin = UI.CreateNumberInputField(hotzlist[1]).SetSliderMinValue(1).SetSliderMaxValue(11).SetValue(Conditionsrequiredforwinit);
	UI.CreateLabel(hotzlist[2]).SetText('Captured this many territories');
	inputCapturedterritories = UI.CreateNumberInputField(hotzlist[2]).SetSliderMinValue(0).SetSliderMaxValue(1000).SetValue(Capturedterritoriesinit);
	UI.CreateLabel(hotzlist[3]).SetText('Lost this many territories');
	inputLostterritories = UI.CreateNumberInputField(hotzlist[3]).SetSliderMinValue(0).SetSliderMaxValue(1000).SetValue(Lostterritoriesinit);
	UI.CreateLabel(hotzlist[4]).SetText('Owns this many territories');
	inputOwnedterritories = UI.CreateNumberInputField(hotzlist[4]).SetSliderMinValue(0).SetSliderMaxValue(1000).SetValue(Ownedterritoriesinit);
	UI.CreateLabel(hotzlist[5]).SetText('Captured this many bonuses');
	inputCapturedbonuses = UI.CreateNumberInputField(hotzlist[5]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(Capturedbonusesinit);
	UI.CreateLabel(hotzlist[6]).SetText('Lost this many bonuses');
	inputLostbonuses = UI.CreateNumberInputField(hotzlist[6]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(Lostbonusesinit);
	UI.CreateLabel(hotzlist[7]).SetText('Owns this many bonuses');
	inputOwnedbonuses = UI.CreateNumberInputField(hotzlist[7]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(Ownedbonusesinit);
	UI.CreateLabel(hotzlist[8]).SetText('Killed this many armies');
	inputKilledarmies = UI.CreateNumberInputField(hotzlist[8]).SetSliderMinValue(0).SetSliderMaxValue(1000).SetValue(Killedarmiesinit);
	UI.CreateLabel(hotzlist[9]).SetText('Lost this many armies');
	inputLostarmies = UI.CreateNumberInputField(hotzlist[9]).SetSliderMinValue(0).SetSliderMaxValue(1000).SetValue(Lostarmiesinit);
	UI.CreateLabel(hotzlist[10]).SetText('Owns this many armies');
	inputOwnedarmies = UI.CreateNumberInputField(hotzlist[10]).SetSliderMinValue(0).SetSliderMaxValue(1000).SetValue(Ownedarmiesinit);
	UI.CreateLabel(hotzlist[11]).SetText("Eleminated this many ais(players turned into ai don't count)");
	inputEleminateais = UI.CreateNumberInputField(hotzlist[11]).SetSliderMinValue(0).SetSliderMaxValue(39).SetValue(Eleminateaisinit);
	UI.CreateLabel(hotzlist[12]).SetText('Eliminated this many players');
	inputEleminateplayers = UI.CreateNumberInputField(hotzlist[12]).SetSliderMinValue(0).SetSliderMaxValue(39).SetValue(Eleminateplayersinit);
	UI.CreateLabel(hotzlist[13]).SetText('Eliminated this many AIs and players');
	inputEleminateaisandplayers = UI.CreateNumberInputField(hotzlist[13]).SetSliderMinValue(0).SetSliderMaxValue(39).SetValue(Eleminateaisandplayersinit);
	inputterrcondition = {};
	for _,terrcondition in pairs(terrconditioninit)do
		inputterrcondition[tablelength(inputterrcondition)] = {};
		local num = tablelength(inputterrcondition)-1;
		inputterrcondition[num].horz = UI.CreateHorizontalLayoutGroup(rootParentobj);
		inputterrcondition[num].Terrname = UI.CreateTextInputField(inputterrcondition[num].horz).SetPlaceholderText('Enter territory name').SetText(terrcondition.Terrname).SetPreferredWidth(200).SetPreferredHeight(30);
		UI.CreateLabel(inputterrcondition[num].horz).SetText("must be hold for");
		inputterrcondition[num].Turnnum = UI.CreateNumberInputField(inputterrcondition[num].horz).SetSliderMinValue(0).SetSliderMaxValue(10).SetValue(terrcondition.Turnnum);
		UI.CreateLabel(inputterrcondition[num].horz).SetText("Turns");
		UI.CreateButton(inputterrcondition[num].horz).SetText('Remove condition').SetOnClick(function() 
			UI.Destroy(inputterrcondition[num].horz);
			inputterrcondition[num].Terrname = nil;
		end);
	end
	horz = UI.CreateHorizontalLayoutGroup(rootParentobj);
	knopf = UI.CreateButton(horz).SetText('new territory condition').SetOnClick(newTerritoryCondition);
end
function newTerritoryCondition()
	UI.Destroy(horz);
	inputterrcondition[tablelength(inputterrcondition)] = {};
	local num = tablelength(inputterrcondition)-1;
	inputterrcondition[num].horz = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputterrcondition[num].Terrname = UI.CreateTextInputField(inputterrcondition[num].horz).SetPlaceholderText('Enter territory name').SetText("").SetPreferredWidth(200).SetPreferredHeight(30);
	UI.CreateLabel(inputterrcondition[num].horz).SetText("must be hold for");
	inputterrcondition[num].Turnnum = UI.CreateNumberInputField(inputterrcondition[num].horz).SetSliderMinValue(0).SetSliderMaxValue(10).SetValue(0);
	UI.CreateLabel(inputterrcondition[num].horz).SetText("Turns");
	UI.CreateButton(inputterrcondition[num].horz).SetText('Remove condition').SetOnClick(function() 
		UI.Destroy(inputterrcondition[num].horz);
		inputterrcondition[num].Terrname = nil;
	end);
	horz = UI.CreateHorizontalLayoutGroup(rootParentobj);
	knopf = UI.CreateButton(horz).SetText('new territory condition').SetOnClick(newTerritoryCondition);
end
function tablelength(arr)
	local num = 0;
	for _,elem in pairs(arr)do
		num = num + 1;
	end
	return num;
end
