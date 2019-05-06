function dim = calcDim(data)
%UNTITLED20 Summary of this function goes here
%   Detailed explanation goes here
eigenvalues = sort(eig(cov(data)), 'descend');
eigenvalues = eigenvalues/eigenvalues(1);

log_diff = zeros(1,length(eigenvalues-1));
for i=2:length(eigenvalues)
    log_diff(i-1) = log(eigenvalues(i))-log(eigenvalues(i-1));
end

[max_diff, max_index] = max(log_diff);
dim = max_index;
plot(eigenvalues);




% dim = 1;
% flag =1;
% for i=2:length(eigenvalues)
%     if(eigenvalues(i)> cutOff && flag) 
%         dim = dim+1;
%     else
%        flag = 0; 
%     end
% end
% 
% normed_eig = zeros(1, length(eigenvalues));
% eigenvalues = sort(eig(cov(data)), 'descend');
% normed_eig(1) = eigenvalues(1)/eigenvalues(1);
% for i=2:length(eigenvalues)
%     normed_eig(i) = eigenvalues(i)/eigenvalues(i-1);
% end
% dim_norm = 1;
% flag =1;
% for i=2:length(eigenvalues)
%     if(normed_eig(i)> cutOff && flag) 
%         dim_norm = dim_norm+1;
%     else
%        flag = 0; 
%     end
% end

end
