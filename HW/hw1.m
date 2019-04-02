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

% quarters{1,years}{1,asset}{1,quartered returns}

for i=[1:5]
    for j=[1:9]
        for int=[1:4]
            quarter{1,i}{1,j}{1,int}=calcQuarter(data_years{1,i}(:,j),int);
             if int==3
                if i>3
                    quarter{1,i}{1,j}{1,int}(62)= quarter{1,i}{1,j}{1,int}(61);
                end
             end
            
            end
        end
    end



for i=[1:5]
    for j=[1:9]
        %Q is ~62x4 matrix with columns being the different rows
        Q=[];
        for k=[1:4]
            Q=[Q quarter{1,i}{1,j}{1,k}];
        end
        
       
        l=[];
        for a=[1:4]
            for b=[a+1:4]
                val=kstest2(Q(:,a),Q(:,b));
                l=[l val];
            end
        end
        
       iDist{1,i}{1,j}=max(l);
      
    end
  
end