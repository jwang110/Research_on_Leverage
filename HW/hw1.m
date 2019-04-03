clear;
load('hw1_data.mat');
font = 20;

%% Exercise One
num_years = 5;
years = [2014, 2014.25, 2014.5, 2014.75, 2015, 2015.25, 2015.5, 2015.75, 2016, 2016.25, 2016.5, 2016.75,2017, 2017.25, 2017.5, 2017.75,2018, 2018.25, 2018.5, 2018.75];
assets={'VFINX','VBMFX','VGSLX','VBLTX','VEIEX','VIMSX','Microsoft','Wells Fargo','UPS'};
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
        plot(years, correlations);
        title(assets(i),'FontSize',font + 4);
            xlabel('Year','FontSize',font)
            ylabel('\omega_{ID}', 'Interpret','tex','FontSize',font)
    end
end

%% Exercise Two

% quarters{1,years}{1,asset}{1,quartered returns}

for i=[1:5]
    for j=[1:9]
        temp = [];
        for int=1:4
            quart = calcQuarter(data_years{1,i}(:,j),int);
            if size(quart,1)>61
                quart = quart(1:61,1);
            end
            if int == 1
                temp = quart;
            else
                temp = horzcat(temp,quart);
            end
        end
        quarter{1,i}{1,j} = temp;
    end
end



for j=[1:9]
    for i=[1:5]
        %Q is ~62x4 matrix with columns being the different rows
        for k=[1:4]
            Q=quarter{1,i}{1,j};
        end
        
       
        l=[];
        for a=[1:4]
            for b=[a+1:4]
                [h, h, val]=kstest2(Q(:,a),Q(:,b));
                l=[l val];
            end
            iDist{1,j}(1,i)=max(l);
        end

    end
end

assets={'VFINX','VBMFX','VGSLX','VBLTX','VEIEX','VIMSX','Microsoft','Wells Fargo','UPS'};
years_string={'2014','2015','2016','2017','2018'};
years=[2014,2015,2016,2017,2018];
%Graphing
for i=[1:9]
    figure
    hold on
    title(assets(i),'FontSize',font+4)
    xlabel('Year','FontSize',font)
    ylabel('\omega_{ID}', 'Interpret','tex','FontSize',font)
    
    plot(years',iDist{1,i},':.b', 'MarkerSize', 25)
end


