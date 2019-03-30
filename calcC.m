function C = calcC(stock)
%example on git
% another example ecause im learning
C = zeros(size(stock,2),size(stock,2));
for i=1:size(stock,2)
    for j=1:size(stock,2)
        vij = calcVi(stock(:,i),stock(:,j));
        vii = calcVi(stock(:,i),stock(:,i));
        vjj = calcVi(stock(:,j),stock(:,j));
        C(i,j) = vij/(vii^.5*vjj^.5);
    end
end
end

