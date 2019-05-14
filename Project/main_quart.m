%% Project 2: Economic Uncertainties
tic
clear all;
year = '2003';
filename = strcat('rolling_quart_2003_backwards.mat');
startDateString = strcat('1-01-',year);
%filename = 'data_quart_2002.mat';
load(filename);
load('annual_rate_shifting_quarterly.mat');

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


%% (1) Leverage
ome_quarter=[];
sharp_ratio=[];
ome_sharp=[];
index = 1;
for i=1:numyear
    for j=1:per
        [ome,sharp,omega_sharp]=find_ome_quart(data{1,i}{1,j},mu_si_an(index,1));
        ome_quarter=[ome_quarter;ome];
        sharp_ratio=[sharp_ratio;sharp];
        ome_sharp=[ome_sharp;omega_sharp];
        index = index+1;
    end
end
figure;
hold on;
plot(dates,ome_quarter);
title('leverage');
datetick('x', 'yyyy');
% reshape the leverage ratio and the sharpe ratio
%ome_quarter_reshape=reshape(ome_quarter,[4,17]);
%% (2) Dimensionality
dim = zeros(1,numyear*per);
index = 1;
for i = 1:numyear
    for j=1:per
        dim(1, index) = calcDim(data{1,i}{1,j}, 1/9);
        index = index+1;
    end
end
figure;
plot(dates, dim);
datetick('x', 'yyyy');
title('dimensionality log diff', 'fontSize', font);


%% (3) Proximity

prox = zeros(1, numyear);
index = 1;
for i=1:numyear
    for j=1:per
        temp = calcProx(var{1,i}{1,j},m{1,i}{1,j}',s);
        prox(1, index) = temp(1,1);
        index = index+1;
    end
end
figure;
plot(dates, prox);
datetick('x', 'yyyy');
title('proximity of vfinx to efficient fronter', 'fontSize', font);


%% (6) Sharp Ratio
% calculated the shrp ratio in the leverage section
figure
hold all;
plot(dates,sharp_ratio)
datetick('x', 'yyyy');
title('sharpe ratio');
% reshape the sharpe ratio
%sharpe_ratio_reshape=reshape(sharp_ratio,[4,17]);
%% 


%% Finding Best Chi




riskFree=mu_si_an;
sR=sharp_ratio;
index = 1; 
for i=[1:numyear]
    for j=1:per
            if(i==numyear && j==per)
                break;
            end
            dailyR1=data{1,i}{1,j};
            i_2 = i;
            j_2 = j+1;
            if(j==4)
               i_2 = i_2+1; 
               j_2 = 1;
            end
            dailyR2=data{1,i_2}{1,j_2};
            rF=[riskFree(index), riskFree(index+1)]; 
            sR_temp=sR(index);
            [chi_temp,money_temp]=chiAlloc(sR_temp, rF, dailyR1,dailyR2);
            chiOpt(index)=chi_temp;
            moneyMaxChi(index)=money_temp;  
            index = index+1;
    end
end

figure;
plot(chiOpt);
title('rolling quarter chi');


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







