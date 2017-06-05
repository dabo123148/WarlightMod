function Client_PresentMenuUI(rootParent)
  setMaxSize(450, 350);
  if(Mod.Settings.PestCardIn)then
    vertPest=UI.CreateVerticalLayoutGroup(rootParent);
    text1=UI.CreateLayer(vertPest).SetText('You have got '..tostring(Mod.PlayerGameData[Game.Us.ID].PestCards)..' and '..tostring(Mod.PlayerGameData[Game.Us.ID].PestCardPieces)..'/'..Mod.Settings.PestCardPiecesNeeded..' Pieces.');
  end
end
