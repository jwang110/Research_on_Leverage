function stockData = getDataForYear(stocks, dates, startYear)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
startIndex = find(dates==(startYear-1), 1, 'last');
endIndex = find(dates==startYear, 1, 'last');

% isLeapYear = 0;
% if(mod(startYear,4)==0)
%     if(mod(startYear,100)==0)
%         if(mod(startYear,400)==0)
%             isLeapYear = 1;
%         else
%             isLeapYear = 0;
%         end
%     else
%         isLeapYear = 1;
%     end
% end
% if(isLeapYear)
%     endIndex = endIndex-1; 
% end
stockData = zeros(endIndex-startIndex,1);
for i=1:size(stockData,1)
    stockData(i,1) = stocks(startIndex+i-1);
end

