%% Time Series Project Winter Semester 2020/2021
% Group 34
% Folas-Demiris Dimitrios(AEM 9415), Kavelidis Frantzis Dimitrios(AEM 9351)
%
% Time series of interest:
% A : id = 34
% B : id = 44


%% Clearing
clear all;
close all;
clc;

%% Import data from excel file
AllData = xlsread('VideoViews.xlsx');

A = AllData(:,34);
figure()
plot(A)
title("Time Series A_t")
ylabel("A(t)");
xlabel("t");

B = AllData(:,44);
figure()
plot(B)
title("Time Series B_t")
ylabel("B(t)");
xlabel("t");

%% Autocorrelation of the time series 
LagsA = 20;
LagsB = 20;
alpha = 0.05;

figure()
subplot(2,1,1)
autocorr(A,'NumLags',LagsA)
title("ACF - A");
subplot(2,1,2)
parcorr(A,'NumLags',LagsA)
title("PACF - A");

figure()
subplot(2,1,1)
autocorr(B,'NumLags',LagsB)
title("ACF - B")
subplot(2,1,2)
parcorr(B,'NumLags',LagsB)
title("PACF - B")
%% Detrend
% In order to check if there is correlation on the time series of interest
% but not due to the (stochastic) trend, I have to make 2 new time series,
% X1,X2 that derive from A,B respectively and don't have stochastic trend


% Remove trend from A 
% using first differences
X1 = diff(A,1);
figure()
plot(X1)
title("Time Series X_1")
ylabel("X_1(t)");
xlabel("t");

% Remove trend from B
% Using first differences
X2 = diff(B,1);
figure()
plot(X2)
title("Time Series X_2")
ylabel("X_2(t)");
xlabel("t");

%% Autocorrelation of the detrended time series 
figure()
subplot(2,1,1)
autocorr(X1,'NumLags',LagsA)
title("ACF - X1");
subplot(2,1,2)
parcorr(X1,'NumLags',LagsA)
title("PACF - X1");

figure()
subplot(2,1,1)
autocorr(X2,'NumLags',LagsB)
title("ACF - X2")
subplot(2,1,2)
parcorr(X2,'NumLags',LagsB)
title("PACF - X2")

ACF_X1 = autocorr(X1,'NumLags',LagsA);
PACF_X1 = parcorr(X1,'NumLags',LagsA);

ACF_X2 = autocorr(X2,'NumLags',LagsB);
PACF_X2 = parcorr(X2,'NumLags',LagsB);

%% Generate Models to check

% Here we are going to use the Econometric Modeler App to find which model
% fits our Time Series better.
econometricModeler
% first we find the p,q,d from the model that fits better, then we pass
% them as arguments to the following code to create an NRMSE plot

