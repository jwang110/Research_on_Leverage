function [omega_coef, error] = untitled11(omega, chiOpt)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
n = size(omega, 2);
omega_coef = ((omega'*omega)\eye(n))*omega'*chiOpt';
chiEst = omega*omega_coef;
error = norm(chiOpt'-chiEst);
end

