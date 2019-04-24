function  dimensionalityGraphs(filename, dates)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
load(filename);
numyear=size(data,2);
per=size(data{1,1},2);
s=size(data{1,1}{1,1},2);

dim_avg = zeros(1,numyear*per);
dim_avg_large = zeros(1,numyear*per);
dim_avg_ratio = zeros(1,numyear*per);
counter = 0;

for k=.1:.005:.3
    index =1;
    dim = zeros(1,numyear*per);
    dim_ratio = zeros(1,numyear*per);
    eig_second = zeros(1,numyear*per);
    for i=1:numyear
        for j=1:per
            [dim_largest, dim_ratio_method] = calcDim(data{1,i}{1,j},k);
            dim(1,index) = dim_largest;
            dim_ratio(1,index) = dim_ratio_method;

            eigenvalues = sort(eig(cov(data{1,i}{1,j})),'descend');
            eigenvalues = eigenvalues/eigenvalues(1);
            eig_second(1,index) = eigenvalues(2);
            index = index+1;
        end
    end
%     figure;
%     hold on;
%     plot(dates, dim(1,:));
%     plot (dates, dim_ratio(1,:));
%     title(strcat('ratio method ', num2str(k)));
%     legend('largest method', 'ratio method');
%     datetick('x','yyyy');
%     
    counter = counter+1;
    dim_avg(1,:) = dim_avg(1,:) + dim(1,:) + dim_ratio(1,:);
    dim_avg_large(1,:) = dim_avg_large(1,:) + dim(1,:);
    dim_avg_ratio(1,:) = dim_avg_ratio(1,:) + dim_ratio(1,:);
end

dim_avg = dim_avg/(2*counter);
dim_avg_large = dim_avg_large/(counter);
dim_avg_ratio = dim_avg_ratio/(counter);
% 
% figure;
% hold on;
% plot(dates, dim_avg)
% datetick('x','yyyy');
% title('both');

figure;
hold on;
plot(dates, dim_avg_large)
datetick('x','yyyy');
title('largest');
% 
% 
% figure;
% hold on;
% plot(dates, dim_avg_ratio)
% datetick('x','yyyy');
% title('ratio');

dim_diff = zeros(1, length(dim_avg_large)-1);
for i=2:length(dim_avg_large)
    dim_diff(i-1) = dim_avg_large(i)-dim_avg_large(i-1);
end

figure;
hold on;
plot(dates(1,2:end), dim_diff);
datetick('x','yyyy');
title('dim change');

% figure;
% hold all;
% for i=1:3
%     plot(dates, dim(i,:));
% end
% datetick('x','yyyy');

figure;
hold on;
plot(dates, eig_second);
datetick('x','yyyy');
end

