
function Client_PresentSettingsUI(rootParent)
	root = rootParent;
	if(Mod.Settings.ReinforcementCardCost ~=nil)then
	if(Mod.Settings.ReinforcementCardCost ~= 0)then
		CreateLine('Reinforcement Card Cost : ',Mod.Settings.ReinforcementCardCost,Mod.Settings.ReinforcementCardCost);
	else
		CreateTextLine('Reinforcement Cards can not be purchased');
	end
		end
	if(Mod.Settings.GiftCardCost ~= 0)then
		CreateLine('Gift Card Cost : ',Mod.Settings.GiftCardCost,Mod.Settings.GiftCardCost);
	else
		CreateTextLine('Gift Cards can not be purchased');
	end
	if(Mod.Settings.SpyCardCost ~= 0)then
		CreateLine('Spy Card Cost : ',Mod.Settings.SpyCardCost,Mod.Settings.SpyCardCost);
	else
		CreateTextLine('Spy Cards can not be purchased');
	end
	if(Mod.Settings.EmergencyBlockadeCardCost ~= 0)then
		CreateLine('Emergency blockade Card Cost : ',Mod.Settings.EmergencyBlockadeCardCost,Mod.Settings.EmergencyBlockadeCardCost);
	else
		CreateTextLine('Emergency blockade Cards can not be purchased');
	end
	if(Mod.Settings.BlockadeCardCost ~= 0)then
		CreateLine('Blockade Card Cost : ',Mod.Settings.BlockadeCardCost,Mod.Settings.BlockadeCardCost);
	else
		CreateTextLine('Blockade Cards can not be purchased');
	end
	if(Mod.Settings.OrderPriorityCardCost ~= 0)then
		CreateLine('Order priority Card Cost : ',Mod.Settings.OrderPriorityCardCost,Mod.Settings.OrderPriorityCardCost);
	else
		CreateTextLine('Order priority Cards can not be purchased');
	end
	if(Mod.Settings.OrderDelayCardCost ~= 0)then
		CreateLine('Order delay Card Cost : ',Mod.Settings.OrderDelayCardCost,Mod.Settings.OrderDelayCardCost);
	else
		CreateTextLine('Order delay Cards can not be purchased');
	end
	if(Mod.Settings.AirliftCardCost ~= 0)then
		CreateLine('Airlift Card Cost : ',Mod.Settings.AirliftCardCost,Mod.Settings.AirliftCardCost);
	else
		CreateTextLine('Airlift Cards can not be purchased');
	end
	if(Mod.Settings.DiplomacyCardCost ~= 0)then
		CreateLine('Diplomacy Card Cost : ',Mod.Settings.DiplomacyCardCost,Mod.Settings.DiplomacyCardCost);
	else
		CreateTextLine('Diplomacy Cards can not be purchased');
	end
	if(Mod.Settings.SanctionsCardCost ~= 0)then
		CreateLine('Sanctions Card Cost : ',Mod.Settings.SanctionsCardCost,Mod.Settings.SanctionsCardCost);
	else
		CreateTextLine('Sanctions Cards can not be purchased');
	end
	if(Mod.Settings.SurveillanceCardCost ~= 0)then
		CreateLine('Surveillance Card Cost : ',Mod.Settings.SurveillanceCardCost,Mod.Settings.SurveillanceCardCost);
	else
		CreateTextLine('Surveillance Cards can not be purchased');
	end
	if(Mod.Settings.ReconnaissanceCardCost ~= 0)then
		CreateLine('Reconnaissance Card Cost : ',Mod.Settings.ReconnaissanceCardCost,Mod.Settings.ReconnaissanceCardCost);
	else
		CreateTextLine('Reconnaissance Cards can not be purchased');
	end
	if(Mod.Settings.BombCardCost ~= 0)then
		CreateLine('Bomb Card Cost : ',Mod.Settings.BombCardCost,Mod.Settings.BombCardCost);
	else
		CreateTextLine('Bomb Cards can not be purchased');
	end
end
function CreateTextLine(text)
	local lab = UI.CreateLabel(root);
	lab.SetText(text);
end
function CreateLine(settingname,variable,default,important)
	local lab = UI.CreateLabel(root);
	if(default == true or default == false)then
		lab.SetText(settingname .. booltostring(variable,default));
	else
		if(variable == nil)then
			lab.SetText(settingname .. default);
		else
			lab.SetText(settingname .. variable);
		end
	end
	if(variable ~= nil and variable ~= default)then
		if(important == true)then
			lab.SetColor('#FF0000');
		else
			lab.SetColor('#FFFF00');
		end
	end
end
function booltostring(variable,default)
	if(variable == nil)then
		if(default)then
			return "Yes";
		else
			return "No";
		end
	end
	if(variable)then
		return "Yes";
	else
		return "No";
	end
end
function AlwaysPlayable(warsetting,peacesetting,allysetting)
	if(peacesetting == nil and allysetting == nil)then
		if(warsetting == nil)then
			return true;
		else
			if(warsetting)then
				return false;
			else
				return true;
			end
		end
	end
	if(peacesetting and allysetting and warsetting)then
		return true;
	end
	return false;
end
function NeverPlayable(warsetting,peacesetting,allysetting)
	if(peacesetting == nil and allysetting == nil)then
		return false;
	end
	if(peacesetting == false and allysetting  == false and warsetting == false)then
		return true;
	end
	return false;
end
