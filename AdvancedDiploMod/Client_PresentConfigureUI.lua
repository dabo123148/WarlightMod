
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
	MoneyPerBoughtArmyinit = Mod.Settings.MoneyPerBoughtArmy;
	if(MoneyPerBoughtArmyinit == nil)then
		MoneyPerBoughtArmyinit = 2;
	end
	BasicMoneySysteminit = Mod.Settings.BasicMoneySystem;
	if(BasicMoneySysteminit == nil)then
		BasicMoneySysteminit = false;
	end
	ShowUI();
end
function ShowUI()
	horzlist = {};
	horzlist[0] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horzlist[0]).SetText('AI Settings');
   	horzlist[1] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	AIDeclerationcheckbox = UI.CreateCheckBox(horzlist[1]).SetText('Allow AIs to declare war on Player').SetIsChecked(AIDeclerationinit);
	horzlist[2] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	AIsdeclearAIsinitcheckbox = UI.CreateCheckBox(horzlist[2]).SetText('Allow AIs to declare war on AIs').SetIsChecked(AIsdeclearAIsinit);
	horzlist[3] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horzlist[3]).SetText(' ');
	horzlist[4] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horzlist[4]).SetText('Allianze Settings - this system will come in a later version, but that would be a bigger change, I added the settings for that already');
	horzlist[5] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	SeeAllyTerritoriesCheckbox = UI.CreateCheckBox(horzlist[5]).SetText('Allow Players to see the territories of their allies').SetIsChecked(SeeAllyTerritoriesinit);
	horzlist[6] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	PublicAlliesCheckbox = UI.CreateCheckBox(horzlist[6]).SetText('Allow everyone to see every ally').SetIsChecked(PublicAlliesinit);
	horzlist[7] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horzlist[7]).SetText(' ');
	horzlist[8] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horzlist[8]).SetText('Shop System');
	horzlist[9] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	if(StartMoneyinit == 0 and MoneyPerTurninit == 0 and MoneyPerKilledArmyinit == 0 and MoneyPerCapturedTerritoryinit == 0 and MoneyPerCapturedBonusinit == 0)then
		UI.CreateButton(horzlist[9]).SetText('Activate Shop').SetOnClick(function() 
			StartMoneyinit = 100;
			MoneyPerTurninit = 5;
			MoneyPerKilledArmyinit = 1;
			MoneyPerCapturedTerritoryinit = 5;
			MoneyPerCapturedBonusinit = 10;
			ReloadUI();
		end);
	else
		UI.CreateButton(horzlist[9]).SetText('Disable Shop').SetOnClick(function() 
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
		horzlist[45] = UI.CreateHorizontalLayoutGroup(rootParentobj);
		inputBasicMoneySystem = UI.CreateCheckBox(horzlist[45]).SetText('Use Warlight Comerce System').SetIsChecked(BasicMoneySysteminit);
		horzlist[11] = UI.CreateHorizontalLayoutGroup(rootParentobj);
		UI.CreateLabel(horzlist[11]).SetText('Starting Money');
		inputStartMoney = UI.CreateNumberInputField(horzlist[11]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(StartMoneyinit);
		horzlist[12] = UI.CreateHorizontalLayoutGroup(rootParentobj);
		UI.CreateLabel(horzlist[12]).SetText('Money per turn');
		inputMoneyPerTurn = UI.CreateNumberInputField(horzlist[12]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(MoneyPerTurninit);
		horzlist[13] = UI.CreateHorizontalLayoutGroup(rootParentobj);
		UI.CreateLabel(horzlist[13]).SetText('Money per killed army');
		inputMoneyPerKilledArmy = UI.CreateNumberInputField(horzlist[13]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(MoneyPerKilledArmyinit);
		horzlist[14] = UI.CreateHorizontalLayoutGroup(rootParentobj);
		UI.CreateLabel(horzlist[14]).SetText('Money per captured territory');
		inputMoneyPerCapturedTerritory = UI.CreateNumberInputField(horzlist[14]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(MoneyPerCapturedTerritoryinit);
		horzlist[15] = UI.CreateHorizontalLayoutGroup(rootParentobj);
		UI.CreateLabel(horzlist[15]).SetText('Money per captured bonus');
		inputMoneyPerCapturedBonus = UI.CreateNumberInputField(horzlist[15]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(MoneyPerCapturedBonusinit);
		horzlist[16] = UI.CreateHorizontalLayoutGroup(rootParentobj);
		UI.CreateLabel(horzlist[16]).SetText('Price per army(0=disabled)');
		inputMoneyPerBoughtArmy = UI.CreateNumberInputField(horzlist[16]).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(MoneyPerBoughtArmyinit);
	end
	horzlist[17] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horzlist[17]).SetText(' ');
	horzlist[18] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horzlist[18]).SetText('Card Settings');
	horzlist[19] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horzlist[19]).SetText('Sanction Card');
	horzlist[20] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputSanctionCardRequireWar = UI.CreateCheckBox(horzlist[20]).SetText('Sanction Cards can be played on enemy').SetIsChecked(SanctionCardRequireWarinit);
	horzlist[21] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputSanctionCardRequirePeace = UI.CreateCheckBox(horzlist[21]).SetText('Sanction Cards can be played on players you are in peace with').SetIsChecked(SanctionCardRequirePeaceinit);
	horzlist[22] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputSanctionCardRequireAlly = UI.CreateCheckBox(horzlist[22]).SetText('Sanction Cards can be played on ally').SetIsChecked(SanctionCardRequireAllyinit);
	horzlist[23] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horzlist[23]).SetText(' ');
	horzlist[24] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horzlist[24]).SetText('Bomb Card');
	horzlist[25] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputBombCardRequireWar = UI.CreateCheckBox(horzlist[25]).SetText('Bomb Cards can be played on enemy').SetIsChecked(BombCardRequireWarinit);
	horzlist[26] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputBombCardRequirePeace = UI.CreateCheckBox(horzlist[26]).SetText('Bomb Cards can be played on players you are in peace with').SetIsChecked(BombCardRequirePeaceinit);
	horzlist[27] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputBombCardRequireAlly = UI.CreateCheckBox(horzlist[27]).SetText('Bomb Cards can be played on ally').SetIsChecked(BombCardRequireAllyinit);
	horzlist[28] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horzlist[28]).SetText(' ');
	horzlist[32] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horzlist[32]).SetText('Spy Card');
	horzlist[33] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputSpyCardRequireWar = UI.CreateCheckBox(horzlist[33]).SetText('Spy Cards can be played on enemy').SetIsChecked(SpyCardRequireWarinit);
	horzlist[34] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputSpyCardRequirePeace = UI.CreateCheckBox(horzlist[34]).SetText('Spy Cards can be played on players you are in peace with').SetIsChecked(SpyCardRequirePeaceinit);
	horzlist[35] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputSpyCardRequireAlly = UI.CreateCheckBox(horzlist[35]).SetText('Spy Cards can be played on ally').SetIsChecked(SpyCardRequireAllyinit);
	horzlist[36] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horzlist[36]).SetText(' ');
	horzlist[37] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horzlist[37]).SetText('Gift Card');
	horzlist[39] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputGiftCardRequireWar = UI.CreateCheckBox(horzlist[39]).SetText('Gift Cards can be played on enemy').SetIsChecked(GiftCardRequireWarinit);
	horzlist[40] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputGiftCardRequirePeace = UI.CreateCheckBox(horzlist[40]).SetText('Gift Cards can be played on players you are in peace with').SetIsChecked(GiftCardRequirePeaceinit);
	horzlist[41] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputGiftCardRequireAlly = UI.CreateCheckBox(horzlist[41]).SetText('Gift Cards can be played on ally').SetIsChecked(GiftCardRequireAllyinit);
	horzlist[42] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horzlist[42]).SetText(' ');
	horzlist[43] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horzlist[43]).SetText('Other Settings');
	horzlist[44] = UI.CreateHorizontalLayoutGroup(rootParentobj);
	inputAdminaccess = UI.CreateCheckBox(horzlist[44]).SetText('Allow dabo1 to access and edit all data to identify and fix bugs runtime andfor other diagnostic functions').SetIsChecked(Adminaccessinit);
