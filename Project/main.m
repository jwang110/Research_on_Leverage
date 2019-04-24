%% Project 2: Economic Uncertainties
load('data_month_2002.mat');
numyear=size(data,2);
startDate = datenum('1-01-2002');
endDate = datenum('12-31-2018');
dates = linspace(startDate,endDate,numyear*12);

%% Calculating Mean and Variance
numyear=size(data,2);
per=size(data{1,1},2);
s=size(data{1,1}{1,1},2);
font=20;

for i=[1:numyear]
    for j=[1:per]
        for k=[1:s]
            m{1,i}{1,j}(1,k)=mean(data{1,i}{1,j}(:,k));
            var{1,i}{1,j}=cov(data{1,i}{1,j});
        end
    end
end


%% (1) Leverage


%% (2) Dimensionality

dim = zeros(3,numyear*per);
eig_second = zeros(1,numyear*per);
index =1;
for i=1:numyear
    for j=1:per
        dim(1,index) = calcDim(data{1,i}{1,j},.3);
        dim(2,index) = calcDim(data{1,i}{1,j},.4);
        dim(3,index) = calcDim(data{1,i}{1,j},.5);
        eigenvalues = eigs(cov(data{1,i}{1,j}));
        eigenvalues = eigenvalues/eigenvalues(1);
        eig_second(1,index) = eigenvalues(2);
        index = index+1;
    end
end



figure;
hold all;
for i=1:3
    plot(dates, dim(i,:));
end
datetick('x','yyyy');

figure;
hold on;
plot(dates, eig_second);
datetick('x','yyyy');

%% (3) Minimum Volatility
% numyear=16;
% per=4;
% s=9;
% 
% for i=[1:numyear]
%     for j=[1:per]
%         for k=[1:s]
%             mVol{1,i}{1,j}=minVol(var{1,i}{1,j})';
%         end
%     end
% end
% quart=[1,2,3,4];
% asset={'VFINX','VBMFX','VGSLX','VBLTX','VEIEX','VIMSX','Microsoft','Wells Fargo','UPS'};
% 
% 
% %Work in progress...need to make vectors of the quarters per asset
% for k=[1:s]
%     for j=[1:per]
%         figure
%         hold on
%         title(asset(k), 'fontSize',font+4) 
%         plot(quart(j),mVol{1,7}{1,j}(1,s))
%         
%     end 
% end

%% (4) Efficiency Proximity


%% (5) Chi


%% (6) Omega Assymptot

%% (7) Other factors

otherfactors
