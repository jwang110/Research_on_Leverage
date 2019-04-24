function dim = calcDim(data, cutOff)
%UNTITLED20 Summary of this function goes here
%   Detailed explanation goes here
eigenvalues = eigs(cov(data));
eigenvalues = eigenvalues/eigenvalues(1);
dim = 1;
flag =1;
for i=2:length(eigenvalues)
    if(eigenvalues(i)> cutOff && flag) 
        dim = dim+1;
    else
       flag = 0; 
    end
end
end

