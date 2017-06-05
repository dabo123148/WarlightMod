function Client_PresentMenuUI(RootParent, setMaxSize, setScrollable, game,close)
  rootParent=RootParent;
  Game=game;
  setMaxSize(450, 350);
  if(Mod.Settings.PestCardIn)then
    vertPest=UI.CreateVerticalLayoutGroup(rootParent);
    PestText0=UI.CreateLabel(vertPest).SetText('Pestilence Card: ');
    PestText1=UI.CreateLabel(vertPest).SetText('      You have got '..tostring(Mod.PlayerGameData.PestCards)..' Cards and '..tostring(Mod.PlayerGameData.PestCardPieces)..'/'..Mod.Settings.PestCardPiecesNeeded..' Pieces.');
    if(Mod.PlayerGameData.PestCards>0)then
      PestButton1=UI.CreateButton(vertPest).SetText('Play Pestilence Card').SetOnClick(PlayPestCard);
    end
  end
end
  
function PlayPestCard()
  ClearUI();
  vertPestCard=UI.CreateVerticalLayoutGroup(rootParent);
  PestCardText0=UI.CreateLabel(vertPest).SetText('Select the player you want to play the Pestilence Card on: ');
  local Pestfuncs={};
  for playerID in pairs(Game.Game.Players) do
    if(playerID~=Game.Us.ID)then
      local locPlayerID=playerID;
      Pestfuncs[playerID]=function() Pestilence(locPlayerID); end;
      local pestPlayerButton = UI.CreateButton(vertPestCard).SetText(playerID.DisplayName(nil,false)).SetOnClick(Pestfuncs[playerID]);
    end
  end
  UI.Alert('TEST');
end

function Pestilence(playerID)
  
end

function ClearUI()
  if(vertPest~=nil)then
    UI.Destroy(vertPest);
  end
end
