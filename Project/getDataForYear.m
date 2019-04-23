function [month_data, stock_data] = getDataForYear(data, startYear)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
years = data(:,2);
startIndex = find(years==startYear, 1, 'first');
endIndex = find(years==startYear, 1, 'last');
stock_data = data(startIndex:endIndex,3);
month_data = data(startIndex:endIndex,1);

end


