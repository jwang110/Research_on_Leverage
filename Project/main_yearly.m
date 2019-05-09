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
ome_quarter=[];
sharp_ratio=[];
ome_sharp=[];
for i=1:numyear
    [ome,sharp,omega_sharp]=find_ome(data{1,i},mu_si_an(i,1));
    ome_quarter=[ome_quarter;ome];
    sharp_ratio=[sharp_ratio;sharp];
    ome_sharp=[ome_sharp;omega_sharp];
end
figure;
hold on;
plot(dates,ome_quarter);
title('leverage');
datetick('x', 'yyyy');
% reshape the leverage ratio and the sharpe ratio
% ome_quarter_reshape=reshape(ome_quarter,[4,17]);
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
plot(dates,sharp_ratio)
datetick('x', 'yyyy');
title('sharpe ratio');
% reshape the sharpe ratio
% sharpe_ratio_reshape=reshape(sharp_ratio,[4,17]);
%% Finding Best Chi
riskFree=mu_si_an;
sR=sharp_ratio;
for i=[1:numyear-1]
            dailyR1=data{1,i};
            dailyR2=data{1,i+1};
            rF=[riskFree(i), riskFree(i+1)]; 
            sR_temp=sR(i);
            [chi_temp,money_temp]=chiAlloc(sR_temp, rF, dailyR1,dailyR2);
            chiOpt(i)=chi_temp;
            moneyMaxChi(i)=money_temp;  
end

%% Plotting
% build the matrix with the omega
figure
year=1:16;
plot(year,chiOpt,'b')
hold on
plot(year,sharp_ratio(1:16),'r')
title('comparison sharpe and chi money 2 only 8 max')
% % frac=chiOpt(1:16)/sharp_ratio(1:16)
% % plot(year,frac)
% frac=[];
% for i=1:16
%     frac(i)=chiOpt(i)/sharp_ratio(i);
% end
% plot(year,frac)

%% Least Squares Fitting

%dimensionality
% % dim;
% % %proximity of vfinx to efficient frontier
% % prox;
% % %risk free rate
% % riskFree;
% % %sharp ratio omega
% % ome_sharp;
% % %leverage
% % ome_quarter;

omega_rf_temp = [dim', prox', riskFree, ome_sharp, ome_quarter];
omega_rf = omega_rf_temp(1:end-1, :);

omega_temp_no_dim = [prox', riskFree, ome_sharp, ome_quarter];
omega_no_dim = omega_temp_no_dim(1:end-1, :); 


[rf_coef, rf_error] = omegaCoef(omega_rf, chiOpt);
[no_dim_coef, no_dim_error] = omegaCoef(omega_no_dim, chiOpt);

disp("rf error" + rf_error);
disp("no dim error" + no_dim_error);


figure;
hold on;
plot(year,chiOpt,'b');
plot(year, omega_rf*rf_coef, 'r');
plot(year, omega_no_dim*no_dim_coef, 'g');

% omega = omega_rf;
% coef = rf_coef;
% chiEst = omega*coef;
% 
% f_chi = zeros(s, numyear);
% for i=1:numyear-1
%     m_val = mean(data{1,i})';
%     var = cov(data{1,i});
%     mTilda1=(m_val-riskFree(i)/360*ones(9,1))/(1+riskFree(i)/360);
%     vTilda1=var/(1+riskFree(i)/360)^2;
%     f_chi(:,i)=(1-(chiEst(i)/sharp_ratio(i)))*(vTilda1^-1*mTilda1)/(1+sharp_ratio(i)^2);
%     f_chi_opt(:,i)=(1-(chiOpt(i)/sharp_ratio(i)))*(vTilda1^-1*mTilda1)/(1+sharp_ratio(i)^2);
% end
% 
% chi_data = cell(1, numyear);
% chi_opt_data = cell(1,numyear);
% for i=1:numyear-1
%     curr_year = [];
%     curr_year_opt = [];
%     for j=1:size(data{1,i},1)
%         r_tilda = 1/(1+riskFree(i)/360)*(data{1,i}(j,:)'-riskFree(i)*ones(9,1));
%         curr_year(j,1) = riskFree(i)/360 *(1-ones(9,1)'*f_chi(:,i))+r_tilda'*f_chi(:,i);
%         curr_year_opt(j,1) = riskFree(i)/360 *(1-ones(9,1)'*f_chi_opt(:,i))+r_tilda'*f_chi_opt(:,i);
%     end
%     chi_data{1,i} = curr_year;
%     chi_opt_data{1,i} = curr_year_opt;
%     %size(chi_data)
% end
% 
% money = [];
% money_opt = [];
% for i=1:numyear-1
%     money = vertcat(money, chi_data{1,i});
%     money_opt = vertcat(money_opt, chi_opt_data{1,i});
% end
% load('vfinx_workspace.mat');
% 
% startDate = datenum('1-1-2002');
% endDate = datenum('12-31-2017');
% dates_v = linspace(startDate,endDate,size(money,1));
% 
% 
% figure;
% hold all;
% plot(dates_v, vfinx_daily(1,1:size(money,1)));
% plot(dates_v, money, 'g');
% plot(dates_v, money_opt, 'k');
% datetick('x', 'yyyy');

toc







