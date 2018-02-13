% Clear the command window
clc, clear all, close all
%% 1. Z-Transform(1)
%% H1
b1 = [2, 0, 5, 4, 0, 9, -3];
a1 = [1];
S1 = tf(b1, a1);
N = 20;

figure;
subplot(121);
pzplot(S1);
subplot(122);
impz(b1, a1, N);

%% H2
b2 = [3, 2, 0, -2];
a2 = [1];
S2 = tf(b2, a2);
N = 20;

figure;
subplot(121);
pzplot(S2);
subplot(122);
impz(b2, a2, N);

%% H3
b3 = [0, 0, 0, 1, 0, 0, 1, -2];
a3 = [12, 1, 0, 4];
S3 = tf(b3, a3);
N = 20;

figure;
subplot(121);
pzplot(S3);
subplot(122);
impz(b3, a3, N);

%% 1. Z-Transform(2)
b = [0, 1];
a = [1, 2*cos(8*pi/10), 1];
S = tf(b, a);
N = 35;

figure;
subplot(121);
pzplot(S);
hold on

theta = linspace(0,2*pi,300);
x = cos(theta);
y = sin(theta);
plot(x,y,'--')
hold off

subplot(122);
impz(b, a, N);

% input that gives unbounded output: 
b1 = [0, 1];
a1 = [1, 2*cos(8*pi/10)+exp((1i*8*pi)/10), 1+2*cos(8*pi/10)+exp((1i*8*pi)/10), exp((1i*8*pi)/10)];
N = 35;
figure()
y=impz(b1, a1, N);
stem(y);
title('Unbounded Output')

% input that gives bounded output: unit impulse
b2 = [0, 1];
a2 = [1, 2*cos(8*pi/10), 1];
N = 35;
figure()
impz(b2, a2, N);
title('Bounded Output')


%% 2. Filter Functioin in Matlab(a)
% By analitical computation
% X(z)=(12-z^(-1))/(6-z^(-1)-z^(-2))

%% 2. Filter Functioin in Matlab(b)
n = 1:10;
x = (0.5).^n + (-1/3).^n;

b = [12, -2];
a = [6, -1, -1];
y = filter(b,a,x);
plot(n,x, n,y)
legend('Original Data', 'Filtered Data')
title('Filter plot')
%% 3. LSI System Response(a)
% By analytical computation
% h[n]=2*impuse[n]-4*(1/3)^n*u[n]

%% 3. LSI System Response(b)
n=0:19;
h=-4.*(1/3.0).^n;
h(1)= h(1)+2;
stem(n,h)
title('h[n] for 0 to 19')
xlabel('n')
ylabel('h[n]')

%% 3. LSI System Response(c)
n=0:19;
h=-4.*(1/3.0).^n;
h(1)= h(1)+2;
x=(1/2.0).^n;
y=conv(x,h,'same');
stem(n,y)
title('y[n] for 0 to 19')
xlabel('n')
ylabel('y[n]')

%% 4. Poles and Zeros(a)
b = [1, 0, 0, 0, 0, 0, 0, 0, 0, -1/1024];
a = [1, -0.5];
S = tf(b, a);

figure;
pzplot(S);
%% 4. Poles and Zeros(b)
b = [1, 0, 0, 0, 0, 0, 0, 0, 0, -1/1024];
a = [1, -0.5];
S = tf(b, a);
N = 15;

figure;
impz(b, a, N);
%% 5. Filter Function vs Recursive for Loop(a)
y = zeros(1, 50);

for i = 1:50
    if i == 1
        y(i) = 0.7^(i-1);
    elseif i == 2
        y(i) = 0.7^(i-1) - 0.7^(i-2);
    else
        y(i) = 0.7^(i-1) - 0.7^(i-2) + 0.81*y(i-2)
    end
end
n = 0:49;
figure;
stem(n, y)
axis([0 50 -1 1])
title('Iteration plot')
xlabel('n')
ylabel('y[n]')

%% 5. Filter Function vs Recursive for Loop(b)
n = 0:49;
x = (0.7).^n;

b = [1, -1];
a = [1, 0, -0.8];
y = filter(b,a,x);
stem(n,y)
axis([0 50 -1 1])
title('Filtered plot')
xlabel('n')
ylabel('y[n]')

%% 5. Filter Function vs Recursive for Loop(c)
y = zeros(1, 50);
for i = 1:50
    if i == 1
        y(i) = 0.7^(i-1);
    elseif i == 2
        y(i) = 0.7^(i-1) - 0.7^(i-2);
    else
        y(i) = 0.7^(i-1) - 0.7^(i-2) + 0.81*y(i-2)
    end
end

n = 0:49;
x = (0.7).^n;

b = [1, -1];
a = [1, 0, -0.8];
y2 = filter(b,a,x)
plot(n,y, n,y2)
axis([0 50 -1 1])

legend('iteration', 'filter')
title('y[n] = 0.7^n*u[n]-y[n-1]+0.81y[n-2], where y[-1]=y[-2]=0')
xlabel('n')
ylabel('y[n]')