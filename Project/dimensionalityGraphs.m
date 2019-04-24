function  dimensionalityGraphs(filename, dates)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
load(filename);
numyear=size(data,2);
per=size(data{1,1},2);
s=size(data{1,1}{1,1},2);

dim = zeros(3,numyear*per);
eig_second = zeros(1,numyear*per);
index =1;
for i=1:numyear
    for j=1:per
        dim(1,index) = calcDim(data{1,i}{1,j},.3);
        dim(2,index) = calcDim(data{1,i}{1,j},.4);
        dim(3,index) = calcDim(data{1,i}{1,j},.5);
        eigenvalues = sort(eig(cov(data{1,i}{1,j})),'descend');
        eigenvalues = eigenvalues/eigenvalues(1);
        eig_second(1,index) = eigenvalues(2);
        index = index+1;
    end
end



figure;
hold all;
for i=1:3
    plot(dates, dim(i,:));
end
datetick('x','yyyy');

figure;
hold on;
plot(dates, eig_second);
datetick('x','yyyy');
end

