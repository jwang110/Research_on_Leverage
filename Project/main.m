%% Project 2: Economic Uncertainties
load('random_factors_02');
%
%% (1) Volatility


%% (2) Leverage


%% (3) Dimensionality


%% (4) Minimum Volatility


%% (5) Efficiency Proximity


%% (6) Chi


%% (7) Omega Assymptot

%% (8) Other
startDate = datenum('1-01-2002');
endDate = datenum('12-31-2018');
dates = linspace(startDate,endDate,17*12);

figure;
hold on;
plot(dates, SP500(:,3));
datetick('x','yyyy');

figure;
hold all;
plot(dates,BCI(:,3));
plot(dates,CCI(:,3));
plot(dates,CLI(:,3));
datetick('x','yyyy');

figure;
hold all;
plot(dates,total_consumer_credit(:,3));
datetick('x','yyyy');

figure;
hold all;
plot(dates,unemployment(:,3));
datetick('x','yyyy');

figure;
hold on;
plot(dates,length_unemployment(:,3));
datetick('x','yyyy');


