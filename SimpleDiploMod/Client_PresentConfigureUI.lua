
function Client_PresentConfigureUI(rootParent)
	rootParentobj = rootParent;
	AIDeclerationinit = Mod.Settings.AllowAIDeclaration;
	if(AIDeclerationinit == nil)then
		AIDeclerationinit = true;
	end
	SeeAllyTerritoriesinit = Mod.Settings.SeeAllyTerritories;
	if(SeeAllyTerritoriesinit == nil)then
		SeeAllyTerritoriesinit = true;
	end
	PublicAlliesinit = Mod.Settings.PublicAllies;
	if(PublicAlliesinit == nil)then
		PublicAlliesinit = true;
	end
	StartMoneyinit = Mod.Settings.StartMoney;
	if(StartMoneyinit == nil)then
		StartMoneyinit = 100;
	end
	AIsdeclearAIsinit = Mod.Settings.AIsdeclearAIs;
	if(AIsdeclearAIsinit == nil)then
		AIsdeclearAIsinit = true;
	end
	MoneyPerTurninit = Mod.Settings.MoneyPerTurn;
	if(MoneyPerTurninit == nil)then
		MoneyPerTurninit = 5;
	end
	MoneyPerKilledArmyinit = Mod.Settings.MoneyPerKilledArmy;
	if(MoneyPerKilledArmyinit == nil)then
		MoneyPerKilledArmyinit = 1;
	end
	MoneyPerCapturedTerritoryinit = Mod.Settings.MoneyPerCapturedTerritory;
	if(MoneyPerCapturedTerritoryinit == nil)then
		MoneyPerCapturedTerritoryinit = 5;
	end
	MoneyPerCapturedBonusinit = Mod.Settings.MoneyPerCapturedBonus;
	if(MoneyPerCapturedBonusinit == nil)then
		MoneyPerCapturedBonusinit = 10;
	end
	SanctionCardRequireWarinit = Mod.Settings.SanctionCardRequireWar;
	if(SanctionCardRequireWarinit == nil)then
		SanctionCardRequireWarinit = true;
	end
	SanctionCardRequirePeaceinit = Mod.Settings.SanctionCardRequirePeace;
	if(SanctionCardRequirePeaceinit == nil)then
		SanctionCardRequirePeaceinit = false;
	end
	SanctionCardRequireAllyinit = Mod.Settings.SanctionCardRequireAlly;
	if(SanctionCardRequireAllyinit == nil)then
		SanctionCardRequireAllyinit = false;
	end
	BombCardRequireWarinit = Mod.Settings.BombCardRequireWar;
	if(BombCardRequireWarinit == nil)then
		BombCardRequireWarinit = true;
	end
	BombCardRequirePeaceinit = Mod.Settings.BombCardRequirePeace;
	if(BombCardRequirePeaceinit == nil)then
		BombCardRequirePeaceinit = false;
	end
	BombCardRequireAllyinit = Mod.Settings.BombCardRequireAlly;
	if(BombCardRequireAllyinit == nil)then
		BombCardRequireAllyinit = false;
	end
	SpyCardRequireWarinit = Mod.Settings.SpyCardRequireWar;
	if(SpyCardRequireWarinit == nil)then
		SpyCardRequireWarinit = true;
	end
	SpyCardRequirePeaceinit = Mod.Settings.SpyCardRequirePeace;
	if(SpyCardRequirePeaceinit == nil)then
		SpyCardRequirePeaceinit = false;
	end
	SpyCardRequireAllyinit = Mod.Settings.SpyCardRequireAlly;
	if(SpyCardRequireAllyinit == nil)then
		SpyCardRequireAllyinit = false;
	end
	GiftCardRequireWarinit = Mod.Settings.GiftCardRequireWar;
	if(GiftCardRequireWarinit == nil)then
		GiftCardRequireWarinit = false;
	end
	GiftCardRequirePeaceinit = Mod.Settings.GiftCardRequirePeace;
	if(GiftCardRequirePeaceinit == nil)then
		GiftCardRequirePeaceinit = false;
	end
	GiftCardRequireAllyinit = Mod.Settings.GiftCardRequireAlly;
	if(GiftCardRequireAllyinit == nil)then
		GiftCardRequireAllyinit = true;
	end
	MoneyPerBoughtArmyinit = Mod.Settings.MoneyPerBoughtArmy;
	if(MoneyPerBoughtArmyinit == nil)then
		MoneyPerBoughtArmyinit = 2;
	end
	Adminaccessinit = Mod.Settings.AdminAccess;
	if(Adminaccessinit == nil)then
		Adminaccessinit = true;
	end
	Startwarsinit = Mod.Settings.StartWar;
	if(Startwarsinit == nil)then
		Startwarsinit = ",";
	end
	ShowUI();
