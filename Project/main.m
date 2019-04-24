%% Project 2: Economic Uncertainties
clear all;
filename = 'data_quart_2002.mat';
load(filename);
numyear=size(data,2);
per=size(data{1,1},2);
startDate = datenum('1-01-2002');
endDate = datenum('12-31-2018');
dates = linspace(startDate,endDate,numyear*per);

%% Calculating Mean and Variance
[m, var] = meanVariance(filename);


%% (1) Leverage


%% (2) Dimensionality

dimensionalityGraphs(filename, dates);

%% (3) Minimum Volatility
minVolatility(filename, var);

%% (4) Efficiency Proximity


%% (5) Chi


%% (6) Omega Assymptot

%% (7) Other factors

otherfactors
