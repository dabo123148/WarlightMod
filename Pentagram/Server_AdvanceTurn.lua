
function Server_AdvanceTurn_Order(game,order,result,skipOrder,addOrder)
    if(order.proxyType=='GameOrderAttackTransfer')then
		FromID=order.From;
		ToID=order.To;
		FromID1=FromID-(FromID%10);
		ToID1=ToID-(ToID%10);
		FromID2=FromID%10;
		ToID2=ToID%10;
		if(FromID1==ToID1)then
			if not PentagonPossibleSmall(FromID2,ToID2) then
				skipOrder(WL.ModOrderControl.SkipAndSupressSkipMassage);
			end
		else
			if not PentagonPossibleBig(FromID1,ToID1) then
				skipOrder(WL.ModOrderControl.SkipAndSupressSkipMassage);
			end
		end
	end
end
function PentagonPossibleSmall(FromID,ToID)
	if((FromID-ToID)%5==1 or (FromID-ToID)%5==3)then
		return true;
	else
		return false;
	end
end
function PentagonPossibleBig(FromID,ToID)
	if((ToID-FromID)%5==1 or (ToID-FromID)%5==3)then
		return true;
	else
		return false;
	end
end
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
