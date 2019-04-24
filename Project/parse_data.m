clear all;
year = '2002';
load(strcat('data_',year,'.mat'));

num_stocks = size(data,2);
new_data= cell(1,num_stocks);

for i=1:num_stocks
    temp = cell2mat(data(i));
    dates = temp(2:end,1:2);
    stock_data = returnDaily(temp(:,3))';
    year_data = horzcat(dates, stock_data);
    new_data{1,i} = year_data;
end

start_year = new_data{1,1}(1,2);
end_year = new_data{1,1}(end,2);
num_years = end_year-start_year;

data_m = cell(1,num_years);
data_q = cell(1,num_years);

for i=1:num_years
    curr_year = start_year+i-1;
    temp_month_data = cell(1,12);
    for j=1:num_stocks
        [temp_months, temp_year] = getDataForYear(new_data{1,j},curr_year);
        for k=1:12
            if (j==1)
                temp_month_data{1,k} = getDataForMonth(temp_months, temp_year, k);
            else
                temp_month_data{1,k} = horzcat( temp_month_data{1,k}, getDataForMonth(temp_months, temp_year, k));
            end
        end
    
    end
    q1 = [temp_month_data{1,1}; temp_month_data{1,2}; temp_month_data{1,3}];
    q2 = [temp_month_data{1,4}; temp_month_data{1,5}; temp_month_data{1,6}];
    q3 = [temp_month_data{1,7}; temp_month_data{1,8}; temp_month_data{1,9}];
    q4 = [temp_month_data{1,10}; temp_month_data{1,11}; temp_month_data{1,12}];
    temp_quart_data = {q1, q2, q3, q4};
    
    data_q{1,i} = temp_quart_data;
    data_m{1,i} = temp_month_data;
    
end

clearvars -except data_q data_m labels