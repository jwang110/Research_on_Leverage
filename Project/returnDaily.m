%% Function returns Daily Return Value
function r = returnDaily(x)
i=1;
while i<length(x)
    r(i)=(x(i+1)-x(i))/x(i);
    i=i+1;
end
end