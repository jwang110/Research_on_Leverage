function [sigma, mu, nu] = param(v,m)
%m already transposed
y=linsolve(v, (ones(length(v),1)));
a=ones(length(y),1)'*y;
z=linsolve(v, m);
b=ones(length(z),1)'*z;
c=m*z;

sigma=1/sqrt(a);
mu=b/a;
nu=sqrt(((a*c)-b^2)/a);
end