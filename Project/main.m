%% Project 2: Economic Uncertainties
%% Calculating Mean and Variance
numyear=16;
per=4;
s=9;

for i=[1:numyear]
    for j=[1:per]
        for k=[1:s]
            m_v{1,i}{1,j}(1,k)=mean(data_q{1,i}{1,j}(:,k));
            m_v{1,i}{1,j}(2,k)=cov(data_q{1,i}{1,j}(:,k));
        end
    end
end

%% (1) Volatility


%% (2) Leverage


%% (3) Dimensionality


%% (4) Minimum Volatility


%% (5) Efficiency Proximity


%% (6) Chi


%% (7) Omega Assymptot