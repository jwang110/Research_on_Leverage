%% find_all(DATA,n,mu_si_an,day_start,day_end)
% This function finds r,rho,m,V,sig_mv,mu_mv,nu_as,mu_si,mu_cl,
% sig_st,nu_st,mu_st,ome_st,sig_ct,nu_ct,mu_ct,ome_ct,f_mv,f_st,f_ct
function [r,rho,m,V,sig_mv,mu_mv,nu_as,mu_si,mu_cl,...
          sig_st,nu_st,mu_st,ome_st,...
          sig_ct,nu_ct,mu_ct,ome_ct,...
          f_mv,f_st,f_ct]...
    =find_all(DATA,n,mu_si_an,day_start,day_end)

% Find return matrix,r(days*n):
r=zeros(day_end-day_start+1,n);
for j=1:n
    for i=day_start:day_end;
        r(i-day_start+1,j)=(DATA(i+1,j)-DATA(i,j))/DATA(i,j);
    end
end
% Find price ratio history matrix, rho(days*n):
for j=1:n
    for i=day_start:day_end;
        rho(i,j)=DATA(i+1,j)/DATA(i,j);
    end
end
% Find mean variance vector, m(n*1):
m=[];
for i=1:n
    m(i,1)=mean(r(:,i));
end
 
% Find covariane matrix, V(n*n):
V=cov(r);

% Find all critical numbers (1*1 syms)
a=ones(1,n)*(V\ones(n,1));
b=ones(1,n)*(V\m);
c=m'*(V\m);
sig_mv=1/sqrt(a);
mu_mv=b/a;
nu_as=sqrt((a*c-b^2)/a);
mu_cl_an=mu_si_an+0.03;
mu_cl=(1+mu_cl_an)^(1/(day_end-day_start+1))-1;
mu_si=(1+mu_si_an)^(1/(day_end-day_start+1))-1;
sig_st=sig_mv*sqrt(1+(nu_as*sig_mv/(mu_mv-mu_si))^2);
nu_st=nu_as*sqrt(1+((mu_mv-mu_si)/(nu_as*sig_mv))^2);
mu_st=mu_mv+nu_as^2*sig_mv^2/(mu_mv-mu_si);
ome_st=nu_as/nu_st;
sig_ct=sig_mv*sqrt(1+(nu_as*sig_mv/(mu_mv-mu_cl))^2);
nu_ct=nu_as*sqrt(1+((mu_mv-mu_cl)/(nu_as*sig_mv))^2);
mu_ct=mu_mv+nu_as^2*sig_mv ^2/(mu_mv-mu_cl);
ome_ct=nu_as/nu_ct;
 
% This function finds the minimum volatility allocation, f_mv(n*1):
f_mv=1/a*(V\eye(n))*ones(n,1);
 
% This function finds the safe tangent allocation, f_st(n*1):
f_st=sig_mv^2/(mu_mv-mu_si)*(V\eye(n))*(m-mu_si*ones(n,1));
 
% This function finds the credit tangent allocation, f_ct(n*1):
f_ct=sig_mv^2/(mu_mv-mu_cl)*(V\eye(n))*(m-mu_cl*ones(n,1));
 
end

