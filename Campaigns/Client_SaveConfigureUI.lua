
function Client_SaveConfigureUI(alert)
    
    Mod.Settings.CampaignCode = {};
    for elem in pairs(fields) do
        Mod.Settings.CampaignCode[elem]=fields[elem].GetText();
    end
end
