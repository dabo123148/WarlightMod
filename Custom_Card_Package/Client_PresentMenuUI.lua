function Client_PresentMenuUI(rootParent, setMaxSize, setScrollable, game,close)
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
    UI.Alert('TEST');
end
