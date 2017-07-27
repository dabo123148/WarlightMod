
function Client_PresentSettingsUI(rootParent)
	root = rootParent;
	CreateLine('Just spectators have access to the data : ', Mod.Settings.JustSpectator,true,false);
end
function CreateLine(settingname,variable,default,important)
	local lab = UI.CreateLabel(root);
	if(default == true or default == false)then
		lab.SetText(settingname .. booltostring(variable,default));
	else
		if(variable == nil)then
			lab.SetText(settingname .. default);
		else
			lab.SetText(settingname .. variable);
		end
	end
	if(variable ~= nil and variable ~= default)then
		if(important == true)then
			lab.SetColor('#FF0000');
		else
			lab.SetColor('#FFFF00');
		end
	end
end
function booltostring(variable,default)
	if(variable == nil)then
		if(default)then
			return "Yes";
		else
			return "No";
		end
	end
	if(variable)then
		return "Yes";
	else
		return "No";
	end
end
function AlwaysPlayable(warsetting,peacesetting,allysetting)
	if(peacesetting == nil and allysetting == nil)then
		if(warsetting == nil)then
			return true;
		else
			if(warsetting)then
				return false;
			else
				return true;
			end
		end
	end
	if(peacesetting and allysetting and warsetting)then
		return true;
	end
	return false;
end
