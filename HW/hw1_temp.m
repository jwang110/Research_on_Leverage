load('hw1_data.mat');


%% Exercise One

num_years = 5;
for i=1:3
    for j = 1:3
        correlations = [];
        for k=1:num_years
            curr_data = data_group{1,i}{1,k};
            q1 = calcQuarter(curr_data(:,j),1);
            q2 = calcQuarter(curr_data(:,j),2);
            q3 = calcQuarter(curr_data(:,j),3);
            q4 = calcQuarter(curr_data(:,j),4);
            correlations = horzcat(correlations,[autoCorr(q1), autoCorr(q2), autoCorr(q3), autoCorr(q4)]);
        end
        figure;
        plot(correlations);
    end
end
