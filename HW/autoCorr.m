function w=autoCorr(r)
u1=mean(r);
u0=sum(r(2:length(r)))/length(r);


v00=(1/length(r)) * sum( (r(2:length(r))-u0).^2 );
v01=(1/length(r)) * sum( (r(1:length(r))-u1).^2 );
v11=(1/length(r)) * sum( (r(1:length(r)-1)-u1).*(r(2:length(r))-u0) );


w=v01/(sqrt(v00)*sqrt(v11));

end