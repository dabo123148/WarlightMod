
function Client_SaveConfigureUI(alert)
	Alert = alert;
  	Mod.Settings.Conditionsrequiredforwin = inputConditionsrequiredforwin.GetValue();
	InRange(Mod.Settings.Conditionsrequiredforwin);
	TakenSettings = 0;
	Mod.Settings.Capturedterritories = inputCapturedterritories.GetValue();
	InRange(Mod.Settings.Capturedterritories);
	Mod.Settings.Lostterritories = inputLostterritories.GetValue();
	InRange(Mod.Settings.Lostterritories);
	Mod.Settings.Ownedterritories = inputOwnedterritories.GetValue();
	InRange(Mod.Settings.Ownedterritories);
	Mod.Settings.Capturedbonuses = inputCapturedbonuses.GetValue();
	InRange(Mod.Settings.Capturedbonuses);
	Mod.Settings.Lostbonuses = inputLostbonuses.GetValue();
	InRange(Mod.Settings.Lostbonuses);
	Mod.Settings.Ownedbonuses = inputOwnedbonuses.GetValue();
	InRange(Mod.Settings.Ownedbonuses);
	Mod.Settings.Killedarmies = inputKilledarmies.GetValue();
	InRange(Mod.Settings.Killedarmies);
	Mod.Settings.Lostarmies = inputLostarmies.GetValue();
	InRange(Mod.Settings.Lostarmies);
	Mod.Settings.Ownedarmies = inputOwnedarmies.GetValue();
	InRange(Mod.Settings.Ownedarmies);
	Mod.Settings.Eleminateais = inputEleminateais.GetValue();
	InRange(Mod.Settings.Eleminateais);
	Mod.Settings.Eleminateplayers = inputEleminateplayers.GetValue();
	InRange(Mod.Settings.Eleminateplayers);
	Mod.Settings.Eleminateaisandplayers = inputEleminateaisandplayers.GetValue();
	InRange(Mod.Settings.Eleminateaisandplayers);
	Mod.Settings.terrcondition = {};
	local num = 1;
	for _,terrcondition in pairs(inputterrcondition)do
		if(terrcondition.Terrname ~= nil and terrcondition.Terrname.GetText() ~= "")then
			Mod.Settings.terrcondition[num] = {};
			Mod.Settings.terrcondition[num].Terrname = terrcondition.Terrname.GetText();
			Mod.Settings.terrcondition[num].Turnnum = terrcondition.Terrname.GetValue();
			if(Turnnum>10)then
				alert("The number of turns per territory can't be higher than 10 to prevent the game from stucking");
			end
			if(setting<0)then
				alert("Numbers can't be negative");
			end
			TakenSettings = TakenSettings + 1;
			num = num + 1;
		end
	end
	if(Mod.Settings.Eleminateaisandplayers > 39 or Mod.Settings.Eleminateplayers > 39 or Mod.Settings.Eleminateais > 39)then
		alert("this many players can't be in a game");
	end
	if(TakenSettings < Mod.Settings.Conditionsrequiredforwin)then
		alert("there are more conditions required to win than conditions set");
	end
	if(Mod.Settings.Conditionsrequiredforwin == 0)then
		alert("You need at least one wining condition");
	end
end
function InRange(setting)
	if(setting>100000)then
		Alert("Numbers can't be higher then 100000");
	end
	if(setting<0)then
		Alert("Numbers can't be negative");
	end
	if(setting ~= 0 and TakenSettings ~= nil)then
		TakenSettings = TakenSettings + 1;
	end
end
