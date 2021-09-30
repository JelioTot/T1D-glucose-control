function normalized = foodtest(Cin)

Cin=184;
t=0;
Cbio = 0.8;
tmax = 50;
rateG = [];
y=1;
ys = [];

for t = 1:tmax
    rate = (Cin*Cbio*t*exp(-t/tmax))/tmax^2;
    rateG = [rateG, rate];
end
S=sum(rateG);
normalized=rateG/S;

figure(6);
%plot(normalized);
