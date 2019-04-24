%% Project 2: Economic Uncertainties

%% Calculating Mean and Variance
numyear=16;
per=4;
s=9;
font=20;

for i=[1:numyear]
    for j=[1:per]
        for k=[1:s]
            m{1,i}{1,j}(1,k)=mean(data_q{1,i}{1,j}(:,k));
            var{1,i}{1,j}=cov(data_q{1,i}{1,j});
        end
    end
end







%% (1) Leverage


%% (2) Dimensionality


%% (3) Minimum Volatility
numyear=16;
per=4;
s=9;

for i=[1:numyear]
    for j=[1:per]
        for k=[1:s]
            mVol{1,i}{1,j}=minVol(var{1,i}{1,j})';
        end
    end
end
quart=[1,2,3,4];
asset={'VFINX','VBMFX','VGSLX','VBLTX','VEIEX','VIMSX','Microsoft','Wells Fargo','UPS'};


%Work in progress...need to make vectors of the quarters per asset
for k=[1:s]
    for j=[1:per]
        figure
        hold on
        title(asset(k), 'fontSize',font+4) 
        plot(quart(j),mVol{1,7}{1,j}(1,s))
        
    end 
end

%% (4) Efficiency Proximity


%% (5) Chi


%% (6) Omega Assymptot

%% (7) Other factors

otherfactors
