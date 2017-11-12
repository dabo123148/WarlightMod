
function Client_SaveConfigureUI(alert)
	if(inputMoneyPerKilledArmy ~= nil)then
		Mod.Settings.MoneyPerKilledArmy = inputMoneyPerKilledArmy.GetValue();
	end
	if(Mod.Settings.MoneyPerKilledArmy == nil)then
		Mod.Settings.MoneyPerKilledArmy = 0;
	end
	if(Mod.Settings.MoneyPerKilledArmy >10000)then
		alert('Money per killed army is too high');
	end
	if(Mod.Settings.MoneyPerKilledArmy <-10000)then
		alert('Money per killed army is too low');
	end
	if(inputMoneyPerCapturedTerritory ~= nil)then
		Mod.Settings.MoneyPerCapturedTerritory = inputMoneyPerCapturedTerritory.GetValue();
	end
	if(Mod.Settings.MoneyPerCapturedTerritory == nil)then
		Mod.Settings.MoneyPerCapturedTerritory = 0;
	end
	if(Mod.Settings.MoneyPerCapturedTerritory >10000)then
		alert('Money per captured territory is too high');
	end
	if(Mod.Settings.MoneyPerCapturedTerritory <-10000)then
		alert('Money per captured territory is too low');
	end
	if(inputMoneyPerCapturedBonus ~= nil)then
		Mod.Settings.MoneyPerCapturedBonus = inputMoneyPerCapturedBonus.GetValue();
	end
	if(Mod.Settings.MoneyPerCapturedBonus == nil)then
		Mod.Settings.MoneyPerCapturedBonus = 0;
	end
	if(Mod.Settings.MoneyPerCapturedBonus >10000)then
		alert('Money per captured bonus is too high');
	end
	if(Mod.Settings.MoneyPerCapturedBonus <-10000)then
		alert('Money per captured bonus is too low');
	end
	if(Mod.Settings.MoneyPerKilledArmy == 0 and Mod.Settings.MoneyPerCapturedTerritory == 0 and Mod.Settings.MoneyPerCapturedBonus == 0)then
		alert('Please disable the Mod Commerce Plus in order to improve the game speed');
	end
end
