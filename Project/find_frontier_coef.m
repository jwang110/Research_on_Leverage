function Coef = find_frontier_coef(V,M)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
A = find_a_b_c(V,M);
a = A(1);
b = A(2);
c = A(3);
sigma_mv = 1/sqrt(a);
mew_mv = b/a;
v_as = sqrt((c*a-b^2)/a);

Coef = [sigma_mv, mew_mv, v_as];
end

