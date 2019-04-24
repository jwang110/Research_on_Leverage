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
endDate = datenum('11-15-2012');

figure;
hold on;
plot(SP500(:,3));

datetick('x','mmmyyyy');
figure;
hold all;
plot(BCI(:,3));
plot(CCI(:,3));
plot(CLI(:,3));
figure;
hold all;
plot(total_consumer_credit(:,3));
figure;
hold all;
plot(unemployment(:,3));
figure;
hold on;
plot(length_unemployment(:,3));


