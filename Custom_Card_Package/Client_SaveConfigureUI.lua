
function Client_SaveConfigureUI(alert)
        Mod.Settings.PestCardIn=PestCardCheckbox.GetIsChecked();
        if(Mod.Settings.PestCardIn==true)then
                 Mod.Settings.PestCardStrength=PestCardStrengthSlider.GetValue();
                 Mod.Settings.PestCardPiecesNeeded=PestCardPiecesNeededBox.GetValue();
                 Mod.Settings.PestCardStartPieces=PestCardStartPiecesBox.GetValue();
        end
        Mod.Settings.NukeCardIn =NukeCardCheckbox.GetIsChecked();
        if(Mod.Settings.NukeCardIn == true)then
                Mod.Settings.AfterDeployment = AfterDeploymentToggle.GetValue;
                Mod.Settings.Friendlyfire=FriendlyfireToggle.GetIsChecked();
                Mod.Settings.NukeCardPiecesNeeded=NukeCardPiecesNeededBox.GetValue();
                Mod.Settings.NukeCardStartPieces=NukeCardStartPiecesBox.GetValue();
                Mod.Settings.NukeCardMainTerritoryDamage=NukeCardMainTerritoryDamageSlider.GetValue();
                Mod.Settings.NukeCardConnectedTerritoryDamage=NukeCardConnectedTerritoryDamageSlider.GetValue();
                if(Mod.Settings.NukeCardMainTerritoryDamage<0 or Mod.Settings.NukeCardConnectedTerritoryDamage<0)then
                        alert('To be fair, negative damage is blocked for the nuke card');
                end
                 if(Mod.Settings.NukeCardMainTerritoryDamage>100 or Mod.Settings.NukeCardConnectedTerritoryDamage>100)then
                        alert('You cannot deal more than 100% Damage');
                end
        end
end
