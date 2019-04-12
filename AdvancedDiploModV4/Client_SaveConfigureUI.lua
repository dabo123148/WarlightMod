
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
	Mod.Settings.StartWar = {};
end
