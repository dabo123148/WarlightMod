
function Client_SaveConfigureUI(alert)
    
	local Stacklim = StackLimitInputfield.GetValue();
	InRange(Stacklim,2,100000,"Stack Limit",alert);
	Mod.Settings.StackLimit =Stacklim;
	Mod.Settings.IncludeNeutral = EffectsNeutralCheckBox.GetIsChecked();
	if(Mod.Settings.IncludeNeutral == nil)then
		Mod.Settings.IncludeNeutral = true;
	end
end
function InRange(value,min,max,name,alert)
	if(value <min)then
		alert(name .. " is too low(game would be stuck)");
	end
	if(value > max)then
		alert(name .. " is too high");
	end
end