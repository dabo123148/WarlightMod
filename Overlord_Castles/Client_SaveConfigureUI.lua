
function Client_SaveConfigureUI(alert)
    
    Mod.Settings.BonusValue = numberInputField1.GetValue();
	Mod.Settings.TroopValue = numberInputField2.GetValue();
	Mod.Settings.MaxBonus = numberInputField3.GetValue();
	Mod.Settings.Chance = numberInputField4.GetValue();
	Mod.Settings.AllowNegative = allowNegativeBonusesCheckBox.GetIsChecked();
end
