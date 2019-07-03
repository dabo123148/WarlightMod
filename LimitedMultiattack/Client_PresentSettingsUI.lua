
function Client_PresentSettingsUI(rootParent)
	if(Mod.Settings.MaxAttacks ~= 0)then
		UI.CreateLabel(rootParent).SetText(Mod.Settings.MaxAttacks .. ' Attacks Multiattack');
	else
		UI.CreateLabel(rootParent).SetText('unlimited number of Multiattacks');
	end
	local horz = UI.CreateHorizontalLayoutGroup(rootParent);
	local setttingContinueAttackIfFailed = Mod.Settings.ContinueAttackIfFailed;
	if(setttingContinueAttackIfFailed == nil)then
		setttingContinueAttackIfFailed = true;
	end
	UI.CreateLabel(horz).SetText('Can continue to attack if attack fails :');
	UI.CreateButton(horz).SetText('?').SetColor('#0080ff').SetOnClick(function() UI.Alert('If you attack from a territory and your attack fails, with this disabled, the mod will prevent you from making further attacks from that territory in that turn unless you recapture it'); end);
	if(setttingContinueAttackIfFailed)then
		UI.CreateLabel(horz).SetText(' True');
	else
		UI.CreateLabel(horz).SetText(' False');
	end
	local boundtocard = false;
	if(Mod.Settings.ReinforcementCard ~= nil)then
		if(Mod.Settings.ReinforcementCard)then
			if(boundtocard == false)then
				boundtocard = true;
				UI.CreateLabel(rootParent).SetText('Multiattacks are for the current turn enabled, when one of the following cards is played.');
				UI.CreateLabel(rootParent).SetText('!!! The cards keep their old effect !!!');
			end
			UI.CreateLabel(rootParent).SetText('Reinforcement Card');
		end
	end
	if(Mod.Settings.GiftCard ~= nil)then
		if(Mod.Settings.GiftCard)then
			if(boundtocard == false)then
				boundtocard = true;
				UI.CreateLabel(rootParent).SetText('Multiattacks are for the current turn enabled, when one of the following cards is played');
				UI.CreateLabel(rootParent).SetText('!!! The cards keep their old effect !!!');
			end
			UI.CreateLabel(rootParent).SetText('Gift Card');
		end
	end
	if(Mod.Settings.AirliftCard ~= nil)then
		if(Mod.Settings.AirliftCard)then
			if(boundtocard == false)then
				boundtocard = true;
				UI.CreateLabel(rootParent).SetText('Multiattacks are for the current turn enabled, when one of the following cards is played');
				UI.CreateLabel(rootParent).SetText('!!! The cards keep their old effect !!!');
			end
			UI.CreateLabel(rootParent).SetText('Airlift Card');
		end
	end
	if(Mod.Settings.ReconnaisanceCard  ~= nil)then
		if(Mod.Settings.ReconnaisanceCard )then
			if(boundtocard == false)then
				boundtocard = true;
				UI.CreateLabel(rootParent).SetText('Multiattacks are for the current turn enabled, when one of the following cards is played');
				UI.CreateLabel(rootParent).SetText('!!! The cards keep their old effect !!!');
			end
			UI.CreateLabel(rootParent).SetText('Reconnaisance Card');
		end
	end
	if(Mod.Settings.SpyCard  ~= nil)then
		if(Mod.Settings.SpyCard)then
			if(boundtocard == false)then
				boundtocard = true;
				UI.CreateLabel(rootParent).SetText('Multiattacks are for the current turn enabled, when one of the following cards is played');
				UI.CreateLabel(rootParent).SetText('!!! The cards keep their old effect !!!');
			end
			UI.CreateLabel(rootParent).SetText('Spy Card');
		end
	end
end

