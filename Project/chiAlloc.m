function [c]=chiAlloc( sR, m, V)
    %Partitioning Chi, right now i have it set to go from [-sharp ratio,
    %sharpe ratio] with step size n
    mini=min(-1*sR, sR);
    maxi=max(-1*sR, sR);
    n=100;
    for i=1:n+1
        chi(i)=mini + ((i-1) * (maxi-mini)/n);
    end
    
    % Finding F* : this will give us a matrix with with 9 rows (for each
    % asset)
    f=ones(9,length(chi)-1);
    for i=1:(length(chi)-1)
        f(:,i)=(1-(chi/sR))*(V^-1*m)/(1+sR^2); 
    end
    
    
    %Find best F* : dot F* with returns and which ever returns the most
    %money is the best allocations. Then I find the index related with the
    %best F*
    money=zeros((length(chi)-1),1)
    for i=1:(length(chi)-1)
        money(i)=f(:,i)'.*m.*f(:,i);
    end
    [M I]=max(money);
    % I is the index for the max value
    
    
    
    %Return best Chi
    c=chi(I);

end