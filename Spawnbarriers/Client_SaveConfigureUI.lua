
function Client_SaveConfigureUI(alert)
    Mod.Settings.ConnectedArmyNumber = InputConnectedArmyNum.GetValue();
	Mod.Settings.Radius = InputRadius.GetValue();
	if(Mod.Settings.ConnectedArmyNumber < 0)then
		alert('There cannot be less than zero armies.');
	end
	if(Mod.Settings.ConnectedArmyNumber > 100000)then
		alert('That are more armies than warlight supports.');
	end
	if(Mod.Settings.Radius < 1)then
		alert('The Effect Radius can not be less than one, else the Mod would not have any effect and you can remove it.');
	end
	if(Mod.Settings.Radius > 3)then
		alert('Through performence issuses, the maximum Effect Radius is limited to a radius of 3.');
	end
end
