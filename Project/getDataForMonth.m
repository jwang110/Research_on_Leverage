function stock_data = getDataForMonth(months, data, month)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
startIndex = find(months==month, 1, 'first');
endIndex = find(months==month, 1, 'last');
stock_data = data(startIndex:endIndex,1);
end
