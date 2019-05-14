%% Project 2: Economic Uncertainties
tic
clear all;
year = '2002';
filename = strcat('data_year_2002.mat');
startDateString = strcat('1-01-',year);
%filename = 'data_quart_2002.mat';
load(filename);


plot_chi_sharp = false;
plot_sharp = false;
plot_leverage = false;
plot_dim = false;
plot_prox = false;
plot_chis = true;


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

if(plot_leverage)
    figure;
    hold on;
    plot(dates,ome_quarter);
    title('leverage');
    datetick('x', 'yyyy');
end
% reshape the leverage ratio and the sharpe ratio
% ome_quarter_reshape=reshape(ome_quarter,[4,17]);
%% (2) Dimensionality
dim = zeros(1,numyear);

for i = 1:numyear
    dim(1, i) = calcDim(data{1,i}, 1/9);
end

if(plot_dim)
    figure;
    plot(dates, dim);
    datetick('x', 'yyyy');
    title('dimensionality 1 year');
end

%% (3) Proximity

prox = zeros(1, numyear);
for i=1:numyear
        temp = calcProx(var{1,i},m{1,i}',s);
        prox(1, i) = temp(1,1);
end
if(plot_prox)
    figure;
    plot(dates, prox);
    datetick('x', 'yyyy');
    title('proximity of vfinx 1 year');
end
%% (6) Sharp Ratio
% calculated the shrp ratio in the leverage section
if(plot_sharp)
    figure
    hold all;
    plot(dates,sharp_ratio)
    datetick('x', 'yyyy');
    title('sharpe ratio');
end
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

year=2002:2017;
if(plot_chi_sharp)
    figure 
    plot(year,chiOpt,'b')
    hold on
    plot(year,sharp_ratio(1:16),'r')
    title('Optimal Caution Coeff and Sharp Ratio', 'fontSize', 18)
    legend('Optimal Caution Coeff', 'Sharpe Ratio')
end
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

load('otherfactors_yearly_delta.mat');

omega_rf_temp = [dim', prox', riskFree, ome_sharp, ome_quarter];
omega_rf = omega_rf_temp(1:end-1, :);

omega_other = data_avg(1:end-1,:);

[rf_coef, rf_error] = omegaCoef(omega_rf, chiOpt);
[other_coef, other_error] = omegaCoef(omega_other, chiOpt);

allOmega_ideas_temp = [dim', prox', riskFree, ome_sharp, ome_quarter, data_avg(1:end,:)];
allOmega_ideas = allOmega_ideas_temp(1:end-1, :);
omega_labels = {'dim', 'prox', 'rf', 'sharp', 'leverage', factors_label{:}};


%correlation = zeros(1, size(allOmega_ideas,2));
for i=1:size(allOmega_ideas,2)
    [coef, error] = omegaCoef(allOmega_ideas(:,i), chiOpt);
    corr = corrcoef(allOmega_ideas(:,i), chiOpt);
    %correlation(i) = corr(1,2);
    %disp("corr " + omega_labels(i) + corr(1,2));
end

corr_size = size(allOmega_ideas,2)+1;
correlation = zeros(corr_size);
corrComp = [chiOpt', allOmega_ideas];
for i=1:corr_size
    for j=1:corr_size
        corr = corrcoef(corrComp(:,i), corrComp(:,j));
        correlation(i,j) = corr(1,2);
    end
end
heatmap_labels = {'chiOpt', omega_labels{:}};
figure;
heatmap(heatmap_labels, heatmap_labels, abs(correlation));

%best = CCI, dim, rf, leverage

best = [7, 1, 3, 5];
omega_best = [];
best = sort(best);
bestLabels = {};
for i=1:length(best)
    omega_best = [omega_best, allOmega_ideas(:,best(i))];
    bestLabels = {bestLabels{:}, omega_labels{best(i)}};
    %disp(omega_labels{best(i)});
end
%omega_best = [allOmega_ideas(:,5), allOmega_ideas(:,6), allOmega_ideas(:,7), allOmega_ideas(:,8), allOmega_ideas(:,10)];
[best_coef, best_error] = omegaCoef(omega_best, chiOpt);
disp("error combined " + best_error);
disp("rf error " + rf_error);
disp("other error " + other_error);

% % % figure;
% % % hold all;
% % % 
% % % omega_best_minus = omega_best(:,2:end);
% % % [coef, error] = omegaCoef(omega_best_minus, chiOpt);
% % % plot(year, omega_best_minus*coef);
% % % disp(strcat(bestLabels{1}, num2str(error)));
% % %    
% % % for i =2:length(best)-1
% % %     omega_best_minus = [omega_best(:,1:i-2), omega_best(:,i+1:end)];
% % %     [coef, error] = omegaCoef(omega_best_minus, chiOpt);
% % %     plot(year, omega_best_minus*coef);
% % %     disp(strcat(bestLabels{i}, " ", num2str(error)));
% % % end
% % % omega_best_minus = omega_best(:,1:end-1);
% % % [coef, error] = omegaCoef(omega_best_minus, chiOpt);
% % % plot(year, omega_best_minus*coef);
% % % disp(strcat(bestLabels{i+1}, " ", num2str(error)));
% % % 


if(plot_chis)
    figure;
    hold on;
    plot(year,chiOpt,'b');
    plot(year, omega_rf*rf_coef, 'r');
    plot(year, omega_other*other_coef, 'g');
    plot(year, omega_best*best_coef, 'k');
    title('chi opt and various omega chis');
    legend('opt', 'orginal', 'from other factors', 'combo');
end

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







