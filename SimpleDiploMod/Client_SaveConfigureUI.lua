
function Client_SaveConfigureUI(alert)
  	Mod.Settings.AllowAIDeclaration = AIDeclerationcheckbox.GetIsChecked();
	if(Mod.Settings.AllowAIDeclaration == nil)then
		Mod.Settings.AllowAIDeclaration = true;
	end
	Mod.Settings.AIsdeclearAIs = AIsdeclearAIsinitcheckbox.GetIsChecked();
	if(Mod.Settings.AIsdeclearAIs == nil)then
		Mod.Settings.AIsdeclearAIs = true;
	end
	Mod.Settings.SeeAllyTerritories = SeeAllyTerritoriesCheckbox.GetIsChecked();
	if(Mod.Settings.SeeAllyTerritories == nil)then
		Mod.Settings.SeeAllyTerritories = true;
	end
	Mod.Settings.PublicAllies = PublicAlliesCheckbox.GetIsChecked();
	if(Mod.Settings.PublicAllies == nil)then
		Mod.Settings.PublicAllies = true;
	end
	Mod.Settings.StartMoney = inputStartMoney.GetValue();
	if(Mod.Settings.StartMoney == nil)then
		Mod.Settings.StartMoney = 100;
	end
	if(Mod.Settings.StartMoney >10000)then
		alert('Start Money is too high');
	end
	if(Mod.Settings.StartMoney <-10000)then
		alert('Start Money is too low');
	end
	Mod.Settings.MoneyPerTurn = inputMoneyPerTurn.GetValue();
	if(Mod.Settings.MoneyPerTurn == nil)then
		Mod.Settings.MoneyPerTurn = 5;
	end
	if(Mod.Settings.MoneyPerTurn >10000)then
		alert('Money per turn is too high');
	end
	if(Mod.Settings.MoneyPerTurn <-10000)then
		alert('Money per turn is too low');
	end
	Mod.Settings.MoneyPerKilledArmy = inputMoneyPerKilledArmy.GetValue();
	if(Mod.Settings.MoneyPerKilledArmy == nil)then
		Mod.Settings.MoneyPerKilledArmy = 1;
	end
	if(Mod.Settings.MoneyPerKilledArmy >10000)then
		alert('Money per killed army is too high');
	end
	if(Mod.Settings.MoneyPerKilledArmy <-10000)then
		alert('Money per killed army is too low');
	end
	Mod.Settings.MoneyPerCapturedTerritory = inputMoneyPerCapturedTerritory.GetValue();
	if(Mod.Settings.MoneyPerCapturedTerritory == nil)then
		Mod.Settings.MoneyPerCapturedTerritory = 1;
	end
	if(Mod.Settings.MoneyPerCapturedTerritory >10000)then
		alert('Money per captured territory is too high');
	end
	if(Mod.Settings.MoneyPerCapturedTerritory <-10000)then
		alert('Money per captured territory is too low');
	end
	Mod.Settings.MoneyPerCapturedBonus = inputMoneyPerCapturedBonus.GetValue();
	if(Mod.Settings.MoneyPerCapturedBonus == nil)then
		Mod.Settings.MoneyPerCapturedBonus = 1;
	end
	if(Mod.Settings.MoneyPerCapturedBonus >10000)then
		alert('Money per captured bonus is too high');
	end
	if(Mod.Settings.MoneyPerCapturedBonus <-10000)then
		alert('Money per captured bonus is too low');
	end
	Mod.Settings.MoneyPerBoughtArmy = inputMoneyPerBoughtArmy.GetValue();
	if(Mod.Settings.MoneyPerBoughtArmy == nil)then
		Mod.Settings.MoneyPerBoughtArmy = 1;
	end
	if(Mod.Settings.MoneyPerBoughtArmy <0)then
		alert('You cannot ear money for buying armies');
	end
	if(Mod.Settings.MoneyPerBoughtArmy ==0)then
		alert('The price per army must be grader than 0');
	end
	Mod.Settings.SanctionCardRequireWar = inputSanctionCardRequireWar.GetIsChecked();
	if(Mod.Settings.SanctionCardRequireWar == nil)then
		Mod.Settings.SanctionCardRequireWar = true;
	end
	Mod.Settings.BombCardRequireWar = inputBombCardRequireWar.GetIsChecked();
	if(Mod.Settings.BombCardRequireWar == nil)then
		Mod.Settings.BombCardRequireWar = true;
	end
	if(Mod.Settings.MoneyPerBoughtArmy < Mod.Settings.MoneyPerKilledArmy)then
		alert('You cannot set the army price higher than the money you earn per killed army');
	end
	Mod.Settings.AdminAccess = inputAdminaccess.GetValue();
	if(Mod.Settings.AdminAccess == nil)then
		Mod.Settings.AdminAccess = true;
	end
end
