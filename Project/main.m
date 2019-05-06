%% Project 2: Economic Uncertainties
tic
clear all;
m_or_q = 'month';
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
load('annual_rate_quart.mat', 'mu_si_an')
% find the rolling quarter data from 2002 to 2018
[rolling_quarter]=Rolling_quarters_data(numyear,per);
num_rolling=size(rolling_quarter,2);
ome_quarter=[];
sharp_ratio=[];
for i=1:num_rolling
[ome,nu_st]=find_ome(rolling_quarter{1,i},mu_si_an(i,1));
ome_quarter=[ome_quarter;ome];
sharp_ratio=[sharp_ratio,nu_st]
end
year=1:65;
figure
plot(year,ome_quarter)

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

proximity(dates, m, var, m_or_q, year);





%% (6) Sharp Ratio
% calculated the shrp ratio in the leverage section
sharp_ratio;
figure
plot(year,sharp_ratio)
%% 

toc


%% Finding Best Chi

for i=[1:numyear]
    for j=[1:per]
        for k=[1:s]
            %Calculating Squiggly returns
            r=(data{1,i}{1,j}(:,k));
            u=(i,j);
            rTilda=(1/(1+u))*(r-(u*ones(length(r),1)));
            rT{1,i}{1,j}(:,k)=rTilda;
            
            %Calculating squiggly mean and variance
             mT{1,i}{1,j}(1,k)=mean(rT{1,i}{1,j}(:,k));
             varT{1,i}{1,j}=cov(rT{1,i}{1,j});
        end
    end
end

for i=[1:numyear]
    for j=[1:per]
        for k=[1:s]
            chi=[];
            sharpe_temp=u(i,j);
            mean_temp=mT{1,i}{1,j}(1,k);
            var_temp=varT{1,i}{1,j};
            f=chiAlloc(chi,sharpe_temp , mean_temp, var_temp)
            
            
        end
    end
end
