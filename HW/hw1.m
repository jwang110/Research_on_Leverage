load('hw1_data.mat');


%% Exercise One

corr = cell(1,5);
for i=1:5
    curr_data = cell2mat(data_years(i));
    corr_Group = cell(1,9);
    for j = 1:9
        q1 = calcQuarter(curr_data(:,j),1);
        q2 = calcQuarter(curr_data(:,j),2);
        q3 = calcQuarter(curr_data(:,j),3);
        q4 = calcQuarter(curr_data(:,j),4);
        correlations = [autoCorr(q1), autoCorr(q2), autoCorr(q3), autoCorr(q4)];
        corr_Group{j}= correlations;
    end
    corr{i} = corr_Group;
end

num_years = 5;
corr2 = cell(1,3);
for i=1:3
    corr_asset = cell(1,3);
    for j = 1:3
        correlations = zeros(num_years,4);
        for k=1:num_years
            curr_data = data_group{1,i}{1,k};
            q1 = calcQuarter(curr_data(:,j),1);
            q2 = calcQuarter(curr_data(:,j),2);
            q3 = calcQuarter(curr_data(:,j),3);
            q4 = calcQuarter(curr_data(:,j),4);
            correlations(k,:) = [autoCorr(q1), autoCorr(q2), autoCorr(q3), autoCorr(q4)];
        end
        corr_asset{j}= correlations;
    end
    corr2{i} = corr_asset;
end





%% Exercise Two