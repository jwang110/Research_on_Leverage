%% Project 2: Economic Uncertainties
tic
clear all;
m_or_q = 'quart';
year = '2002';
filename = strcat('data_', m_or_q, '_', year, '.mat');
startDateString = strcat('1-01-',year);
%filename = 'data_quart_2002.mat';
load(filename);

numyear=size(data,2);
per=size(data{1,1},2);
s=size(data{1,1}{1,1},2);
font=20;

startDate = datenum(startDateString);
endDate = datenum('12-31-2018');
dates = linspace(startDate,endDate,numyear*per);
chi_dates = linspace(startDate, endDate, numyear);





%% (1) Leverage
dates2 = linspace(startDate,endDate,numyear*4);
load('annual_rate_shifting_quarterly.mat', 'mu_si_an')
mu_si_an = mu_si_an;
% find the rolling quarter data from 2002 to 2018
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
%dimensionalityGraphs(dates);

%% (3) Minimum Volatility
% for i=[1:numyear]
%     for j=[1:per]
%         for k=[1:s]
%             mVol{1,i}{1,j}=minVol(var{1,i}{1,j})';
%         end
%     end
% end
% quart=[1,2,3,4];
% 
% 
% 
% mV_matrix=zeros(numyear*per,s);
% for k=[1:s]
%     temp_asset=[];
%     for i=[1: numyear]
%         for j=[1:per]
%             temp_asset=[temp_asset, mVol{1,i}{1,j}(1,k)];
%         end
%     end
%     mV_matrix(:,k)= temp_asset';
% end
% 
% 
% 
% %Work in progress...need to make vectors of the quarters per asset
% 
% mV_diff = zeros(size(mV_matrix,2)-1,s);
% for k=[1:s]
%     for j=[2:numyear*per]
%         mV_diff(j-1,k) = mV_matrix(j-1,k)-mV_matrix(j,k);
%     end 
% end
% 
% figure;
% hold on;
% plot(dates(1,2:end),mV_diff(:,1)); 
% title(strcat('min vol change VFINX ', m_or_q, '. ', year));
% datetick('x','yyyy');
% 
% figure;
% hold on;
% plot(dates(1,1:end),mV_matrix(:,1)); 
% title(strcat('min vol VFINX ', m_or_q, '. ', year));
% datetick('x','yyyy');
% 
% 
% for k=[1:s]
%    figure
%    hold on;
%    title(['Minimum Volatility' labels(s)])
%    plot(dates(1,:), mV_matrix(:,k))
%    datetick('x','yyyy');
%    xlabel('Years')
%    ylabel('Years')
% end

%% (4) Efficiency Proximity

%





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

toc


%% Finding Best Chi
load('rolling_quart.mat');


% Calculating Mean and Variance
for i=[1:numyear]
    for j=[1:per]
        for k=[1:s]
            m{1,i}{1,j}(1,k)=mean(data{1,i}{1,j}(:,k));
            var{1,i}{1,j}=cov(data{1,i}{1,j});
        end
    end
end


% % Calculating Markowitz Parameters
% for i=[1:numyear]
%     for j=[1:per]
%         for k=[1:s]
%             [a b c]=param(var{1,i}{1,j}, m{1,i}{1,j});
%             mark{1,i}{1,j}(1,1)=a;
%             mark{1,i}{1,j}(2,1)=b;
%             mark{1,i}{1,j}(3,1)=c;
%         end
%     end
% end

riskFree=reshape(mu_si_an,[4,17]);

% Finding optimal Chi's
for i=[1:1]
    for j=[1:1]
            sR=sharpe_ratio_reshape(j,i);
            m_temp=m{1,i}{1,j};
            v_temp=var{1,i}{1,j};
            rF=riskFree(j,i);
            day_temp=length(data{1,i}{1,j}(:,k));
            [chi_temp, money_temp, I, f, money]=chiAlloc(sR, m_temp, v_temp,rF, day_temp);
            chiOpt{1,i}{1,j}=chi_temp;
            moneyMaxChi{1,i}{1,j}=money_temp;  
            chi_temp
            money_temp
            I
            f
            money
    end
end

index = 1;
chi_vect = zeros(1, numyear*per);
for i=1:numyear
    for j=1:per
        chi_vect(1, index) = chiOpt{1,i}{1,j};
        index = index+1;
    end
end

figure;
hold all;
plot(dates, chi_vect);
datetick('x', 'yyyy');
title('Chi');



%proximity(dates, m, var, m_or_q, year);









