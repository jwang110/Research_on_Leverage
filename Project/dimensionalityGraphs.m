function  dimensionalityGraphs(filename, dates, ABOnlyFlag, m_or_q, year)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
load(filename);
numyear=size(data,2);
per=size(data{1,1},2);
s=size(data{1,1}{1,1},2);

if (ABOnlyFlag)
    if (s==16)
        num_asset = 6;
    else
        num_asset = 4;
    end
else
    num_asset = s;
end

dim_avg = zeros(1,numyear*per);
dim_avg_roll = zeros(1,numyear*per);
dim_avg_large = zeros(1,numyear*per);
dim_avg_ratio = zeros(1,numyear*per);
counter = 0;

x=.09;
for k=x:.0001:x+.001
    index =1;
    dim = zeros(1,numyear*per);
    dim_roll = zeros(1,numyear*per);
    dim_ratio = zeros(1,numyear*per);
    eig_second = zeros(1,numyear*per);
    for i=1:numyear
        for j=1:per
            rolling = data{1,i}{1,j}(:,1:num_asset);
            flag3 = (3+j<per+1);
            flag2 = (2+j<per+1);
            flag1 = (1+j<per+1);
            i_1 = i+~flag1;
            i_2 = i+~flag2;
            i_3 = i+~flag3;
            j_1 = (j+1)*flag1+~flag1;
            j_2 = (j+2)*flag2+ ~flag2 + ~flag1;
            j_3 = (j+3)*flag3+ ~flag3 + ~flag2 + ~flag1;
            if((i+1)<numyear+1 && flag1 && flag2 && flag3 )
                temp = [data{1,i_1}{1,j_1}(:,1:num_asset);data{1,i_2}{1,j_2}(:,1:num_asset);data{1,i_3}{1,j_3}(:,1:num_asset)];
                rolling = vertcat(rolling, temp);
            end
%             
%             if (4+j<per)
%                 temp = [data{1,i}{1,j+1};data{1,i}{1,j+2};data{1,i}{1,j+3}]; 
%                 rolling = vertcat(rolling, temp);
%             else
%                 if(i+1<numyear)
%                     if(3+j<per)
%                         temp = [data{1,i}{1,j+1};data{1,i}{1,j+1};data{1,i}{1,j+1};data{1,i+1}{1,1}]; 
%                         rolling = vertcat(rolling, temp);
%                     else if(2+j<per)
%                         temp = [data{1,i}{1,j+1};data{1,i}{1,j+1};data{1,i+1}{1,1};data{1,i+1}{1,2}]; 
%                         rolling = vertcat(rolling, temp);
%                     else if(1+j<per)
%                         temp = [data{1,i}{1,j+1};data{1,i+1}{1,j+1};data{1,i+1}{1,j+1};data{1,i+1}{1,j+1}]; 
%                         rolling = vertcat(rolling, temp); 
%                         end
%                         end
%                     end
%                 end
%             end
            [dim_largest, dim_ratio_method] = calcDim(data{1,i}{1,j}(:,1:num_asset),k);
            [dim_largest_roll, dim_ratio_method_roll] = calcDim(rolling,k);
            dim(1,index) = dim_largest;
            dim_ratio(1,index) = dim_ratio_method;
            dim_roll(1,index) = dim_largest_roll;

            eigenvalues = sort(eig(cov(data{1,i}{1,j})),'descend');
            eigenvalues = eigenvalues/eigenvalues(1);
            eig_second(1,index) = eigenvalues(2);
            index = index+1;
        end
    end  
    counter = counter+1;
    dim_avg(1,:) = dim_avg(1,:) + dim(1,:) + dim_ratio(1,:)+dim_roll(1,:);
    dim_avg_large(1,:) = dim_avg_large(1,:) + dim(1,:);
    dim_avg_ratio(1,:) = dim_avg_ratio(1,:) + dim_ratio(1,:);
    dim_avg_roll(1,:) = dim_avg_roll(1,:) + dim_roll(1,:);
end

dim_avg = dim_avg/(3*counter);
dim_avg_large = dim_avg_large/(counter);
dim_avg_ratio = dim_avg_ratio/(counter);
dim_avg_roll = dim_avg_roll/(counter);
% 
% figure;
% hold on;
% plot(dates, dim_avg)
% datetick('x','yyyy');
% title('both');

figure;
hold on;
plot(dates, dim_avg_large)
datetick('x','yyyy');
title(strcat('avg largest ', ABOnlyFlag*'AB only ', m_or_q, '. ', year));

figure;
hold on;
plot(dates, dim_avg_roll)
datetick('x','yyyy');
title(strcat('avg rolling ', ABOnlyFlag*'AB only ', m_or_q, '. ', year));
% 
% 
% figure;
% hold on;
% plot(dates, dim_avg_ratio)
% datetick('x','yyyy');
% title('ratio');

dim_diff = zeros(1, length(dim_avg_large)-1);
dim_diff_roll = zeros(1, length(dim_avg_roll)-1);
for i=2:length(dim_avg_large)
    dim_diff(i-1) = dim_avg_large(i)-dim_avg_large(i-1);
    dim_diff_roll(i-1) = dim_avg_roll(i)-dim_avg_roll(i-1);
end

figure;
hold on;
plot(dates(1,2:end), dim_diff);
datetick('x','yyyy');
title(strcat('dim change largest ', ABOnlyFlag*'AB only ', m_or_q, ' ', year));

figure;
hold on;
plot(dates(1,2:end), dim_diff);
datetick('x','yyyy');
title(strcat('dim change rolling ', ABOnlyFlag*'AB only ', m_or_q, ' ', year));


% figure;
% hold all;
% for i=1:3
%     plot(dates, dim(i,:));
% end
% datetick('x','yyyy');

% figure;
% hold on;
% plot(dates, eig_second);
% datetick('x','yyyy');
end

