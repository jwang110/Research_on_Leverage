%% Project 2: Economic Uncertainties

%% Calculating Mean and Variance
numyear=16;
per=4;
s=9;

for i=[1:numyear]
    for j=[1:per]
        for k=[1:s]
            m{1,i}{1,j}(1,k)=mean(data_q{1,i}{1,j}(:,k));
            var{1,i}{1,j}=cov(data_q{1,i}{1,j});
        end
    end
end




%% (1) Volatility


%% (2) Leverage


%% (3) Dimensionality


%% (4) Minimum Volatility
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


%% (5) Efficiency Proximity


%% (6) Chi


%% (7) Omega Assymptot

%% (8) Other factors

otherfactors
