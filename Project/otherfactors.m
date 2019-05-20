clear all;
numyear = 17;
plotting = true;

%% rf as monthly
load('annual_rate_shifting_quarterly.mat');

mu_si_an = mu_si_an/360;

mu_si_month = zeros(numyear*12, 1);
counter = 0;
index = 1;
for i=1:numyear*12
    counter = counter+1;
    mu_si_month(i) = mu_si_an(index);
    
    if(counter == 3)
       index = index+1;
       counter = 0;
    end
end

%% from main
%sharp ratio
load('data_month_2002.mat');
numyear=size(data,2);
per=size(data{1,1},2);
s=size(data{1,1}{1,1},2);
ome_quarter=[];
sharp_ratio=[];
ome_sharp=[];
index = 1;
for i=1:numyear
    for j=1:per
        [ome,sharp,omega_sharp]=find_ome_quart(data{1,i}{1,j},mu_si_month(index,1));
        ome_quarter=[ome_quarter;ome];
        sharp_ratio=[sharp_ratio;sharp];
        ome_sharp=[ome_sharp;omega_sharp];
        index = index+1;
    end
end


% Calculating Mean and Variance
for i=[1:numyear]
    for j=[1:per]
        for k=[1:s]
            
            m{1,i}{1,j}(1,k)=mean(data{1,i}{1,j}(:,k));
            var{1,i}{1,j}=cov(data{1,i}{1,j});
        end
    end
end

% Dimensionality
dim = zeros(1,numyear*per);
index = 1;
for i = 1:numyear
    for j=1:per
        dim(1, index) = calcDim(data{1,i}{1,j}, 1/9);
        index = index+1;
    end
end

%proximity
prox = zeros(1, numyear*per);
index = 1;
for i=1:numyear
    for j=1:per
        temp = calcProx(var{1,i}{1,j},m{1,i}{1,j}',s);
        prox(1, index) = temp(1,1);
        index = index+1;
    end
end



%% other factors
year = '2002';
numyear = 17;
randomfilename = strcat('random_factors_', year);
load(randomfilename);
load('vix_avg_month.mat');
vix_avg = vix_avg(7*12+1:end,1);
startDateString = strcat('1-01-',year);
startDate_other = datenum(startDateString);
endDate_other = datenum('12-31-2018');
dates_other = linspace(startDate_other,endDate_other,numyear*12);

vix_monthly = zeros(numyear*12, 1);

%data_vars = [SP500(:,3), BCI(:,3), CCI(:,3), CLI(:,3), length_unemployment(:,3), unemployment(:,3), total_consumer_credit(:,3), mu_si_month(:,1), dim', prox', sharp_ratio, ome_sharp, ome_quarter, vix_avg(:,1)];
%titles = {    'SP 500', 'BCI',     'CCI',   'CLI',     'length_unemployment',   'unemployment',     'total consumer credit',    'rf',  'dimensionality', 'proximity', 'sharp', 'ome sharp', 'leverage', 'vix'};
%titles = {'SP 500', 'BCI',     'CCI',   'CLI',     'length_unemployment',   'unemployment',     'total consumer credit',    'rf',  'dimensionality', 'proximity', 'sharp', 'ome sharp', 'leverage','delta BCI',     'delta CCI',   'delta CLI',     'delta length_unemployment',   'delta unemployment',     'delta total consumer credit',    'delta rf',  'delta dimensionality', 'delta proximity', 'delta sharp', 'delta ome sharp', 'delta leverage', 'vix'};


data_vars = [SP500(:,3), BCI(:,3), CCI(:,3), CLI(:,3), total_consumer_credit(:,3), mu_si_month(:,1), dim', prox', ome_sharp, ome_quarter, vix_avg(:,1)];
titles = {    'SP 500', 'BCI',     'CCI',   'CLI',     'total consumer credit',    'rf',  'dimensionality', 'proximity', 'ome sharp', 'leverage', 'vix'};
titles = {titles{1:end-1}, 'delta BCI',     'delta CCI',   'delta CLI',     'delta total consumer credit',    'delta rf',  'delta dimensionality', 'delta proximity', 'delta ome sharp', 'delta leverage', 'vix'};

num_var = size(data_vars,2);


delta_vars = zeros(size(data_vars,1), num_var-2);
for i=2:size(data_vars,1)
    delta_vars(i,:) = data_vars(i,2:num_var-1) - data_vars(i-1,2:num_var-1);
end

data_vars = [data_vars(:,1:num_var-1), delta_vars, data_vars(:,num_var)];


num_var = size(data_vars,2);

correlation = zeros(num_var);
xcorrelation = zeros(num_var);
xcorrelationlags = zeros(num_var);
corr_combined = zeros(num_var);
for i = 1:num_var
    for j = 1:num_var
        corr = corrcoef(data_vars(:,i), data_vars(:,j));
        if (i==j)
            xcorrelation(i,j) = 1;
            xcorrelationlags(i,j) = 0;
        else
            [r, lags] = xcorr(data_vars(:,i), data_vars(:,j));
            [maxval, index] = max(r);
            xcorrelation(i,j) = maxval;
            xcorrelationlags(i,j) = lags(1, index);
        end
        
        lag = xcorrelationlags(i,j);
        if(lag > 0)
            lag = lag*-1;
            corrtemp = corrcoef(data_vars(-1*lag:end,i), data_vars(1:end+lag+1, j));
            corr_combined(i,j) = corrtemp(1,2);
        else
            if(lag <0)
                lag = lag*-1;
                len = length(data_vars);
                corrtemp = corrcoef(data_vars(1:end-lag+1,i), data_vars(lag:end, j));
                corr_combined(i,j) = corrtemp(1,2);
            else
                corr_combined(i,j) = corr(1,2);
            end
        end
         correlation(i,j) = corr(1,2);
    end
end



if (plotting)
    for i=2:num_var
        figure;
        hold on;
        yyaxis left
        plot(dates_other, data_vars(:,1));
        yyaxis right
        plot(dates_other, data_vars(:,i));
        datetick('x','yyyy');
        title(strcat(titles(1,i), '. ', year));
    end

    for i=1:num_var-1
        figure;
        hold on;
        yyaxis left
        plot(dates_other, data_vars(:,num_var));
        yyaxis right
        plot(dates_other, data_vars(:,i));
        datetick('x','yyyy');
        title(strcat(titles(1,i), '. ', year, ' vix'));
    end

    figure;
    grid on;
    hold on;
    yyaxis left
    plot(dates_other, data_vars(:,1));
    yyaxis right
    plot(dates_other(1,1:end-20), interest(:,3));
    datetick('x','yyyy');
    title(strcat('interest', '. ', year));

end

figure;
heatmap(titles, titles, abs(corr_combined));
title('absolute value of correlation accounting for lag');

figure;
heatmap(titles, titles, abs(correlation));
title('absolute value of correlation no lag');


