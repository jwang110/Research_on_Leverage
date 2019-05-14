load('vix_yearly_data_with_dates.mat');

index_monthly = 1;
which_month = 1;
numyear = 24;
vix_avg = zeros(numyear*12, 1);
days_in_month = 1;
sum_months = 0;
index_month = 1;
for i=1:size(vix_data,1)-1
    vix_avg(index_monthly,1) = vix_avg(index_monthly,1) + vix_data(i,3);
    vix_data(i+1,1);
    vix_data(i,1);
    if(vix_data(i+1, 1)==which_month)
       days_in_month = days_in_month+1; 
    else
       which_month = vix_data(i+1,1);
       vix_avg(index_monthly,1) = vix_avg(index_monthly,1)/days_in_month;
       sum_months = sum_months + days_in_month;
       days_in_month = 1;
       index_monthly = index_monthly+1;
    end 
end
