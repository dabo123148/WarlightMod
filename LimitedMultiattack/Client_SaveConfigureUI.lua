
function Client_SaveConfigureUI(alert)
    Mod.Settings.MaxAttacks = InputMaxAttacks.GetValue();
	if( Mod.Settings.MaxAttacks == nil)then
		Mod.Settings.MaxAttacks = 5;
	end
	if( Mod.Settings.MaxAttacks < 1)then
		alert('With this Settings, it is impossible to win a game through elimination.');
	end
	if( Mod.Settings.MaxAttacks > 100000)then
		alert('The number is too big.');
	end
end