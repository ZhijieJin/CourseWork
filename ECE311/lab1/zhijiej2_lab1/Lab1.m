% Clear the command window
clc, clear all, close all
%% 3.Vectors and Matrices
vect = linspace(0, 1, 12)
%% 4.Plots and Labels(1.1)
x = linspace(0, 5, 100);
y = x.^2 .* log(x) .* sin(x);
plot(x,y);
xlabel('x');
ylabel('f(x)');
title('f(x)=x^2*log(x)*sin(x)');
%% 4.Plots and Labels(2.1)
x = 0:0.2:5;
f = x.^2 .* exp(x);
g = 3.*x.^0.5+sin(8.*pi.*x);
figure;
subplot(211);
plot(x, f);
xlabel('x');
ylabel('f(x)');
title('f(x)=x^2*exp(x)');
subplot(212);
plot(x, g);
xlabel('x');
ylabel('g(x)');
title('g(x)=3*sqrt(x)+sin(8*pi*x)');
%% 4.Plots and Labels(2.2)
x = 0:0.2:5;
f = x.^2 .* exp(x);
g = 3.*x.^0.5+sin(8.*pi.*x);
figure;
subplot(211);
stem(x, f);
xlabel('x');
ylabel('f(x)');
title('f(x)=x^2*exp(x)');
subplot(212);
stem(x, g);
xlabel('x');
ylabel('g(x)');
title('g(x)=3*sqrt(x)+sin(8*pi*x)');
%% 6.Matrix Operations(1)
x = linspace(-5, 5, 400);
z = linspace(-4, 4, 300);
y = transpose(z);
[xx, yy] = meshgrid(x, y);
f = sinc((xx.^2 + yy.^2).^0.5);
imagesc(x, y, f);
axis xy;
xlabel('x');
ylabel('y');
%% 6.Matrix Operations(2)
x = linspace(-5, 5, 400);
z = linspace(-4, 4, 300);
y = transpose(z);
[xx, yy] = meshgrid(x, y);
f = sinc(xx).*sinc(yy);
imagesc(x, y, f);
axis xy;
xlabel('x');
ylabel('y');
%% 7.Function
x = [1,3,-4,-3,4];
DFT = myDFT(x);
FFT = fft(x);
disp('DFT=')
disp(DFT)
disp('FFT=')
disp(FFT)
stem(x,real(DFT))
hold
stem(x,imag(DFT))
%% 8.Sounds and Images(sound)
load speechsig.mat
soundsc(x,8192);
% Human hearing range is from 20Hz to 20kHz
%% 8.Sounds and Images(image 1)
load clown
imagesc(X)
colormap(map)
%% 8.Sounds and Images(image 2)
load clown
row = X(17,:);
col = X(:,49);
subplot(211)
plot(row);
subplot(212)
plot(col);
%% 8.Sounds and Images(image 3)
T = transpose(X);
imagesc(T)
colormap(map)