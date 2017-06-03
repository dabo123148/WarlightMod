function Client_GameRefresh(game)
  if(Mod.PlayerGameData.PendingAlly~=nil)then
    if(tablelength(PendingAlly)>0)then
      UI.Alert('You have ' .. tablelength(PendingAlly) .. ' open ally requests');
    end
  end
  if(Mod.PlayerGameData.PendingPeace~=nil)then
    if(tablelength(PendingPeace)>0)then
      UI.Alert('You have ' .. tablelength(PendingPeace) .. ' open peace requests');
    end
  end
  if(Mod.PlayerGameData.PendingTradements~=nil)then
    if(tablelength(PendingTradements)>0)then
      UI.Alert('You have ' .. tablelength(PendingTradements) .. ' open tradement requests');
    end
  end
end
function tablelength(T)
	local count = 0;
	for _,elem in pairs(T)do
		count = count + 1;
	end
	return count;
end
