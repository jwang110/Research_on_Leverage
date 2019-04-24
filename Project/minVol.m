function f = minVol(v)
y=linsolve(v, (ones(length(v),1)));
f=(1/(ones(length(y),1)'*y))*y;
end
