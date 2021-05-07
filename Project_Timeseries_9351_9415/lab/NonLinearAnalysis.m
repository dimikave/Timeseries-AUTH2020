%% NonLinear Timeseries Analysis - Chaotic Systems
% Henon and Logistic Maps, and Lorenz flow
%%% BE CAREFUL, xV is changing through the code for different examples, it
%%% serves as the main vector to describe our main TS at each part of the
%%% code

% Clearing
clear all;
close all;
clc;

%% Henon Map
% x(t) = 1 - 1.4 * x(t-1)^2 + 0.3 * x(t-2)
xV = load('henon.dat');
xV = xV(1000:3000);
plot(xV)
figure()
scatter(xV(1:end-1),xV(2:end))
figure()
scatter3(xV(1:end-2),xV(2:end-1),xV(3:end))

%%% show chaos in henon / Ftiaxnei xronoseira 100 parathrhsewn gia to Henon
n = 100; 
ntrans = 10;
xV = NaN*ones(n+ntrans,1);
x0V = randn(2,1);
xV(1:2) = x0V;
for j = 3:n+ntrans
    xV(j) = 1 - 1.4 * xV(j-1)^2 + 0.3 * xV(j-2);
end
xV = xV(ntrans+1:n+ntrans);
figure()
plot(xV)

% second henon
x1V = NaN*ones(n+ntrans,1);
x1V(1:2) = x0V + 0.0000001;
for j = 3:n+ntrans
    x1V(j) = 1 - 1.4 * x1V(j-1)^2 + 0.3 * x1V(j-2);
end
x1V = x1V(ntrans+1:n+ntrans);
figure()
plot(x1V)

% We can see by the plot that with a little different initial conditions,
% we take different plots after some time -> Identifier of Chaos

%% Logistic Map
%%% x(t) = a*x(t-1)*(1-x(t-1))
xV  = load('logistic.dat');
xV = xV(1000:1100);
figure()
plot(xV)
figure()
scatter(xV(1:end-1),xV(2:end))

%% Lorenz Flow
xV = load('xlorenz.dat');
xV = xV(1000:3000);
plot(xV)
figure()
scatter(xV(1:end-1),xV(2:end))
figure()
scatter3(xV(1:end-2),xV(2:end-1),xV(3:end))
% Example of lorenz plot/creation using lorenz1()
% [X Y Z] = lorenz1(29,10,3)
% plot3(X,Y,Z)

%% Approach for nonlinear systems
% First we plot our TS
xV = load('henon.dat');
xV = xV(1000:3000);
plot(xV)
% Linear analysis - First we test linear models. If something doesn't fit
% we move on to nonlinear models.
xV = xV - mean(xV);
maxtau = 20;    % Gia poso pisw koitaw
Tmax = 10;      % Gia provlepsh
alpha = 0.05;
n = size(xV,1);

figure()
subplot(2,1,1)
autocorr(xV,'NumLags',maxtau)
title("ACF - xV");
subplot(2,1,2)
parcorr(xV,'NumLags',maxtau)
title("PACF - xV");

%%% First, we are going to check tau according to the autocorrelation
%%% function. In this case, tau = 3 seems like the first good estimation,
%%% thus we check tau = 3 in the code below.
%% FNN
tau = 3;
mmax = 10;
escape = 10;
theiler = 0;
fnnM = falsenearest(xV,tau,mmax,escape,theiler,'henon');
%%% for example here, for tau = 3, we see that the first m that is in
%%% the bounds of 1%, is for m = 8
%%% get embedded data
m = 8;
xM_embedded= embeddelays(xV,m,tau);
%%% plot attractor
plotd2d3(xM_embedded,'');


%% Now let's test one real TS
clear all;
close all;
clc;

yV = load('RR.dat');
figure()
plot(yV)
title('yV')
% Centralizing
xV = yV - mean(yV);
figure()
plot(xV)
title('xV - Centralized yV')

% Detrending
xV = diff(xV,1);
% ma5 = movingaveragesmooth2(xV,5);
% xV = xV - ma5;
figure()
plot(xV)

maxtau = 50;
figure()
subplot(2,1,1)
autocorr(xV,'NumLags',maxtau)
title("ACF - xV");
subplot(2,1,2)
parcorr(xV,'NumLags',maxtau)
title("PACF - xV");

%%% if we decie to move on with FNN
%%% Choose lag
%%% M = estimator
tmax = 20;
mutM = mutualinformation(xV,tmax);
%%% we choose tau = 1 because of the diagram


%%% Choose embedding dimension
%%% FNN
tau = 1;
mmax = 10;
escape = 10;
theiler = 0;
fnnM = falsenearest(xV,tau,mmax,escape,theiler,'FNN is ');

%%% from the diagram we choose m = 3
m = 3
%%% get embedded data - Our new TS is:
xV_emb = embeddelays(xV,m,tau);
%%% plot attractor
plotd2d3(xV_emb,'')