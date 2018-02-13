% Clear the command window
clc, clear all, close all
%% 1. 1D Convolution for an Image
%% 1. (a)
im = imread('cameraman.tif');
imshow(im)
%% 1. (b)
im = imread('cameraman.tif');
% Get # of rows and cols of the image
[row, col] = size(im);
% Create the impulse response matrix
h = [0.2, 0.2, 0.2, 0.2, 0.2];
% Initialize the output
output = zeros(row, col);
% Compute convolution of each row
for i = 1:row
    z = conv(im(i,:), h, 'same');
    output(i,:) = z;
end 
imshow(uint8(output))
%% 1. (c)
im = imread('cameraman.tif');
% Get # of rows and cols of the image
[row, col] = size(im);
% Create the impulse response matrix
h = [0.2, 0.2, 0.2, 0.2, 0.2];
% Initialize the output
output = zeros(row, col);
% Compute convolution of each col
for i = 1:col
    z = conv(im(:,i), h, 'same');
    output(:,i) = z;
end 
imshow(uint8(output))
%% 1. (d)
im = imread('cameraman.tif');
% Get # of rows and cols of the image
[row, col] = size(im);
% Create the impulse response matrix
h = [0.2, 0.2, 0.2, 0.2, 0.2];
% Initialize the output
output = zeros(row, col);
output2 = zeros(row, col);
% Compute convolution of each row
for i = 1:row
    z = conv(im(i,:), h, 'same');
    output(i,:) = z;
end 
% Compute convolution of each col
for i = 1:col
    z = conv(output(:,i), h, 'same');
    output2(:,i) = z;
end 
imshow(uint8(output2))
%% 2. Zero-Input and Zero-State Response
%% 2. (a)
y1 = zeros(1, 21);
y2 = zeros(1, 21);
yinit = 1;

for i = 1:21
    x1 = 0;
    x2 = 0;
    n = i -1;
    if i-1 == 0
        x1 = 1;
        x2 = 1;
    end
    if i-1 == 0
        y1(i) = n/(n+1)*yinit + x1;
        y2(i) = 0.9*yinit + x2;
    else
        y1(i) = n/(n+1)*y1(i-1) + x1;
        y2(i) = 0.9*y2(i-1) + x2;
    end
end
x = 0:20;
figure;
stem(x, y1)
title('y1[n] = n/(n+1)*y1[n-1] + x[n], where y[-1] = 1, x[n] = δ[n]')
xlabel('x[n]')
ylabel('y1[n]')
figure;
stem(x, y2)
title('y2[n] = 0.9*y1[n-1] + x[n], where y[-1] = 1, x[n] = δ[n]')
xlabel('x[n]')
ylabel('y2[n]')
%% 2. (b)
y1 = zeros(1, 21);
y2 = zeros(1, 21);
yinit = 1;

for i = 1:21
    x1 = 0;
    x2 = 0;
    n = i -1;
    if i-1 == 5
        x1 = 1;
        x2 = 1;
    end
    if i-1 == 0
        y1(i) = n/(n+1)*yinit + x1;
        y2(i) = 0.9*yinit + x2;
    else
        y1(i) = n/(n+1)*y1(i-1) + x1;
        y2(i) = 0.9*y2(i-1) + x2;
    end
end
x = 0:20;
figure;
stem(x, y1)
title('y1[n] = n/(n+1)*y1[n-1] + x[n], where y[-1] = 1, x[n] = δ[n]')
xlabel('x[n]')
ylabel('y1[n]')
figure;
stem(x, y2)
title('y2[n] = 0.9*y1[n-1] + x[n], where y[-1] = 1, x[n] = δ[n]')
xlabel('x[n]')
ylabel('y2[n]')
%% 3. Qualcomm Stock Data Analysis
%% 3. (a)
load qcoms.mat
% Compute using the first sequence
y1 = zeros(4276,1);
for index = 1 : length(qcoms)-50
    sum1 = 0;
    for i = 0 : 50
        sum1 = sum1 + qcoms(index+i);
    end
    ave1 = 1/51 * sum1;
    y1(index + 50) = ave1;
end 

% Compute using the second sequence
y2 = zeros(4276,1);
for mid = 26 : length(qcoms)-25
    sum2 = 0;
    for i = -25 : 25
        sum2 = sum2 + qcoms(mid + i);
    end
    ave2 = 1/51 * sum2;
    y2(mid) = ave2;
end 

