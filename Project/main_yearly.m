%% Project 2: Economic Uncertainties
tic
clear all;
year = '2002';
filename = strcat('data_year_2002.mat');
startDateString = strcat('1-01-',year);
%filename = 'data_quart_2002.mat';
load(filename);

numyear=size(data,2);
s=size(data{1,1},2);
font=20;

startDate = datenum(startDateString);
endDate = datenum('12-31-2018');
dates = linspace(startDate,endDate,numyear);


%% Calculating Mean and Variance
for i=[1:numyear]
    for j=[1:s]
            m{1,i}(1,j)=mean(data{1,i}(:,j));
            var{1,i}=cov(data{1,i});
    end
end

%% (1) Leverage
dates2 = linspace(startDate,endDate,numyear*4);
load('annual_rate_shifting_quarterly.mat', 'mu_si_an')
mu_si_an = mu_si_an;
% find the rolling quarter data from 2002 to 2018
per =4;
[rolling_quarter]=Rolling_quarters_data(numyear,per);
num_rolling=size(rolling_quarter,2);
ome_quarter=[];
sharp_ratio=[];
ome_sharp=[];
for i=1:num_rolling
[ome,sharp,omega_sharp]=find_ome(rolling_quarter{1,i},mu_si_an(i,1));
ome_quarter=[ome_quarter;ome];
sharp_ratio=[sharp_ratio;sharp];
ome_sharp=[ome_sharp;omega_sharp];
end
figure
plot(dates2,ome_quarter)
title('leverage');
datetick('x', 'yyyy');
% reshape the leverage ratio and the sharpe ratio
ome_quarter_reshape=reshape(ome_quarter,[4,17]);
%% (2) Dimensionality
dim = zeros(1,numyear);

for i = 1:numyear
    dim(1, i) = calcDim(data{1,i}, 1/9);
end
figure;
plot(dates, dim);
datetick('x', 'yyyy');
title('dimensionality 1 year');


%% (3) Proximity

prox = zeros(1, numyear);
for i=1:numyear
        temp = calcProx(var{1,i},m{1,i}',s);
        prox(1, i) = temp(1,1);
end
figure;
plot(dates, prox);
datetick('x', 'yyyy');
title('proximity of vfinx 1 year');


%% (6) Sharp Ratio
% calculated the shrp ratio in the leverage section
figure
hold all;
plot(dates2,sharp_ratio)
datetick('x', 'yyyy');
title('sharpe ratio')
% reshape the sharpe ratio
sharpe_ratio_reshape=reshape(sharp_ratio,[4,17]);
%% 


%% Finding Best Chi


%% Least Squares Fit



% for i=[1:numyear]
%     for j=[1:per]
%         % Omega Leverage
%         wLev
%         %Omega Dimensionality
%         wDim
%         %Omega VFINX proximity
%         wProxim
%         %Omega Sharpe Ratio
%         wSharp=
%         
% 
%     end
% end

toc







