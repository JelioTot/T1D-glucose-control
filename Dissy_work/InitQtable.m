function Qvalues = InitQtable(Top, maxVal, minVal, actionCnt)
Qvalues = (maxVal-minVal)*(rand(Top, actionCnt) - 0.5) + (maxVal+minVal)/2;


end
