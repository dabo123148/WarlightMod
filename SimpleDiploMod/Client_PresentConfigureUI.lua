
function Client_PresentConfigureUI(rootParent)
	local AIDeclerationinit = Mod.Settings.AllowAIDeclaration;
	if(AIDeclerationinit == nil)then
		AIDeclerationinit = true;
	end
	local SeeAllyTerritoriesinit = Mod.Settings.SeeAllyTerritories;
	if(SeeAllyTerritoriesinit == nil)then
		SeeAllyTerritoriesinit = true;
	end
	local PublicAlliesinit = Mod.Settings.PublicAllies;
	if(PublicAlliesinit == nil)then
		PublicAlliesinit = true;
	end
	texthorz = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(texthorz).SetText('AI Settings');
   	local horz = UI.CreateHorizontalLayoutGroup(rootParent);
	AIDeclerationcheckbox = UI.CreateCheckBox(horz).SetText('Allow AIs to declear war').SetIsChecked(AIDeclerationinit);
	texthorz = UI.CreateHorizontalLayoutGroup(rootParent);
	UI.CreateLabel(texthorz).SetText('Allianze Settings');
	horz = UI.CreateHorizontalLayoutGroup(rootParent);
	SeeAllyTerritoriesCheckbox = UI.CreateCheckBox(horz).SetText('Allow Players to see the territories of their allies').SetIsChecked(SeeAllyTerritoriesinit);
	horz = UI.CreateHorizontalLayoutGroup(rootParent);
	PublicAlliesCheckbox = UI.CreateCheckBox(horz).SetText('Allow everyone to see every ally').SetIsChecked(PublicAlliesinit);
end
