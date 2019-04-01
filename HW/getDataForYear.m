function stockData = getDataForYear(stocks, dates, startYear)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
startIndex = find(dates==(startYear-1), 1, 'last');
endIndex = find(dates==startYear, 1, 'last');
stockData = zeros(endIndex-startIndex,1);
for i=1:size(stockData,1)
    stockData(i,1) = stocks(startIndex+i-1);
end

