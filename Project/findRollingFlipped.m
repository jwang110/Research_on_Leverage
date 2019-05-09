load('data_quart_2002.mat');

numyear=size(data,2);
per=size(data{1,1},2);
s=size(data{1,1}{1,1},2);
font=20;

rolling_quarters = cell(1,numyear-1);
for i=2:numyear
    curr_year = cell(1,per);
    for j=1:per
        if (j==1)
            i_1 = i-1;
            i_2 = i-1;
            i_3 = i-1;
            j_1 = 2;
            j_2 = 3;
            j_3 = 4;
        end
        
        if (j==2)
            i_1 = i-1;
            i_2 = i-1;
            i_3 = i;
            j_1 = 3;
            j_2 = 4;
            j_3 = 1;
        end
        
        if (j==3)
            i_1 = i-1;
            i_2 = i;
            i_3 = i;
            j_1 = 4;
            j_2 = 1;
            j_3 = 2;
        end
        
        if (j==4)
            i_1 = i;
            i_2 = i;
            i_3 = i;
            j_1 = 1;
            j_2 = 2;
            j_3 = 3;
        end
        
        curr_year{1,j} = [data{1,i_1}{1,j_1}(:,1:s);data{1,i_2}{1,j_2}(:,1:s);data{1,i_3}{1,j_3}(:,1:s);data{1,i}{1,j}(:,1:s)];
    end
    rolling_quarters{1,i-1} = curr_year;
end