end
function ShowUI()
	hotzlist = {};
	hotzlist[0] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(hotzlist[0]).SetText('AI Settings');
   	hotzlist[1] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	AIDeclerationcheckbox = UI.CreateCheckBox(hotzlist[1]).SetText('Allow AIs to declare war on Player').SetIsChecked(AIDeclerationinit);
	hotzlist[2] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	AIsdeclearAIsinitcheckbox = UI.CreateCheckBox(hotzlist[2]).SetText('Allow AIs to declare war on AIs').SetIsChecked(AIsdeclearAIsinit);
	hotzlist[3] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(hotzlist[3]).SetText(' ');
	hotzlist[4] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(hotzlist[4]).SetText('Allianze Settings - this system will come in a later version, but that would be a bigger change, I added the settings for that already');
	hotzlist[5] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	SeeAllyTerritoriesCheckbox = UI.CreateCheckBox(hotzlist[5]).SetText('Allow Players to see the territories of their allies').SetIsChecked(SeeAllyTerritoriesinit);
	hotzlist[6] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	PublicAlliesCheckbox = UI.CreateCheckBox(hotzlist[6]).SetText('Allow everyone to see every ally').SetIsChecked(PublicAlliesinit);
	hotzlist[7] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(hotzlist[7]).SetText(' ');
	hotzlist[8] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(hotzlist[8]).SetText('Shop System');
	hotzlist[9] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	if(StartMoneyinit == 0 and MoneyPerTurninit == 0 and MoneyPerKilledArmyinit == 0 and MoneyPerCapturedTerritoryinit == 0 and MoneyPerCapturedBonusinit == 0)then
		UI.CreateButton(hotzlist[9]).SetText('Activate Shop').SetOnClick(function() 
			StartMoneyinit = 100;
			MoneyPerTurninit = 5;
			MoneyPerKilledArmyinit = 1;
			MoneyPerCapturedTerritoryinit = 5;
			MoneyPerCapturedBonusinit = 10;
			ReloadUI();
		end);
	else
		UI.CreateButton(hotzlist[9]).SetText('Disable Shop').SetOnClick(function() 
			StartMoneyinit = 0;
			MoneyPerTurninit = 0;
			MoneyPerKilledArmyinit = 0;
			MoneyPerCapturedTerritoryinit = 0;
			MoneyPerCapturedBonusinit = 0;
			inputStartMoney = nil;
			inputMoneyPerTurn = nil;
			inputMoneyPerKilledArmy = nil;
			inputMoneyPerCapturedTerritory = nil;
			inputMoneyPerCapturedBonus = nil;
			inputMoneyPerBoughtArmy = nil;
			ReloadUI();
		end);
		hotzlist[11] = UI.CreateHorizontalLayoutGroup(rootParentobj);
		UI.CreateLabel(hotzlist[11]).SetText('Starting Money');
		inputStartMoney = UI.CreateNumberInputField(hotzlist[11]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(StartMoneyinit);
		hotzlist[12] = UI.CreateHorizontalLayoutGroup(rootParentobj);
		UI.CreateLabel(hotzlist[12]).SetText('Money per turn');
		inputMoneyPerTurn = UI.CreateNumberInputField(hotzlist[12]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(MoneyPerTurninit);
		hotzlist[13] = UI.CreateHorizontalLayoutGroup(rootParentobj);
		UI.CreateLabel(hotzlist[13]).SetText('Money per killed army');
		inputMoneyPerKilledArmy = UI.CreateNumberInputField(hotzlist[13]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(MoneyPerKilledArmyinit);
		hotzlist[14] = UI.CreateHorizontalLayoutGroup(rootParentobj);
		UI.CreateLabel(hotzlist[14]).SetText('Money per captured territory');
		inputMoneyPerCapturedTerritory = UI.CreateNumberInputField(hotzlist[14]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(MoneyPerCapturedTerritoryinit);
		hotzlist[15] = UI.CreateHorizontalLayoutGroup(rootParentobj);
		UI.CreateLabel(hotzlist[15]).SetText('Money per captured bonus');
		inputMoneyPerCapturedBonus = UI.CreateNumberInputField(hotzlist[15]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(MoneyPerCapturedBonusinit);
		hotzlist[16] = UI.CreateHorizontalLayoutGroup(rootParentobj);
		UI.CreateLabel(hotzlist[16]).SetText('Price per army');
		inputMoneyPerBoughtArmy = UI.CreateNumberInputField(hotzlist[16]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(MoneyPerBoughtArmyinit);
	end
	hotzlist[17] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(hotzlist[17]).SetText(' ');
	hotzlist[18] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(hotzlist[18]).SetText('Card Settings');
	hotzlist[19] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(hotzlist[19]).SetText('Sanction Card');
	hotzlist[20] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputSanctionCardRequireWar = UI.CreateCheckBox(hotzlist[20]).SetText('Sanction Cards require war').SetIsChecked(SanctionCardRequireWarinit);
	hotzlist[21] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputSanctionCardRequirePeace = UI.CreateCheckBox(hotzlist[21]).SetText('Sanction Cards require peace').SetIsChecked(SanctionCardRequirePeaceinit);
	hotzlist[22] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputSanctionCardRequireAlly = UI.CreateCheckBox(hotzlist[22]).SetText('Sanction Cards require ally').SetIsChecked(SanctionCardRequireAllyinit);
	hotzlist[23] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(hotzlist[23]).SetText(' ');
	hotzlist[24] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(hotzlist[24]).SetText('Bomb Card');
	hotzlist[25] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputBombCardRequireWar = UI.CreateCheckBox(hotzlist[25]).SetText('Bomb Cards require war').SetIsChecked(BombCardRequireWarinit);
	hotzlist[26] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputBombCardRequirePeace = UI.CreateCheckBox(hotzlist[26]).SetText('Bomb Cards require peace').SetIsChecked(BombCardRequirePeaceinit);
	hotzlist[27] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputBombCardRequireAlly = UI.CreateCheckBox(hotzlist[27]).SetText('Bomb Cards require ally').SetIsChecked(BombCardRequireAllyinit);
	hotzlist[28] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(hotzlist[28]).SetText(' ');
	hotzlist[32] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(hotzlist[32]).SetText('Spy Card');
	hotzlist[33] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputSpyCardRequireWar = UI.CreateCheckBox(hotzlist[33]).SetText('Spy Cards require war').SetIsChecked(SpyCardRequireWarinit);
	hotzlist[34] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputSpyCardRequirePeace = UI.CreateCheckBox(hotzlist[34]).SetText('Spy Cards require peace').SetIsChecked(SpyCardRequirePeaceinit);
	hotzlist[35] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputSpyCardRequireAlly = UI.CreateCheckBox(hotzlist[35]).SetText('Spy Cards require ally').SetIsChecked(SpyCardRequireAllyinit);
	hotzlist[36] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(hotzlist[36]).SetText(' ');
	hotzlist[37] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(hotzlist[37]).SetText('Gift Card');
	hotzlist[39] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputGiftCardRequireWar = UI.CreateCheckBox(hotzlist[39]).SetText('Gift Cards require war').SetIsChecked(GiftCardRequireWarinit);
	hotzlist[40] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputGiftCardRequirePeace = UI.CreateCheckBox(hotzlist[40]).SetText('Gift Cards require peace').SetIsChecked(GiftCardRequirePeaceinit);
	hotzlist[41] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputGiftCardRequireAlly = UI.CreateCheckBox(hotzlist[41]).SetText('Gift Cards require ally').SetIsChecked(GiftCardRequireAllyinit);
	hotzlist[42] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(hotzlist[42]).SetText(' ');
	hotzlist[43] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(hotzlist[43]).SetText('Other Settings');
	hotzlist[44] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputAdminaccess = UI.CreateCheckBox(hotzlist[44]).SetText('Allow dabo1 to access and edit all data to identify and fix bugs runtime andfor other diagnostic functions').SetIsChecked(Adminaccessinit);
end
function DeleteUI()
	for _,horizont in hotzlist do
		UI.Destroy(horizont);
	end
end
function ReloadUI()
	DeleteUI();
	ShowUI();
end
function Save()
	AllowAIDeclarationinit = AIDeclerationcheckbox.GetIsChecked();
	AIsdeclearAIsinit = AIsdeclearAIsinitcheckbox.GetIsChecked();
	SeeAllyTerritoriesinit = SeeAllyTerritoriesCheckbox.GetIsChecked();
	PublicAlliesinit = PublicAlliesCheckbox.GetIsChecked();
	if(StartMoneyinit ~= 0 or MoneyPerTurninit ~= 0 or MoneyPerKilledArmyinit ~= 0 or MoneyPerCapturedTerritoryinit ~= 0 or MoneyPerCapturedBonusinit ~= 0)then
		if(inputStartMoney.GetValue() ~= nil)then
			StartMoneyinit = inputStartMoney.GetValue();
			MoneyPerTurninit = inputMoneyPerTurn.GetValue();
			MoneyPerKilledArmyinit = inputMoneyPerKilledArmy.GetValue();
			MoneyPerCapturedTerritoryinit = inputMoneyPerCapturedTerritory.GetValue();
			MoneyPerCapturedBonusinit = inputMoneyPerCapturedBonus.GetValue();
			MoneyPerBoughtArmyinit = inputMoneyPerBoughtArmy.GetValue();
		end
	end
	SanctionCardRequireWarinit = inputSanctionCardRequireWar.GetIsChecked();
	SanctionCardRequirePeaceinit = inputSanctionCardRequirePeace.GetIsChecked();
	SanctionCardRequireAllyinit = inputSanctionCardRequireAlly.GetIsChecked();
	BombCardRequireWarinit = inputBombCardRequireWar.GetIsChecked();
	BombCardRequirePeaceinit = inputBombCardRequirePeace.GetIsChecked();
	BombCardRequireAllyinit = inputBombCardRequireAlly.GetIsChecked();
	SpyCardRequireWarinit = inputSpyCardRequireWar.GetIsChecked();
	SpyCardRequirePeaceinit = inputSpyCardRequirePeace.GetIsChecked();
	SpyCardRequireAllyinit = inputSpyCardRequireAlly.GetIsChecked();
	GiftCardRequireWarinit = inputGiftCardRequireWar.GetIsChecked();
	GiftCardRequirePeaceinit = inputGiftCardRequirePeace.GetIsChecked();
	GiftCardRequireAllyinit = inputGiftCardRequireAlly.GetIsChecked();
	AdminAccessinit = inputAdminaccess.GetIsChecked();
end
