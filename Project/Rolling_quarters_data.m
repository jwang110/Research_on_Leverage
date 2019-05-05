%% 
function [rolling_quarter]=Rolling_quarters_data(numyear,per)
load('data_quart_2002.mat');
numyear=size(data,2);
per=size(data{1,1},2);
n=1;
for i=1:numyear
    for j=1:per
        all_quarter_data{1,n}=data{1,i}{1,j};
        n=n+1;
    end
end

for k=1:(size(all_quarter_data,2)-3)
    rolling_quarter{1,k}=[all_quarter_data{1,k};all_quarter_data{1,k+1};...
        all_quarter_data{1,k+3};all_quarter_data{1,k+3}];
end