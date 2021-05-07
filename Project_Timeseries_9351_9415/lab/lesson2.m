%%%polynomial fit
data = importdata('f1T200.dat');
plot(data(:,2))
data_ = data(19000:26000,2);
plot(data_)
% trend1 = polynomialfit(data_,5);
% trend1 = movingaveragesmooth(data_,30);
yV1 = data_ - trend1
plot(yV1)
n = 7001;
alpha = 0.05;

zalpha = norminv(1-alpha/2);

maxtau = 100;
acx1M = autocorrelation(yV1, maxtau);
autlim = zalpha/sqrt(n);
figure(6)
clf
hold on
for ii=1:maxtau
    plot(acx1M(ii+1,1)*[1 1],[0 acx1M(ii+1,2)],'b','linewidth',1.5)
end
plot([0 maxtau+1],[0 0],'k','linewidth',1.5)
plot([0 maxtau+1],autlim*[1 1],'--c','linewidth',1.5)
plot([0 maxtau+1],-autlim*[1 1],'--c','linewidth',1.5)
xlabel('\tau')
ylabel('r(\tau)')
title(sprintf('detrended time series by MA(%d) smooth, autocorrelation',maorder))







xV = importdata('ase.dat');
close = xV(:,7);
plot(close);
ylabel('close index')
xlabel('years')
trend1 = movingaveragesmooth2(close,30)
yV = close - trend1;
figure()
plot(close)
hold on
plot(trend1)
figure()
plot(yV)
