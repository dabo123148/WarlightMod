
function Client_SaveConfigureUI(alert)
   	Mod.Settings.MaxAttacks = InputMaxAttacks.GetValue();
	if( Mod.Settings.MaxAttacks == nil)then
		Mod.Settings.MaxAttacks = 5;
	end
	if( Mod.Settings.MaxAttacks < 0)then
		alert('If you can explain me what you understand under negative attacks, I will add it.');
	end
	if( Mod.Settings.MaxAttacks > 100000)then
		alert('The number is too big.');
	end
	Mod.Settings.ContinueAttackIfFailed = InputContinueAttackIfFailed.GetIsChecked();
	if( Mod.Settings.ContinueAttackIfFailed == nil)then
		Mod.Settings.ContinueAttackIfFailed = true;
	end
	local boundtocards = false;
	Mod.Settings.ReinforcementCard = InputReinforcementCard.GetIsChecked();
	if( Mod.Settings.ReinforcementCard == nil)then
		Mod.Settings.ReinforcementCard = false;
	else
		if(Mod.Settings.ReinforcementCard)then
			boundtocards=true;
		end
	end
	Mod.Settings.GiftCard = InputGiftCard.GetIsChecked();
	if( Mod.Settings.GiftCard == nil)then
		Mod.Settings.GiftCard = false;
	else
		if(Mod.Settings.GiftCard)then
			boundtocards=true;
		end
	end
	Mod.Settings.AirliftCard = InputAirliftCard.GetIsChecked();
	if( Mod.Settings.AirliftCard == nil)then
		Mod.Settings.AirliftCard = false;
	else
		if(Mod.Settings.AirliftCard)then
			boundtocards=true;
		end
	end
	Mod.Settings.ReconnaisanceCard = InputReconnaisanceCard.GetIsChecked();
	if( Mod.Settings.ReconnaisanceCard == nil)then
		Mod.Settings.ReconnaisanceCard = false;
	else
		if(Mod.Settings.ReconnaisanceCard)then
			boundtocards=true;
		end
	end
	Mod.Settings.SpyCard = InputSpyCard.GetIsChecked();
	if( Mod.Settings.SpyCard == nil)then
		Mod.Settings.SpyCard = false;
	else
		if(Mod.Settings.SpyCard)then
			boundtocards=true;
		end
	end
	Mod.Settings.SurveillanceCard = InputSurveillanceCard.GetIsChecked();
	if( Mod.Settings.SurveillanceCard == nil)then
		Mod.Settings.SurveillanceCard = false;
	else
		if(Mod.Settings.SurveillanceCard)then
			boundtocards=true;
		end
	end
	if(boundtocards == false)then
		if(Mod.Settings.MaxAttacks==0)then
			alert('With this settings, the mod has no effect');
		end
	end
end
