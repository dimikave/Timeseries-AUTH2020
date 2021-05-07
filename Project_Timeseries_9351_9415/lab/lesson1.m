% %%% load data
% %%% fortwnoume kai kanoume plot
A = importdata('epileeg.dat');
plot(A,'-o')
xlabel('t[sec]')
ylabel('values')
% 
% %%%an thelw mikrotero plot px apo 100 mexri 500
% 
plot(A(100:500),'-o')
xlabel('t[sec]')
ylabel('values')
% 
% %%% another dataset with two columns
B = importdata('sunspots.dat');
plot(B(:,2),'-o')
xlabel('t[years]')
ylabel('values')

% %%%random U
c = rand(1000,1); %tuxaious apo omoiomorfh katanomh
plot(c)
figure(2)
hist(c)
% 
% %%%random Normal apo kanonikh katanomh
d = randn(1000,1);
figure(3)
hist(d)
% 
% %%scater plot
f = randn(5000,1);
figure(4)
scatter(f,1:5000)
% 
% %scatter plot linear model
n = 100;
x = [1:n];
y = 0.1*x+2;
scatter(x,y)

%import henon
henon = importdata('henon.dat');
plot(henon(1:1000))
x = henon(1:4998,1);
y = henon(2:4999,1);
figure(5)
scatter(x,y)

%elkustes 3d
x = henon(1:4998,1);
y = henon(2:4999,1);
z = henon(3:5000,1);
scatter3(x,y,z)
