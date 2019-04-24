function  minVolatility(filename, var)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
load(filename);

numyear=size(data,2);
per=size(data{1,1},2);
s=size(data{1,1}{1,1},2);
font=20;

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
% for k=[1:s]
%     for j=[1:per]
%         figure
%         hold on
%         title(asset(k), 'fontSize',font+4) 
%         plot(quart(j),mVol{1,7}{1,j}(1,s))
%         
%     end 
% end

end

