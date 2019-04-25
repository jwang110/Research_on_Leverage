function proximity(dates, m, var)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
numyear=size(var,2);
per = size(var{1,1},2);
s = size(var{1,1}{1,1},2);
font=20;

prox = zeros(numyear*per, s);
index= 1;

for i=1:numyear
    for j=1:per
        prox(index, :) = calcProx(var{1,i}{1,j},m{1,i}{1,j}',s);
        index = index+1;
    end
end

prox_diff = zeros(numyear*per-1,s);
for i=2:numyear*per
    prox_diff(i-1,:) = prox(i,:)-prox(i-1,:);
end

for i=1:s
    figure;
    hold on;
    plot(dates(1,2:end), prox_diff(:,i));    
end
datetick('x','yyyy');

end

