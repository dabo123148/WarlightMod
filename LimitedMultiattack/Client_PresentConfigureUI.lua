
function Client_PresentConfigureUI(rootParent)
	local initialValue = Mod.Settings.MaxAttacks;
	if initialValue == nil then
		initialValue = 5;
	end
    
   	local horz = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(horz).SetText('Attacks per Multiattack(0=Infinit) ');
   	InputMaxAttacks = UI.CreateNumberInputField(horz).SetSliderMinValue(0).SetSliderMaxValue(100).SetValue(initialValue);
	horz = UI.CreateHorizontalLayoutGroup(rootParent);
	initialValue = Mod.Settings.ContinueAttackIfFailed;
	if initialValue == nil then
		initialValue = true;
	end
	InputContinueAttackIfFailed = UI.CreateCheckBox(horz).SetText('If an attack failed you can continue attacking from the field it failed from(standart multiattack is with this enabled)').SetIsChecked(initialValue);
	horz = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(horz).SetText('If one of the following checkboxes is activated, then you can only use multiattacks in turns, in which you play one of the following cards. The cards will still have their old effect.');
	horz = UI.CreateHorizontalLayoutGroup(rootParent);
	initialValue = Mod.Settings.ReinforcementCard;
	if initialValue == nil then
		initialValue = false;
	end
	InputReinforcementCard = UI.CreateCheckBox(horz).SetText('Activate when Playing Reinforcement Card').SetIsChecked(initialValue);
	horz = UI.CreateHorizontalLayoutGroup(rootParent);
	initialValue = Mod.Settings.GiftCard;
	if initialValue == nil then
		initialValue = false;
	end
	InputGiftCard = UI.CreateCheckBox(horz).SetText('Activate when Playing Gift Card').SetIsChecked(initialValue);
	horz = UI.CreateHorizontalLayoutGroup(rootParent);
	initialValue = Mod.Settings.AirliftCard;
	if initialValue == nil then
		initialValue = false;
	end
	InputAirliftCard = UI.CreateCheckBox(horz).SetText('Activate when Playing Airlift Card').SetIsChecked(initialValue);
	horz = UI.CreateHorizontalLayoutGroup(rootParent);
	initialValue = Mod.Settings.ReconnaisanceCard;
	if initialValue == nil then
		initialValue = false;
	end
	InputReconnaisanceCard = UI.CreateCheckBox(horz).SetText('Activate when Playing Reconnaisance Card').SetIsChecked(initialValue);
	horz = UI.CreateHorizontalLayoutGroup(rootParent);
	initialValue = Mod.Settings.SpyCard;
	if initialValue == nil then
		initialValue = false;
	end
	InputSpyCard = UI.CreateCheckBox(horz).SetText('Activate when Playing Spy Card').SetIsChecked(initialValue);
end
