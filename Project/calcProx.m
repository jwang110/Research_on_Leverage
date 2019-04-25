function prox = calcProx(V, M, n)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
effFrontCoef = find_frontier_coef(V, M);

prox = zeros(n,1);

for i=1:n
    sigma_mv = effFrontCoef(1);
    mew_mv = effFrontCoef(2);
    v_as = effFrontCoef(3);
    sigma_var = sqrt(V(i,i));
    mew = M(i);
    prox(i) = sqrt(sigma_mv^2+((mew-mew_mv)/v_as)^2)/sigma_var;
end
end
