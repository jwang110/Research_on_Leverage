%% Project 2: Economic Uncertainties
clear all;
filename = 'data_quart_2002.mat';
load(filename);

numyear=size(data,2);
per=size(data{1,1},2);
s=size(data{1,1}{1,1},2);
font=20;

startDate = datenum('1-01-2002');
endDate = datenum('12-31-2018');
dates = linspace(startDate,endDate,numyear*per);


%% Calculating Mean and Variance
for i=[1:numyear]
    for j=[1:per]
        for k=[1:s]
            m{1,i}{1,j}(1,k)=mean(data{1,i}{1,j}(:,k));
            var{1,i}{1,j}=cov(data{1,i}{1,j});
        end
    end
end

%% Calculating Markowitz Parameters
for i=[1:numyear]
    for j=[1:per]
        for k=[1:s]
            [a b c]=param(var{1,i}{1,j}, m{1,i}{1,j});
            mark{1,i}{1,j}(1,1)=a;
            mark{1,i}{1,j}(2,1)=b;
            mark{1,i}{1,j}(3,1)=c;
        end
    end
end

%% (1) Leverage


%% (2) Dimensionality

dimensionalityGraphs(filename, dates);

%% (3) Minimum Volatility
for i=[1:numyear]
    for j=[1:per]
        for k=[1:s]
            mVol{1,i}{1,j}=minVol(var{1,i}{1,j})';
        end
    end
end
quart=[1,2,3,4];


%Work in progress...need to make vectors of the quarters per asset
% for k=[1:s]
%     for j=[1:per]
%         figure
%         hold on
%         title(asset(k), 'fontSize',font+4) 
%         plot(quart(j),mVol{1,7}{1,j}(1,s))
%         
%     end 
% end

%% (4) Efficiency Proximity
%proximity(filename, m, var);

%% (5) Chi


%% (6) Omega Assymptot

%% (7) Other factors

otherfactors
