
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
	if(inputStartMoney ~= nil)then
		Mod.Settings.StartMoney = inputStartMoney.GetValue();
	end
	if(Mod.Settings.StartMoney == nil)then
		Mod.Settings.StartMoney = 0;
	end
	if(Mod.Settings.StartMoney >10000)then
		alert('Start Money is too high');
	end
	if(Mod.Settings.StartMoney <-10000)then
		alert('Start Money is too low');
	end
	if(inputMoneyPerTurn ~= nil)then
		Mod.Settings.MoneyPerTurn = inputMoneyPerTurn.GetValue();
	end
	if(Mod.Settings.MoneyPerTurn == nil)then
		Mod.Settings.MoneyPerTurn = 0;
	end
	if(Mod.Settings.MoneyPerTurn >10000)then
		alert('Money per turn is too high');
	end
	if(Mod.Settings.MoneyPerTurn <-10000)then
		alert('Money per turn is too low');
	end
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
	if(inputMoneyPerBoughtArmy ~= nil)then
		Mod.Settings.MoneyPerBoughtArmy = inputMoneyPerBoughtArmy.GetValue();
	end
	if(Mod.Settings.MoneyPerBoughtArmy == nil)then
		Mod.Settings.MoneyPerBoughtArmy = 0;
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
	Mod.Settings.SanctionCardRequirePeace = inputSanctionCardRequirePeace.GetIsChecked();
	if(Mod.Settings.SanctionCardRequirePeace == nil)then
		Mod.Settings.SanctionCardRequirePeace = false;
	end
	Mod.Settings.SanctionCardRequireAlly = inputSanctionCardRequireAlly.GetIsChecked();
	if(Mod.Settings.SanctionCardRequireAlly == nil)then
		Mod.Settings.SanctionCardRequireAlly = false;
	end
	Mod.Settings.BombCardRequireWar = inputBombCardRequireWar.GetIsChecked();
	if(Mod.Settings.BombCardRequireWar == nil)then
		Mod.Settings.BombCardRequireWar = true;
	end
	Mod.Settings.BombCardRequirePeace = inputBombCardRequirePeace.GetIsChecked();
	if(Mod.Settings.BombCardRequirePeace == nil)then
		Mod.Settings.BombCardRequirePeace = false;
	end
	Mod.Settings.BombCardRequireAlly = inputBombCardRequireAlly.GetIsChecked();
	if(Mod.Settings.BombCardRequireAlly == nil)then
		Mod.Settings.BombCardRequireAlly = false;
	end
	Mod.Settings.SpyCardRequireWar = inputSpyCardRequireWar.GetIsChecked();
	if(Mod.Settings.SpyCardRequireWar == nil)then
		Mod.Settings.SpyCardRequireWar = true;
	end
	Mod.Settings.SpyCardRequirePeace = inputSpyCardRequirePeace.GetIsChecked();
	if(Mod.Settings.SpyCardRequirePeace == nil)then
		Mod.Settings.SpyCardRequirePeace = false;
	end
	Mod.Settings.SpyCardRequireAlly = inputSpyCardRequireAlly.GetIsChecked();
	if(Mod.Settings.SpyCardRequireAlly == nil)then
		Mod.Settings.SpyCardRequireAlly = false;
	end
	Mod.Settings.GiftCardRequireWar = inputGiftCardRequireWar.GetIsChecked();
	if(Mod.Settings.GiftCardRequireWar == nil)then
		Mod.Settings.GiftCardRequireWar = false;
	end
	Mod.Settings.GiftCardRequirePeace = inputGiftCardRequirePeace.GetIsChecked();
	if(Mod.Settings.GiftCardRequirePeace == nil)then
		Mod.Settings.GiftCardRequirePeace = false;
	end
	Mod.Settings.GiftCardRequireAlly = inputGiftCardRequireAlly.GetIsChecked();
	if(Mod.Settings.GiftCardRequireAlly == nil)then
		Mod.Settings.GiftCardRequireAlly = true;
	end
	if(Mod.Settings.MoneyPerBoughtArmy < Mod.Settings.MoneyPerKilledArmy)then
		alert('You cannot set the the money you earn per killed army higher than the price per army');
	end
	Mod.Settings.AdminAccess = inputAdminaccess.GetIsChecked();
	if(Mod.Settings.AdminAccess == nil)then
		Mod.Settings.AdminAccess = true;
	end
end