% Use convolution to verify
h = 1/51*ones(51,1);
y = conv(qcoms, h);
%% 3. (b)
load qcoms.mat
plot(1:4276,qcoms)
hold on
% Compute using the first sequence
y1 = zeros(4276,1);
for index = 1 : length(qcoms)-50
    sum1 = 0;
    for i = 0 : 50
        sum1 = sum1 + qcoms(index+i);
    end
    ave1 = 1/51 * sum1;
    y1(index + 50) = ave1;
end 
plot(1:4276,y1)
hold on

% Compute using the second sequence
y2 = zeros(4276,1);
for mid = 26 : length(qcoms)-25
    sum2 = 0;
    for i = -25 : 25
        sum2 = sum2 + qcoms(mid + i);
    end
    ave2 = 1/51 * sum2;
    y2(mid) = ave2;
end 
plot(1:4276,y2)
xlabel('n')
ylabel('x[n],y[n],z[n]')
title('Plot the sequences x[n], y1[n] and y2[n]')
hold off
legend('x[n]', 'y1[n]', 'y2[n]')
%% 4. Analytical Expression and Finite Length Representation of a Convolution
%% 4. (a)
n = 0:100;
y = 0.9.^n .* n;
figure 
plot(n, y)
xlabel('n')
ylabel('y[n]')
title('y[n] = 0.9^n * n * u[n]')
%% 4. (b)
n = 0:49;
x = 0.9.^n;
h = 0.9.^n;
y = conv(x,h);
figure
plot(0:length(x)-1,x)
hold on
plot(0:length(y)-1,y)
hold off
legend('x[n]', 'y[n]')
xlabel('n')
title('x = 0.9.^n, y[n] = 0.9^n * n * u[n], n = 0:49')
%% 4. (c)
n = 0:98;
x = 0.9.^n;
h = 0.9.^n;
y = conv(x,h);
figure
plot(0:length(x)-1,x)
hold on
plot(0:length(y)-1,y)
hold off
legend('x[n]', 'y[n]')
xlabel('n')
title('x = 0.9.^n, y[n] = 0.9^n * n * u[n], n = 0:98')
%% 4. (d)

%% 5. Stable or Unstable
%% 5.
y = zeros(1000, 1);
for i = 1 : 1001
    if i == 1
        y(i) = 1;
    else
        y(i) = 5*y(i-1) + 1;
    end
end

plot(0:1000, y)
xlabel('n')
ylabel('y[n]')
title('y[n] = 5y[n − 1] + x[n], y[−1] = 0')

%% 6. Convolution Sum
%% 6. (a)
% The prove is in the .pdf file.
%% 6. (b)
x = sin(2*pi*0.01*(0:100)) + 0.05*randn(1,101);
h=ones(1,5);
y = conv(x, h);
x = [x, [0,0,0,0]];
AxAh = sum(x)*sum(h)
Ay = sum(y)
plot(1:105, x)
hold on
plot(1:105, y)
legend('x[n]', 'y[n]')
xlabel('n')
title('Plot of x[n] and y[n] when h[n] is not normalized')
%% 6. (c)
x = sin(2*pi*0.01*(0:100)) + 0.05*randn(1,101);
h=1/5*ones(1,5);
y = conv(x, h);
x = [x, [0,0,0,0]];
AxAh = sum(x)*sum(h)
Ay = sum(y)
plot(1:105, x)
hold on
plot(1:105, y)
legend('x[n]', 'y[n]')
xlabel('n')
title('Plot of x[n] and y[n] when h[n] is normalized')
%% 6. (d)
% Difference in b and c is explained in the .pdf file.
title('Plot of x[n] and 
%% 7. Edge Detector for an Image
%% 7. (a)
%h = delta[n+1] - 2*delta[n] + delta[n-1];
h = [1, -2, 1];
%% 7. (b)
im = imread('cameraman.tif');
% Get # of rows and cols of the image
[row, col] = size(im);
% Create the impulse response matrix
h = [1,-2,1];
% Initialize the output
output = zeros(row, col);
% Compute convolution of each row
for i = 1:row
    z = conv(im(i,:), h, 'same');
    output(i,:) = z;
end 
imshow(uint8(output))
%% 7. (c)
im = imread('cameraman.tif');
% Get # of rows and cols of the image
[row, col] = size(im);
% Create the impulse response matrix
h = [1,-2,1];
% Initialize the output
output = zeros(row, col);
% Compute convolution of each col
for i = 1:col
    z = conv(im(:,i), h, 'same');
    output(:,i) = z;
end 
imshow(uint8(output))
