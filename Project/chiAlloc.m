function [mTilda1,mTest1,vTilda1, vTest1 ]=chiAlloc( sR,rF, r1, r2)
    % Squiggly return for year 1 and year 2
    rTilda1=(1/(1+rF(1)))*(r1-(rF(1)*ones(size(r1))));
    rTilda2=(1/(1+rF(2)))*(r2-(rF(2)*ones(size(r2))));
    
    %Squiggle mean/var for year 1 and 2
%     % First Calculate mean and variance
%     m1=ones(9,1); v1=ones(9,9);
%     m2=ones(9,1); v2=ones(9,9);
%     for k=[1,9]
%         m1(k)=mean(r1(:,k));
%         m2(k)=mean(r2(:,k));
%     end
%     v1=cov(r1);
%     v2=cov(r2);
    %Now we find the squiggles
    mTilda1=mean(rTilda1,1);
    mTilda2=mean(rTilda2,1);
    vTilda1=cov(rTilda1);
    vTilda2=cov(rTilda2);
    
%     mTest1=(1/(1+rF(1)))*(m1-((rF(1)/sR(1))*ones(length(m1),1)));
%     vTest1=(1/(1+rF(1))^2)*v1;
%     
%     mTest1=mTest1';
%     
    
    % PART 1: Partitioning Chi
    mini=0;
    maxi=sR; %Note thatsR is a vector with 2 entries, 1 for each year
    n=100;
    chi_temp1 = zeros(n+1,1);
    chi_temp2 = zeros(n+1,1);
    for i=1:n+1
        chi_temp1(i)=mini + ((i-1) * (maxi(1)-mini)/n);
        chi_temp1(i)=mini + ((i-1) * (maxi(2)-mini)/n);
    end
    chi1 = chi_temp1(2:end-1,:);
    chi2 = chi_temp2(2:end-1,:);
    
    
    % PART 2: Compute allocation for our chi's
    f=ones(9,length(chi));
    for i=1:(length(chi))
        if(sR(i) == 0)
            f(:,i) = zeros(9,1);
        else
            f(:,i)=(1-(chi1(i)/sR(1)))*(vTilda1^-1*mTilda1')/(1+sR(1)^2);
        end
    end
    
    
    % PART 3: Maximizing the return
    money1=ones(length(f),1)
    for i=1:length(f)
        money1(i)=sum(log(1+rF(1))+log(1+(rTilda1*f))); 
    end
    % Finding top 10
    for i=1:10
        [M I]=maxk(money1,10);
    end
    
    
    
    
    
    % PART 4: Maximixing returns for next year, with same f(chi)
    money2=ones(length(f),1)
    for i=1:10
        money2(i)=sum(log(1+rF(2))+log(1+(rTilda2*f(I(i)) ))); 
    end
    
    % PART 5: Comparing the moneys
    
    
    
 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
%     
% 
%     % Finding squiggly m and v
%     mTilda= (1/(1+rF/365))* (m-(rF/day)*ones(length(m),1)');
%     vTilda= (1/(1+(rF/365)^2))*V;
% 
%     
%     %Partitioning Chi, right now i have it set to go from [-sharp ratio,
%     %sharpe ratio] with step size n
%     mini=0;
%     maxi=sR;
%     n=100;
%     chi_temp = zeros(n+1,1);
%     for i=1:n+1
%         chi_temp(i)=mini + ((i-1) * (maxi-mini)/n);
%     end
%     chi = chi_temp(2:end-1,:);
%     
%     
%     % Finding F* : this will give us a matrix with with 9 rows (for each
%     % asset)
%     f=ones(9,length(chi));
%     for i=1:(length(chi))
%         if(sR == 0)
%             f(:,i) = zeros(9,1);
%         else
%             f(:,i)=(1-(chi(i)/sR))*(vTilda^-1*mTilda')/(1+sR^2);
%         end
%     end
%     
%     
%     %Find best F* : dot F* with returns and which ever returns the most
%     %money is the best allocations. Then I find the index related with the
%     %best F*
%     money=zeros((length(chi)),1);
%     for i=1:(length(chi))
%         money(i)=f(:,i)'*m';
%     end
%    
%     [M I]=max(money);
%     % I is the index for the max value
%   
%     
%     %Return best Chi
%     c=chi(I);
% 
% end
end