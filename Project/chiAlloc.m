function [c, M]=chiAlloc( sR, m, V)
    % Finding squiggly m and v
    mTilda= (1/(1+sR))* (m-sR*ones(length(m),1)');
    vTilda= (1/(1+sR)^2)*V;


    %Partitioning Chi, right now i have it set to go from [-sharp ratio,
    %sharpe ratio] with step size n
    mini=0;
    maxi=sR;
    n=100;
    chi_temp = zeros(n+1,1);
    for i=1:n+1
        chi_temp(i)=mini + ((i-1) * (maxi-mini)/n);
    end
    chi = chi_temp(2:end-1,:)
    % Finding F* : this will give us a matrix with with 9 rows (for each
    % asset)
    f=ones(9,length(chi));
    for i=1:(length(chi))
        f(:,i)=(1-(chi(i)/sR))*(vTilda^-1*mTilda')/(1+sR^2); 
    end
    
    
    %Find best F* : dot F* with returns and which ever returns the most
    %money is the best allocations. Then I find the index related with the
    %best F*
    sum = 0;
    money=zeros((length(chi)),1);
    for i=1:(length(chi))
        money(i)=f(:,i)'*m';
    end
    [M, I]=max(money);
    % I is the index for the max value
    
    
    
    %Return best Chi
    c=chi(I);

end