load(hw1_data.mat);


%% Exercise One

corr = cell(3);
for i=1:3
    currGroup = data_group(i);
    corr_Group = cell(3)
    for j = 1:3
        q1 = calcQuarter(cell2mat(currGroup(j)),1);
        q2 = calcQuarter(cell2mat(currGroup(j)),1);
        q3 = calcQuarter(cell2mat(currGroup(j)),1);
        q4 = calcQuarter(cell2mat(currGroup(j)),1);
        correlations = [autoCorr(q1), autoCorr(q2), autoCorr(q3), autoCorr(q4)];
        corr_Group(j)= correlations;
    end
    corr(i) = corr_Group;
end




%% Exercise Two