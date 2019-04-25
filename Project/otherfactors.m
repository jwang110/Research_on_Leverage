load('random_factors_95');

startDate_other = datenum('1-01-1995');
endDate_other = datenum('12-31-2018');
dates_other = linspace(startDate_other,endDate_other,24*12);

data_vars = [SP500(:,3), BCI(:,3), CCI(:,3), CLI(:,3), length_unemployment(:,3), unemployment(:,3), total_consumer_credit(:,3)];
num_var = size(data_vars,2);
correlation = zeros(num_var);
xcorrelation = zeros(num_var);
xcorrelationlags = zeros(num_var);
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
         correlation(i,j) = corr(1,2);
    end
end

xcorrelation = correlation;
corr_temp = corrcoef(data_vars(1:end-21,1), data_vars(22:end, 6));
xcorrelation(1,6) = corr_temp(1,2);
xcorrelation(6,1) = corr_temp(2,1);

corr_temp = corrcoef(data_vars(16:end,6), data_vars(1:end-15, 7));
xcorrelation(6,7) = corr_temp(1,2);
xcorrelation(7,6) = corr_temp(2,1);

corr_temp = corrcoef(data_vars(1:end-5,6), data_vars(6:end, 5));
xcorrelation(6,5) = corr_temp(1,2);
xcorrelation(5,6) = corr_temp(2,1);
    


titles = {'SP 500', 'BCI', 'CCI', 'CLI', 'length_unemployment', 'unemployment', 'total consumer credit'};

for i=2:num_var
    figure;
    hold on;
    yyaxis left
    plot(dates_other, data_vars(:,1));
    yyaxis right
    plot(dates_other, data_vars(:,i));
    datetick('x','yyyy');
    title(titles(1,i));
end

figure;
grid on;
hold on;
yyaxis left
plot(dates_other, data_vars(:,1));
yyaxis right
plot(dates_other(1,1:end-20), interest(:,3));
datetick('x','yyyy');
title('interest');
