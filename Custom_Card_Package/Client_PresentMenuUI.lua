function Client_PresentMenuUI(RootParent, setMaxSize, setScrollable, game,close)
  rootParent=RootParent;
  Game=game;
  vertPestCard=nil;
  PestCards=Mod.PlayerGameData.PestCards;
  if(PestCards==nil)then
    PestCards=0;
  end
	if(Mod.PlayerGameData.NukeCards~=nil)then
		NukeCards=Mod.PlayerGameData.NukeCards;
  		if(PestCards==nil)then
   			NukeCards=0;
  		end
	end
  setMaxSize(450, 350);
	if(game.Us~=nil)then
  	ShowFirstMenu();
	end
end
  
function ShowFirstMenu()
	
	if(Mod.Settings.PestCardIn)then
		PestCardsPlayed=0;
		for order in pairs(Game.Orders) do
			if(Game.Orders[order].proxyType=="GameOrderCustom")then
				if(Game.Orders[order].Payload~=nil)then
					if(split(Game.Orders[order].Payload,'|')[1]=='Pestilence')then
						PestCardsPlayed=PestCardsPlayed+1;
					end
				end
			end
	  	end
		PestCardsFree=PestCards-PestCardsPlayed;
    		vertPest=UI.CreateVerticalLayoutGroup(rootParent);
    		PestText0=UI.CreateLabel(vertPest).SetText('Pestilence Card: ');
    		PestText1=UI.CreateLabel(vertPest).SetText('      You have got '..tostring(PestCardsFree)..' Cards and '..tostring(Mod.PlayerGameData.PestCardPieces)..'/'..Mod.Settings.PestCardPiecesNeeded..' Pieces.');
    		if(PestCardsFree>0)then
      			PestButton1=UI.CreateButton(vertPest).SetText('Play Pestilence Card').SetOnClick(PlayPestCard);
    		end
  	end
	if(Mod.Settings.NukeCardIn ~= nil and Mod.Settings.NukeCardIn)then
		NukeCardsPlayed=0;
		for order in pairs(Game.Orders) do
			if(Game.Orders[order].proxyType=="GameOrderCustom")then
				if(Game.Orders[order].Payload~=nil)then
					if(split(Game.Orders[order].Payload,'|')[1]=='Nuke')then
						NukeCardsPlayed=NukeCardsPlayed+1;
					end
				end
			end
	  	end
	  	NukeCardsFree=NukeCards-NukeCardsPlayed;
    	  	vertPest=UI.CreateVerticalLayoutGroup(rootParent);
          	PestText0=UI.CreateLabel(vertPest).SetText('Nuke Card: ');
          	PestText1=UI.CreateLabel(vertPest).SetText('      You have got '..tostring(NukeCardsFree)..' Cards and '..tostring(Mod.PlayerGameData.NukeCardPieces)..'/'..Mod.Settings.NukeCardPiecesNeeded..' Pieces.');
          	if(NukeCardsFree>0)then
    			PestButton1=UI.CreateButton(vertPest).SetText('Play Nuke Card').SetOnClick(PlayNukeCard);
    	 	end
   	end
end

function PlayNukeCard()
	options = map(Game.Map.Territories,SelectTerritory);
	UI.PromptFromList("Select the territory, you like to nuke", options);
end
function map(array, func)
	local new_array = {};
	local i = 1;
	for _,v in pairs(array) do
		new_array[i] = func(v);
		i = i + 1;
	end
	return new_array;
end
function SelectTerritory(terr)
	local name = terr.Name;
	local ret = {};
	ret["text"] = name;
	ret["selected"] = function() 
		local orders = Game.Orders;
		table.insert(orders, WL.GameOrderCustom.Create(Game.Us.ID, "Play a Pestilence Card on " .. name, 'Nuke|'..terr.ID));
		Game.Orders = orders;
	end
	return ret;
end
function PlayPestCard()
  ClearUI();
  vertPestCard=UI.CreateVerticalLayoutGroup(rootParent);
  PestCardText0=UI.CreateLabel(vertPestCard).SetText('Select the player you want to play the Card on. Players who are already pestilenced will not be shown. Dont play 2 cards on one player, they are not stackable.');
  local Pestfuncs={};
  for playerID in pairs(Game.Game.Players) do
		
    if(playerID~=Game.Us.ID)then
      if(Mod.PublicGameData.PestilenceStadium[playerID]~=nil)then
				if(Mod.PublicGameData.PestilenceStadium[playerID]==0)then
      		local locPlayerID=playerID;
      		Pestfuncs[playerID]=function() Pestilence(locPlayerID); end;
      		local pestPlayerButton = UI.CreateButton(vertPestCard).SetText(toname(playerID,Game)).SetOnClick(Pestfuncs[playerID]);
    		end
			else
				local locPlayerID=playerID;
      	Pestfuncs[playerID]=function() Pestilence(locPlayerID); end;
      	local pestPlayerButton = UI.CreateButton(vertPestCard).SetText(toname(playerID,Game)).SetOnClick(Pestfuncs[playerID]);
			end
		end
  end
end

function Pestilence(playerID)
  ClearUI();
	orders=Game.Orders;
	--Game.SendGameCustomMessage('Waiting for the server to respond...',{PestCardPlayer=playerID},PestCardPlayedCallback);
	table.insert(orders, WL.GameOrderCustom.Create(Game.Us.ID, "Play a Pestilence Card on " .. toname(playerID,Game), 'Pestilence|'..tostring(playerID)));
	Game.Orders=orders;
end

function PestCardPlayedCallback()
	ShowFirstMenu();
end

function ClearUI()
  if(vertPest~=nil)then
    UI.Destroy(vertPest);
    vertPest = nil;
  end
  if(vertPestCard~=nil)then
    UI.Destroy(vertPestCard);
		vertPestCard=nil;
  end
end

---------------------------------------------
---------------------------------------------
----                                     ----
----         COMFORT FUNCTIONS           ----
----                                     ----
---------------------------------------------
---------------------------------------------

function Contains(array,object)
  for obj in pairs(array) do
    if(obj==object)then
      return true;
    end
  end
  return false;
end

function toname(playerid,game)
	for _,playerinfo in pairs(game.Game.Players)do
		if(playerid == playerinfo.ID)then
			return playerinfo.DisplayName(nil, false);
		end
	end
	return "Error - Player ID not found. Please report to melwei[PG].";
end
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
function split(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end