end
function DeleteUI()
	for _,horizont in pairs(horzlist) do
		UI.Destroy(horizont);
	end
end
function ReloadUI()
	Save();
	DeleteUI();
	ShowUI();
end
function Save()
	AIDeclerationinit  = AIDeclerationcheckbox.GetIsChecked();
	AIsdeclearAIsinit = AIsdeclearAIsinitcheckbox.GetIsChecked();
	SeeAllyTerritoriesinit = SeeAllyTerritoriesCheckbox.GetIsChecked();
	PublicAlliesinit = PublicAlliesCheckbox.GetIsChecked();
	if(StartMoneyinit ~= 0 or MoneyPerTurninit ~= 0 or MoneyPerKilledArmyinit ~= 0 or MoneyPerCapturedTerritoryinit ~= 0 or MoneyPerCapturedBonusinit ~= 0)then
		if(inputStartMoney ~= nil)then
			BasicMoneySysteminit = inputBasicMoneySystem.GetValue();
			MoneyPerTurninit = inputMoneyPerTurn.GetValue();
			MoneyPerKilledArmyinit = inputMoneyPerKilledArmy.GetValue();
			MoneyPerCapturedTerritoryinit = inputMoneyPerCapturedTerritory.GetValue();
			MoneyPerCapturedBonusinit = inputMoneyPerCapturedBonus.GetValue();
			MoneyPerBoughtArmyinit = inputMoneyPerBoughtArmy.GetValue();
			StartMoneyinit = inputStartMoney.GetValue();
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
	Adminaccessinit = inputAdminaccess.GetIsChecked();
end
