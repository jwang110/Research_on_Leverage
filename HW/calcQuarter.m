function data_one_q = calcQuarter(data, quarter)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
start = round((quarter-1)/4*size(data,1),0)+1;
end_val = round((quarter)/4*size(data,1),0);
data_one_q = zeros(end_val-start,1);
for i=1:size(data_one_q,1)
    data_one_q(i) = data(i+start,1); 
end
end

