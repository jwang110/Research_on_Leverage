function proximity(filename, dates, m, var)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
load(filename);
numyear=size(data,2);
per=size(data{1,1},2);
s=size(data{1,1}{1,1},2);
font=20;

prox = zeros(s,numyear*per);
index= 1;

for i=1:numyear
    for j=1:per
        prox(:, index) = calcProx(var{1,i}{1,j},m{1,i}{1,j}',s);
    end
end

prox_diff = zeros(s, numyear*per-1);
for i=2:index
    prox_diff(i,:) = prox(i,:)-prox(i-1,:);
end

figure;
hold all;
datetick('x','yyyy');

for i=1:s
   plot(dates(1,2:end, prox_diff(:,1)));    
end

end

