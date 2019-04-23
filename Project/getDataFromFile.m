function data= getDataFromFile(filename)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
[numtemp, datetext, rawtemp] = xlsread(filename, 'A:A');
stockData = xlsread(filename,'F:F');
numDataPoints = size(datetext,1);
dates = zeros(numDataPoints-1,2);

for i=2:numDataPoints
   dates(i,1) =  str2num(datestr(cell2mat(datetext(i,1)),'mm'));
   dates(i,2) =  str2num(datestr(cell2mat(datetext(i,1)),'yyyy'));
end

for i=2:size(stockData,1)
    if isnan(stockData(i)) 
        stockData(i) = stockData(i-1);
    end
    
end

size(dates)
size(stockData)
data = horzcat(dates, stockData);
end

