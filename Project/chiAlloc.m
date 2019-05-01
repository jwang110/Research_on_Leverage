function [f]=chiAlloc(chi, sR, m, V)
    if chi<sR
        f=(1-(chi/sR))*(V^-1*m)/(1+sR^2);
    
    else
        f=0;
    end

end