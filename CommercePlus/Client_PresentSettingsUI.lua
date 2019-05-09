
function Client_PresentSettingsUI(rootParent)
	root = rootParent;
	CreateLine('Extra money per killed army : ', Mod.Settings.MoneyPerKilledArmy,1);
	CreateLine('Extra money per captured territory : ', Mod.Settings.MoneyPerCapturedTerritory,5);
	CreateLine('Extra money per captured bonus : ', Mod.Settings.MoneyPerCapturedBonus,10);
end
function CreateLine(settingname,variable,default,important)
	local lab = UI.CreateLabel(root);
	if(variable == nil)then
	--This is just required in case new settings get added
		lab.SetText(settingname .. default);
	else
		if(variable == 0)then
			lab.SetText(settingname .. disabled);
		else
			lab.SetText(settingname .. variable);
		end
	end
	if(variable ~= nil and variable ~= default)then
	--when the settings isn't unknown(later added) and not default, this sets the text color to yellow
		lab.SetColor('#FFFF00');
	end
end
