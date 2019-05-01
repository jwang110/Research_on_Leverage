load('data_quart_2002.mat');

numyear=size(data,2);
per=size(data{1,1},2);
s=size(data{1,1}{1,1},2);
font=20;

rolling_quarters = cell(1,numyear);
for i=1:numyear
    curr_year = cell(1,per);
    for j=1:per
        rolling = data{1,i}{1,j}(:,1:s);
        flag3 = (3+j<per+1);
        flag2 = (2+j<per+1);
        flag1 = (1+j<per+1);
        i_1 = i+~flag1;
        i_2 = i+~flag2;
        i_3 = i+~flag3;
        j_1 = (j+1)*flag1+~flag1;
        j_2 = (j+2)*flag2+ ~flag2 + ~flag1;
        j_3 = (j+3)*flag3+ ~flag3 + ~flag2 + ~flag1;
        if((i+1)<numyear+1)
            temp = [data{1,i_1}{1,j_1}(:,1:s);data{1,i_2}{1,j_2}(:,1:s);data{1,i_3}{1,j_3}(:,1:s)];
            rolling = vertcat(rolling, temp);
        end
        curr_year{1,j} = rolling;
    end
    rolling_quarters{1,i} = curr_year;
end