
function Client_PresentConfigureUI(rootParent)
	local AIDeclerationinit = Mod.Settings.AllowAIDeclaration;
	if(AIDeclerationinit == nil)then
		AIDeclerationinit = true;
	end
	local SeeAllyTerritoriesinit = Mod.Settings.SeeAllyTerritories;
	if(SeeAllyTerritoriesinit == nil)then
		SeeAllyTerritoriesinit = true;
	end
	local PublicAlliesinit = Mod.Settings.PublicAllies;
	if(PublicAlliesinit == nil)then
		PublicAlliesinit = true;
	end
	local StartMoneyinit = Mod.Settings.StartMoney;
	if(StartMoneyinit == nil)then
		StartMoneyinit = 100;
	end
	local AIsdeclearAIsinit = Mod.Settings.AIsdeclearAIs;
	if(AIsdeclearAIsinit == nil)then
		AIsdeclearAIsinit = true;
	end
	local MoneyPerTurninit = Mod.Settings.MoneyPerTurn;
	if(MoneyPerTurninit == nil)then
		MoneyPerTurninit = 5;
	end
	local MoneyPerKilledArmyinit = Mod.Settings.MoneyPerKilledArmy;
	if(MoneyPerKilledArmyinit == nil)then
		MoneyPerKilledArmyinit = 1;
	end
	local MoneyPerCapturedTerritoryinit = Mod.Settings.MoneyPerCapturedTerritory;
	if(MoneyPerCapturedTerritoryinit == nil)then
		MoneyPerCapturedTerritoryinit = 5;
	end
	local MoneyPerCapturedBonusinit = Mod.Settings.MoneyPerCapturedBonus;
	if(MoneyPerCapturedBonusinit == nil)then
		MoneyPerCapturedBonusinit = 10;
	end
	local SanctionCardRequireWarinit = Mod.Settings.SanctionCardRequireWar;
	if(SanctionCardRequireWarinit == nil)then
		SanctionCardRequireWarinit = true;
	end
	local BombCardRequireWarinit = Mod.Settings.BombCardRequireWar;
	if(BombCardRequireWarinit == nil)then
		BombCardRequireWarinit = true;
	end
	local MoneyPerBoughtArmyinit = Mod.Settings.MoneyPerBoughtArmy;
	if(MoneyPerBoughtArmyinit == nil)then
		MoneyPerBoughtArmyinit = 2;
	end
	local texthorz = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(texthorz).SetText('AI Settings');
   	texthorz = UI.CreateHorizontalLayoutGroup(rootParent);
	AIDeclerationcheckbox = UI.CreateCheckBox(texthorz).SetText('Allow AIs to declare war on Player').SetIsChecked(AIDeclerationinit);
	texthorz = UI.CreateHorizontalLayoutGroup(rootParent);
	AIsdeclearAIsinitcheckbox = UI.CreateCheckBox(texthorz).SetText('Allow AIs to declare war on AIs').SetIsChecked(AIsdeclearAIsinit);
	texthorz = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(texthorz).SetText('Allianze Settings - this system will come in a later version, but that would be a bigger change, I added the settings for that already');
	texthorz = UI.CreateHorizontalLayoutGroup(rootParent);
	SeeAllyTerritoriesCheckbox = UI.CreateCheckBox(texthorz).SetText('Allow Players to see the territories of their allies').SetIsChecked(SeeAllyTerritoriesinit);
	texthorz = UI.CreateHorizontalLayoutGroup(rootParent);
	PublicAlliesCheckbox = UI.CreateCheckBox(texthorz).SetText('Allow everyone to see every ally').SetIsChecked(PublicAlliesinit);
	texthorz = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(texthorz).SetText('Shop System');
	texthorz = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateButton(texthorz).SetText('Change the settings, so that the shop is dissabled').SetOnClick(function() 
			inputStartMoney.SetValue(0);
			inputMoneyPerTurn.SetValue(0);
			inputMoneyPerKilledArmy.SetValue(0);
			inputMoneyPerCapturedTerritory.SetValue(0);
			inputMoneyPerCapturedBonus.SetValue(0);
		end);
	texthorz = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateButton(texthorz).SetText('Change the settings, so that the shop is active').SetOnClick(function() 
			inputStartMoney.SetValue(100);
			inputMoneyPerTurn.SetValue(5);
			inputMoneyPerKilledArmy.SetValue(1);
			inputMoneyPerCapturedTerritory.SetValue(5);
			inputMoneyPerCapturedBonus.SetValue(10);
		end);
	texthorz = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(texthorz).SetText('Starting Money');
	inputStartMoney = UI.CreateNumberInputField(texthorz).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(StartMoneyinit);
	texthorz = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(texthorz).SetText('Money per turn');
	inputMoneyPerTurn = UI.CreateNumberInputField(texthorz).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(MoneyPerTurninit);
	texthorz = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(texthorz).SetText('Money per killed army');
	inputMoneyPerKilledArmy = UI.CreateNumberInputField(texthorz).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(MoneyPerKilledArmyinit);
	texthorz = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(texthorz).SetText('Money per captured territory');
	inputMoneyPerCapturedTerritory = UI.CreateNumberInputField(texthorz).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(MoneyPerCapturedTerritoryinit);
	texthorz = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(texthorz).SetText('Money per captured bonus');
	inputMoneyPerCapturedBonus = UI.CreateNumberInputField(texthorz).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(MoneyPerCapturedBonusinit);
	texthorz = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(texthorz).SetText('Price per army');
	inputMoneyPerBoughtArmy = UI.CreateNumberInputField(texthorz).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(MoneyPerBoughtArmyinit);
	texthorz = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(texthorz).SetText('Cards, that Require War');
	texthorz = UI.CreateHorizontalLayoutGroup(rootParent);
	inputSanctionCardRequireWar = UI.CreateCheckBox(texthorz).SetText('Sanction Card').SetIsChecked(SanctionCardRequireWarinit);
	texthorz = UI.CreateHorizontalLayoutGroup(rootParent);
	inputBombCardRequireWar = UI.CreateCheckBox(texthorz).SetText('Bomb Card').SetIsChecked(BombCardRequireWarinit);
end
