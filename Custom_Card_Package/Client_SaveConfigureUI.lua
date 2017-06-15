
function Client_SaveConfigureUI(alert)
        Mod.Settings.PestCardIn=PestCardCheckbox.GetIsChecked();
        if( Mod.Settings.PestCardIn==true)then
                 Mod.Settings.PestCardStrength=PestCardStrengthSlider.GetValue();
                 Mod.Settings.PestCardPiecesNeeded=PestCardPiecesNeededBox.GetValue();
                 Mod.Settings.PestCardStartPieces=PestCardStartPiecesBox.GetValue();
        end
end
