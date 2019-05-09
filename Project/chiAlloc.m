function [chi,M]=chiAlloc( sR,rF, r1, r2)
    % Squiggly return for year 1 and year 2
    rTilda1=(1/(1+rF(1)/360))*(r1-(rF(1)/360*ones(size(r1))));
    rTilda2=(1/(1+rF(2)/360))*(r2-(rF(2)/360*ones(size(r2))));    
    m=mean(r1)';
    V=cov(r1);
    %Squiggle mean/var for year 1 and 2
    %Now we find the squiggles
    mTilda1=(m-rF(1)/360*ones(9,1))/(1+rF(1)/360);
    vTilda1=V/(1+rF(1)/360)^2;
     
    % PART 1: Partitioning Chi
    mini=0;
    maxi=sR; %Note thatsR is a vector with 2 entries, 1 for each year
    n=100;
    chi_temp1 = linspace(mini, maxi, n);
    chi1 = chi_temp1(1,2:end);
    
    
    % PART 2: Compute allocation for our chi's
    f=ones(9,length(chi1));
    for i=1:(length(chi1))
        if(sR == 0)
            f(:,i) = zeros(9,1);
        else
            f(:,i)=(1-(chi1(i)/sR))*(vTilda1^-1*mTilda1)/(1+sR^2);
        end
    end
    
    
    % PART 3: Maximizing the return
    money1=ones(length(chi1),1);
    for i=1:length(chi1)
        
       money_temp=[];
       for j=1:length(rTilda1)
         temp=log(1+rF(1)/360)+log(1+(rTilda1(j,:)*f(:,i)));
         money_temp=[money_temp; temp];
       end
       
    money1(i)=sum(money_temp);
    end
    
    % Finding top 10
    [M I]=sort(money1,'descend');
    M=M(1:8);
    I=I(1:8);
    
    
    
    
    
    
    % PART 4: Maximixing returns for next year, with same f(chi)
    money2=ones(length(chi1),1);
    for i=1:length(chi1)
       money_temp=[];
       for j=1:length(rTilda2)
         temp=log(1+rF(2)/360)+log(1+(rTilda2(j,:)*f(:,i)));
         money_temp=[money_temp; temp];
       end
       
    money2(i)=sum(money_temp);
    end
    
    
    % PART 5: Comparing the moneys
    
    for i=1:length(I)
       avg(i)=(money2(I(i)));
    end
    [A L]=max(avg);
    %I(L) is the index of chi
    chi=chi1(I(L));
    M=money1(I(L));
end