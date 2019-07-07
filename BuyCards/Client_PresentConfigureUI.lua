
function Client_PresentConfigureUI(rootParent)
	rootParentobj = rootParent;
	GiftCardCostinit = Mod.Settings.GiftCardCost;
	if(GiftCardCostinit == nil)then
		GiftCardCostinit = 0;
	end
	SpyCardCostinit = Mod.Settings.SpyCardCost;
	if(SpyCardCostinit == nil)then
		SpyCardCostinit = 0;
	end
	EmergencyBlockadeCardCostinit = Mod.Settings.EmergencyBlockadeCardCost;
	if(EmergencyBlockadeCardCostinit == nil)then
		EmergencyBlockadeCardCostinit = 0;
	end
	BlockadeCardCostinit = Mod.Settings.BlockadeCardCost;
	if(BlockadeCardCostinit == nil)then
		BlockadeCardCostinit = 0;
	end
	OrderPriorityCardCostinit = Mod.Settings.OrderPriorityCardCost;
	if(OrderPriorityCardCostinit == nil)then
		OrderPriorityCardCostinit = 0;
	end
	OrderDelayCardCostinit = Mod.Settings.OrderDelayCardCost;
	if(OrderDelayCardCostinit == nil)then
		OrderDelayCardCostinit = 0;
	end
	AirliftCardCostinit = Mod.Settings.AirliftCardCost;
	if(AirliftCardCostinit == nil)then
		AirliftCardCostinit = 0;
	end
	DiplomacyCardCostinit = Mod.Settings.DiplomacyCardCost;
	if(DiplomacyCardCostinit == nil)then
		DiplomacyCardCostinit = 0;
	end
	SanctionsCardCostinit = Mod.Settings.SanctionsCardCost;
	if(SanctionsCardCostinit == nil)then
		SanctionsCardCostinit = 0;
	end
	ReconnaissanceCardCostinit = Mod.Settings.ReconnaissanceCardCost;
	if(ReconnaissanceCardCostinit == nil)then
		ReconnaissanceCardCostinit = 0;
	end
	SurveillanceCardCostinit = Mod.Settings.SurveillanceCardCost;
	if(SurveillanceCardCostinit == nil)then
		SurveillanceCardCostinit = 0;
	end
	BombCardCostinit = Mod.Settings.BombCardCost;
	if(BombCardCostinit == nil)then
		BombCardCostinit = 0;
	end
	ShowUI();
end
function ShowUI()
	horzlist = {};
	horz = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horz).SetText('Set the cost to 0 to make it not purchasable');
    horz = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horz).SetText('Cost of gift cards:');
	GiftCardCostinput = UI.CreateNumberInputField(horz).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(GiftCardCostinit);
	horz = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horz).SetText('Cost of spy cards:');
	SpyCardCostinput = UI.CreateNumberInputField(horz).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(SpyCardCostinit);
	horz = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horz).SetText('Cost of emergency blockade cards:');
	EmergencyBlockadeCardCostinput = UI.CreateNumberInputField(horz).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(EmergencyBlockadeCardCostinit);
	horz = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horz).SetText('Cost of blockade cards:');
	BlockadeCardCostinput = UI.CreateNumberInputField(horz).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(BlockadeCardCostinit);
	horz = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horz).SetText('Cost of order priority cards:');
	OrderPriorityCardCostinput = UI.CreateNumberInputField(horz).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(OrderPriorityCardCostinit);
	horz = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horz).SetText('Cost of order delay cards:');
	OrderDelayCardCostinput = UI.CreateNumberInputField(horz).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(OrderDelayCardCostinit);
	horz = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horz).SetText('Cost of airlift cards:');
	AirliftCardCostinput = UI.CreateNumberInputField(horz).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(AirliftCardCostinit);
	horz = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horz).SetText('Cost of diplomacy cards:');
	DiplomacyCardCostinput = UI.CreateNumberInputField(horz).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(DiplomacyCardCostinit);
	horz = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horz).SetText('Cost of sanctions cards:');
	SanctionsCardCostinput = UI.CreateNumberInputField(horz).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(SanctionsCardCostinit);
	horz = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horz).SetText('Cost of reconnaissance cards:');
	ReconnaissanceCardCostinput = UI.CreateNumberInputField(horz).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(ReconnaissanceCardCostinit);
	horz = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horz).SetText('Cost of surveillance cards:');
	SurveillanceCardCostinput = UI.CreateNumberInputField(horz).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(SurveillanceCardCostinit);
	horz = UI.CreateHorizontalLayoutGroup(rootParentobj);
	UI.CreateLabel(horz).SetText('Cost of bomb cards:');
	BombCardCostinput = UI.CreateNumberInputField(horz).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(BombCardCostinit);
end
