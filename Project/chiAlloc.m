function [c, M, I, f, money]=chiAlloc( sR, m, V, r, day)
    % Finding squiggly m and v
    rF=r;%/100;
    mTilda= (1/(1+rF/365))* (m-(rF/day)*ones(length(m),1)');
    vTilda= (1/(1+(rF/365)^2))*V;

    
    %Partitioning Chi, right now i have it set to go from [-sharp ratio,
    %sharpe ratio] with step size n
    mini=0;
    maxi=(1-rF)*sR;
    n=100;
    chi_temp = zeros(n+1,1);
    for i=1:n+1
        chi_temp(i)=mini + ((i-1) * (maxi-mini)/n);
    end
    chi = chi_temp(2:end-1,:);
    
    
    % Finding F* : this will give us a matrix with with 9 rows (for each
    % asset)
    f=ones(9,length(chi));
    for i=1:(length(chi))
        if(sR == 0)
            f(:,i) = zeros(9,1);
        else
            f(:,i)=(1-rF-(chi(i)/sR))*(vTilda^-1*mTilda')/(1+sR^2);
        end
    end
    
    
    %Find best F* : dot F* with returns and which ever returns the most
    %money is the best allocations. Then I find the index related with the
    %best F*
    money=zeros((length(chi)),1);
    for i=1:(length(chi))
        money(i)=f(:,i)'*m';
    end
   
    [M I]=max(money);
    % I is the index for the max value
  
    
    %Return best Chi
    c=chi(I);

end