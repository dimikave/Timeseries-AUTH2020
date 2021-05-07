n = 1000;
arl = generateARMAts([0 0.5], [], n,1);
maxtau = 10;
yV = addstochastictrend(arl);
ma = movingaveragesmooth2(yV,30);
yV1 = (yV - ma);
plot(yV1)
plot(yV)


alpha = 0.05;
zalpha = norminv(1-alpha/2);
maxtau = 10;
n = size(yV1,1);
acx1M = autocorrelation(yV1,maxtau);

xV = importdata('ase.dat');
figure
plot(xV)