% fit at X1 (d = 1)
Tmax = LagsA;
p = input('Give the order p of the AR part >'); 
q = input('Give the order q of the MA part >'); 
[nrmseV,phiallV,thetaallV,SDz,aicS,fpeS,mdl]=fitARMA(X1,p,q,Tmax);
fprintf('===== AR?MA model ===== \n');
fprintf('Estimated coefficients of phi(B):\n');
disp(phiallV')
fprintf('Estimated coefficients of theta(B):\n');
disp(thetaallV')
fprintf('SD of noise: %f \n',SDz);
fprintf('AIC: %f \n',aicS);
fprintf('FPE: %f \n',fpeS);
fprintf('\t T \t\t NRMSE \n');
disp([[1:Tmax]' nrmseV])
if Tmax>3
    figure()
    clf
    plot([1:Tmax]',nrmseV,'.-k')
    hold on
    plot([1 Tmax],[1 1],'y')
    xlabel('T')
    ylabel('NRMSE')
    title(sprintf('AR?MA(%d,1,%d), fitting error',p,q))
end

% Y1 = diff(X1,1)
% % fit at Y1 (d = 2)
% Tmax = LagsA;
% p = input('Give the order p of the AR part >'); 
% q = input('Give the order q of the MA part >'); 
% [nrmseV,phiallV,thetaallV,SDz,aicS,fpeS]=fitARMA(Y1,p,q,Tmax);
% fprintf('===== ARIMA model ===== \n');
% fprintf('Estimated coefficients of phi(B):\n');
% disp(phiallV')
% fprintf('Estimated coefficients of theta(B):\n');
% disp(thetaallV')
% fprintf('SD of noise: %f \n',SDz);
% fprintf('AIC: %f \n',aicS);
% fprintf('FPE: %f \n',fpeS);
% fprintf('\t T \t\t NRMSE \n');
% disp([[1:Tmax]' nrmseV])
% if Tmax>3
%     figure()
%     clf
%     plot([1:Tmax]',nrmseV,'.-k')
%     hold on
%     plot([1 Tmax],[1 1],'y')
%     xlabel('T')
%     ylabel('NRMSE')
%     title(sprintf('AR?MA(%d,2,%d), fitting error',p,q))
% end

% fit at X2 (d = 1)
Tmax = LagsA;
p = input('Give the order p of the AR part >'); 
q = input('Give the order q of the MA part >'); 
[nrmseV,phiallV,thetaallV,SDz,aicS,fpeS]=fitARMA(X2,p,q,Tmax);
fprintf('===== AR?MA model ===== \n');
fprintf('Estimated coefficients of phi(B):\n');
disp(phiallV')
fprintf('Estimated coefficients of theta(B):\n');
disp(thetaallV')
fprintf('SD of noise: %f \n',SDz);
fprintf('AIC: %f \n',aicS);
fprintf('FPE: %f \n',fpeS);
fprintf('\t T \t\t NRMSE \n');
disp([[1:Tmax]' nrmseV])
if Tmax>3
    figure()
    clf
    plot([1:Tmax]',nrmseV,'.-k')
    hold on
    plot([1 Tmax],[1 1],'y')
    xlabel('T')
    ylabel('NRMSE')
    title(sprintf('AR?MA(%d,1,%d), fitting error',p,q))
end

% Y2 = diff(X2,1)
% % fit at Y2 (d = 2)
% Tmax = LagsB;
% p = input('Give the order p of the AR part >'); 
% q = input('Give the order q of the MA part >'); 
% [nrmseV,phiallV,thetaallV,SDz,aicS,fpeS]=fitARMA(Y2,p,q,Tmax);
% fprintf('===== ARIMA model ===== \n');
% fprintf('Estimated coefficients of phi(B):\n');
% disp(phiallV')
% fprintf('Estimated coefficients of theta(B):\n');
% disp(thetaallV')
% fprintf('SD of noise: %f \n',SDz);
% fprintf('AIC: %f \n',aicS);
% fprintf('FPE: %f \n',fpeS);
% fprintf('\t T \t\t NRMSE \n');
% disp([[1:Tmax]' nrmseV])
% if Tmax>3
%     figure()
%     clf
%     plot([1:Tmax]',nrmseV,'.-k')
%     hold on
%     plot([1 Tmax],[1 1],'y')
%     xlabel('T')
%     ylabel('NRMSE')
%     title(sprintf('AR?MA(%d,2,%d), fitting error',p,q))
% end

%% PRED
% At this point, we have chosen the ARIMA models ARIMA(5,1,6) and
% ARIMA(6,1,14) for A and B respectively. Now we are going to use them as
% models



%% 4. 
p = 5;
q = 6;
T = 3;
n1 = 400;
Change = [];
counter = 0;
[preV] = predictARMAmultistep(X1,n1,p,q,T,'');

n = n1;
while(n<=length(X1)-T)
    a = 5*std(preV);
    Sn = 0;
    for i = 1:T
        err = abs(X1(n+i)-preV(i));
        Sn = Sn + err;
    end
    Sn = Sn/T;
    if(Sn>a)
        Change = [Change; n+T]
        n = n+T;
        counter = counter+T;
    else
        n = n+1;
        counter = counter+1;
    end
    [preV] = predictARMAmultistep(X1(1+counter:length(X1)),n1,p,q,T,'');
end

figure()
plot(A)
hold on
for i = 1:length(Change)
    plot(Change(i),A(Change(i)),'o')
end
title('Points of change in timeseries A')

figure()
plot(X1)
hold on
for i = 1:length(Change)
    plot(Change(i),X1(Change(i)),'o')
end
title('Points of change in timeseries X_1')

%% 5.
p = 6;
q = 14;
T = 2;
n1 = 400;
Change = [];
counter = 0;
[preV] = predictARMAmultistep(X2,n1,p,q,T,'');

n = n1;
while(n<=length(X1)-T)
    a = 5*std(preV);
    Sn = 0;
    for i = 1:T
        err = abs(X1(n+i)-preV(i));
        Sn = Sn + err;
    end
    Sn = Sn/T;
    if(Sn>a)
        Change = [Change; n+T]
        n = n+T;
        counter = counter+T;
    else
        n = n+1;
        counter = counter+1;
    end
    [preV] = predictARMAmultistep(X2(1+counter:length(X2)),n1,p,q,T,'');
end

figure()
plot(B)
hold on
for i = 1:length(Change)
    plot(Change(i),B(Change(i)),'o')
end
title('Points of change in timeseries B')

figure()
plot(X2)
hold on
for i = 1:length(Change)
    plot(Change(i),X2(Change(i)),'o')
end
title('Points of change in timeseries X_2')

%% 6. NonLinear Timeseries
% FNN for X1 : Detrended A
%%% Choose lag
%%% M = estimator
tmax = 20;
mutM = mutualinformation(X1,tmax);
%%% we see that we can choose tau = 2 because of the diagram, but 
%%% tau = 1,3,4 are also candidates

%%% Choose embedding dimension
%%% FNN
tau = 1;
% %%% we also check for 2,3,4
mmax = 10;
% escape = 10;
% theiler = 0;
% figure()
% fnnM = falsenearest(X1,tau,mmax,escape,theiler,'X1');
knn_deneme(X1,tau,mmax,15,2)


%%% Eventually, we take the best results for tau = 1 and m = 5

m = 5;
%%% get embedded data - Our new TS is:
X1_emb = embeddelays(X1,m,tau);
%%% plot attractor
plotd2d3(X1_emb,'')

% FNN for X2 : Detrended ?
%%% Choose lag
%%% M = estimator
tmax = 20;
mutM = mutualinformation(X2,tmax);
%%% we see that we can choose tau = 2 because of the diagram, but 
%%% tau = 1,3,4 are also candidates

%%% Choose embedding dimension
%%% FNN
tau = 4;
% %%% we also check for 1,3,4
% mmax = 10;
% escape = 10;
% theiler = 0;
% figure()
% fnnM = falsenearest(X2,tau,mmax,escape,theiler,'X2');
knn_deneme(X2,tau,mmax,15,2)


%%% Eventually, we take the best results for tau = 4 and m = 4

%%% from the diagram we choose m = 4
m = 4;
%%% get embedded data - Our new TS is:
X2_emb = embeddelays(X2,m,tau);
%%% plot attractor
plotd2d3(X2_emb,'')



%% 6.4
tau = 1;
m = 5;
T = 2;
n1 = 400;
Change = [];
counter = 0;
[preV] = localpredictmultistep(X1,n1,tau,m,T,nnei,q,'');
n = n1;
while(n<=length(X1)-T)
    a = 3*std(preV);
    Sn = 0;
    for i = 1:T
        err = abs(X1(n+i)-preV(i));
        Sn = Sn + err;
    end
    Sn = Sn/T;
    if(Sn>a)
        Change = [Change; n+T]
        n = n+T;
        counter = counter+T;
    else
        n = n+1;
        counter = counter+1;
    end
    [preV] = localpredictmultistep(X1(1+counter:length(X1)),n1,tau,m,T,nnei,q,'');
end

figure()
plot(A)
hold on
for i = 1:length(Change)
    plot(Change(i),A(Change(i)),'o')
end
title('Points of change in timeseries A')

figure()
plot(X1)
hold on
for i = 1:length(Change)
    plot(Change(i),X1(Change(i)),'o')
end
title('Points of change in timeseries X_1')
%% 6.5
tau = 4;
m = 4;
T = 2;
n1 = 400;
Change = [];
counter = 0;
[preV] = localpredictmultistep(X2,n1,tau,m,T,nnei,q,'');
n = n1;
while(n<=length(X2)-T)
    a = 7*std(preV);
    Sn = 0;
    for i = 1:T
        err = abs(X2(n+i)-preV(i));
        Sn = Sn + err;
    end
    Sn = Sn/T;
    if(Sn>a)
        Change = [Change; n+T]
        n = n+T;
        counter = counter+T;
    else
        n = n+1;
        counter = counter+1;
    end
    [preV] = localpredictmultistep(X2(1+counter:length(X1)),n1,tau,m,T,nnei,q,'');
end


% Plots
figure()
plot(B)
hold on
for i = 1:length(Change)
    plot(Change(i),B(Change(i)),'o')
end
title('Points of change in timeseries B')

figure()
plot(X2)
hold on
for i = 1:length(Change)
    plot(Change(i),X2(Change(i)),'o')
end
title('Points of change in timeseries X_2')