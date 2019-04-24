function prox = calcProx(V, M, n)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
effFrontCoef = find_frontier_coef(V, M);
syms mew sigma_mv mew_mv v_as sigma_var 
proximity(sigma_mv, mew_mv, v_as, mew, sigma_var) = sqrt(sigma_mv^2+((mew-mew_mv)/v_as)^2)/sigma_var;
prox = zeros(n,1);
for i=1:n
    sigma_l = sqrt(V(i,i));
    mew_l = M(i);
    prox(i) = proximity(effFrontCoef(1), effFrontCoef(2), effFrontCoef(3), mew_l, sigma_l);
end
end
