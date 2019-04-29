function ABC = find_a_b_c(V, M)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
y = mldivide(V,ones(length(V),1));
a = ones(1,length(V))*y;
b = ones(1,length(V))*mldivide(V, M);
c = (M.')*mldivide(V,M);
ABC = [a, b, c];
end
