
function Client_SaveConfigureUI(alert)
    
	local SL = numberInputField1.GetValue();
	if(SL < 2)then
		SL=2;
		alert('Stack Limit is too low');
	end
	if(SL > 100000)then
		SL=100000;
		alert('Stack Limit is too high');
	end
	Mod.Settings.StackLimit =SL;
end
