load('random_factors_2002.mat');
data = [CLI(:,3), CCI(:,3), BCI(:,3), total_consumer_credit(:,3)];
years = CCI(:,2);

index_yearly = 1;
which_year = 2002;
numyear = 17;
data_avg = zeros(numyear, size(data,2));
days_in_year = 1;
sum_year = 0;
index_month = 1;
for i=1:size(data,1)-1
    data_avg(index_yearly,:) = data_avg(index_yearly,:) + data(i,:);
    if(years(i+1, 1)==which_year)
       days_in_year = days_in_year+1; 
    else
       which_year = years(i+1,1);
       data_avg(index_yearly,1) = data_avg(index_yearly,1)/days_in_year;
       sum_year = sum_year + days_in_year;
       days_in_year = 1;
       index_yearly = index_yearly+1;
    end 
end

us_debt = [us_debt_percent(:,2); 0];
data_avg = [data_avg, inflation(:,2), us_debt];

delta_data = zeros(size(data_avg,1), size(data_avg,2));
for i=2:size(data_avg,1)
    delta_data(i-1,:) = data_avg(i,:)-data_avg(i-1, :);
end

data_avg = [data_avg, delta_data];

factors_label = {'CLI', 'CCI', 'BCI', 'total consumer credit', 'inflation', 'us debt','delta CLI', 'delta CCI', 'delta BCI', 'delta credit', 'delta inflation', 'delta us debt'};