%% Discrete Fourier Transform (DFT)
x = [1, 2, 3, 4, 5];
myMatrixDFT = myMatrixDFT(x)
FFT = fft(x)

%% Use the FFT
load signal.mat
N = length(x);
X_k = fft(x);
Xk = fftshift(X_k);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;

figure();
subplot(1,2,1);
plot(w, abs(Xk));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response');
grid on;

subplot(1,2,2);
plot(w, angle(Xk));
xlabel('Little Omega');
ylabel('Phase');
title('Phase Response');
grid on;

W = w*200;
figure();
subplot(1,2,1);
plot(W, abs(Xk));
xlabel('Big Omega');
ylabel('Magnitude');
title('Magnitude Response');
grid on;

subplot(1,2,2);
plot(W, angle(Xk));
xlabel('Big Omega');
ylabel('Phase');
title('Phase Response');
grid on;

% There are three frequency tones, they are approximately 300Hz, 150Hz, 15Hz



%% Zero-Padding
load NMRSpec.mat

N = length(st);
X_k = fft(s t);
Xk = fftshift(X_k);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;

figure();
subplot(1,2,1);
plot(w, abs(Xk));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response');
grid on;

subplot(1,2,2);
plot(w, angle(Xk));
xlabel('Little Omega');
ylabel('Phase');
title('Phase Response');
grid on;

W = w*2000;
figure();
subplot(1,2,1);
plot(W, abs(Xk));
xlabel('Big Omega');
ylabel('Magnitude');
title('Magnitude Response');
grid on;

subplot(1,2,2);
plot(W, angle(Xk));
xlabel('Big Omega');
ylabel('Phase');
title('Phase Response');
grid on;

x = zeros(1, 32);
for i = 1:32
    x(i) = st(i);
end

N = 32;
X_k = fft(x);
Xk = fftshift(X_k);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;

figure();
subplot(1,2,1);
plot(w, abs(Xk));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response');
grid on;

subplot(1,2,2);
plot(w, angle(Xk));
xlabel('Little Omega');
ylabel('Phase');
title('Phase Response');
grid on;

W = w*2000;
figure();
subplot(1,2,1);
plot(W, abs(Xk));
xlabel('Big Omega');
ylabel('Magnitude');
title('Magnitude Response');
grid on;

subplot(1,2,2);
plot(W, angle(Xk));
xlabel('Big Omega');
ylabel('Phase');
title('Phase Response');
grid on;



for i = 33:512
    x = [x,0];
end

N = 512;
X_k = fft(x);
Xk = fftshift(X_k);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;

figure();
subplot(1,2,1);
plot(w, abs(Xk));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response');
grid on;

subplot(1,2,2);
plot(w, angle(Xk));
xlabel('Little Omega');
ylabel('Phase');
title('Phase Response');
grid on;

W = w*2000;
figure();
subplot(1,2,1);
plot(W, abs(Xk));
xlabel('Big Omega');
ylabel('Magnitude');
title('Magnitude Response');
grid on;

subplot(1,2,2);
plot(W, angle(Xk));
xlabel('Big Omega');
ylabel('Phase');
title('Phase Response');
grid on;

% The peaks corresponding to creatine and chlorine can be seen from the plot before zero-padding the sequence.
% The spectrum is more clearly shown after zero-padding the sequence to length of 512.
% The peaks corresponding to creatine and chlorine can be seen from the plot more clearly.
% This is becuase after zero-padding the sequence, we obtain a denser frequency grid when applying fft.

%% Truncation and Windowing
% Report Item 4

% Rectangular window
N = 20;
w_function = ones(1,N);
n = 0:1:N-1;
figure()
stem(n, w_function)
title('Rectangular Window of Length 20')
xlabel('n')
ylabel('Rect')

zp = zeros(1, 512-20);
w_function = [w_function, zp];
N = 512;
W_FUNCTION = fft(w_function);
FUNCTION = fftshift(W_FUNCTION);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;

figure();
plot(w, abs(FUNCTION));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response');
grid on;

figure();
plot(w, angle(FUNCTION));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response');
grid on;

figure();
plot(w, mag2db(abs(FUNCTION)));
xlabel('Little Omega');
ylabel('Magnitude(dB)');
title('Magnitude Response');
grid on;
%% Triangular window
N = 20;
n = 0:1:19;
w_function = zeros(1,20);

for i = 1:10
    w_function(i) = 2*i/N;
end

for i = 11:N
    w_function(i) = w_function(N+1-i);
end

figure()
stem(n, w_function)
title('Triangular Window of Length 20')
xlabel('n')
ylabel('Tri')

zp = zeros(1, 512-20);
w_function = [w_function, zp];
N = 512;
W_FUNCTION = fft(w_function);
FUNCTION = fftshift(W_FUNCTION);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;

figure();
plot(w, abs(FUNCTION));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response');
grid on;

figure();
plot(w, mag2db(abs(FUNCTION)));
xlabel('Little Omega');
ylabel('Magnitude(dB)');
title('Magnitude Response');
grid on;



%% Hamming window
N = 20;
n = 0:1:19;
w_function = zeros(1,20);

for i = 1:20
    w_function(i) = 0.54-0.46*cos(2*pi*i/N);
end

figure()
stem(n, w_function)
title('Hamming Window of Length 20')
xlabel('n')
ylabel('Hamming')

zp = zeros(1, 512-20);
w_function = [w_function, zp];
N = 512;
W_FUNCTION = fft(w_function);
FUNCTION = fftshift(W_FUNCTION);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;

figure();
plot(w, abs(FUNCTION));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response');
grid on;

figure();
plot(w, mag2db(abs(FUNCTION)));
xlabel('Little Omega');
ylabel('Magnitude(dB)');
title('Magnitude Response');
grid on;


%% Hanning window
N = 20;
n = 0:1:19;
w_function = zeros(1,20);

for i = 1:20
    w_function(i) = 0.5-0.5*cos(2*pi*i/N);
end

figure()
stem(n, w_function)
title('Hanning Window of Length 20')
xlabel('n')
ylabel('Hanning')

zp = zeros(1, 512-20);
w_function = [w_function, zp];
N = 512;
W_FUNCTION = fft(w_function);
FUNCTION = fftshift(W_FUNCTION);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;

figure();
plot(w, abs(FUNCTION));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response');
grid on;

figure();
plot(w, mag2db(abs(FUNCTION)));
xlabel('Little Omega');
ylabel('Magnitude(dB)');
title('Magnitude Response');
grid on;


%% Kaiser Window
N = 20;
n = 0:1:19;
w_function = zeros(1,20);

for i = 1:20
    p = i-1;
    w_function(i) = besseli(0, 0.1*sqrt(1-((p-N/2)/(N/2))^2));
end

figure()
stem(n, w_function)
title('Kaiser Window of Length 20')
xlabel('n')
ylabel('Kaiser')

zp = zeros(1, 512-20);
w_function = [w_function, zp];
N = 512;
W_FUNCTION = fft(w_function);
FUNCTION = fftshift(W_FUNCTION);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;

figure();
plot(w, abs(FUNCTION));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response');
grid on;

figure();
plot(w, mag2db(abs(FUNCTION)));
xlabel('Little Omega');
ylabel('Magnitude(dB)');
title('Magnitude Response');
grid on;

figure();
plot(w, angle(FUNCTION));
xlabel('Little Omega');
ylabel('Magnitude(dB)');
title('Magnitude Response');
grid on;
% The mainlobe width of the triangular window is bigger than the mainlobe width of the rectangular window.
% The sidelobe height of trianular window's sidelobe lower than the sidelobe height of the rectangular window.
% Comparing the sidelobe height of a rectangular window and a hamming window, the hamming window has lower sidelobe height.


%% Report Item 5
N = 20;
w = linspace(-pi/2,pi/2,1000);
X_w = exp(-1i .* w .* (N+1)/2) .* N .* diric(w,N);

figure();
subplot(1,2,1);
plot(w, abs(X_w));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response (N=20)');
grid on;

subplot(1,2,2);
plot(w, angle(X_w));
xlabel('Little Omega');
ylabel('Phase');
title('Phase Response (N=20)');
grid on;

N = 40;
w = linspace(-pi/2,pi/2,1000);
X_w = exp(-1i .* w .* (N+1)/2) .* N .* diric(w,N);

figure();
subplot(1,2,1);
plot(w, abs(X_w));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response (N=40)');
grid on;

subplot(1,2,2);
plot(w, angle(X_w));
xlabel('Little Omega');
ylabel('Phase');
title('Phase Response (N=40)');
grid on;

% The zero crossing frequency of the diric function is w = 2pi*l/N
% Therefore, for N = 20, mainlobe width is pi/10
% For N = 40, mainlobe width is pi/20


%% Report Item 7
% x(n) = sin(2pi*5*n*0.02) = sin(0.2pi*n)
% 0.2pi*N = 2pi*l => N = 2pi*l/0.2pi = 10l
% minimum N = 10 (l=1)
n = 0:1:9;
N = 10;
x = sin(0.2 .* pi .* n);
Xw = fft(x);
X = fftshift(Xw);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;

figure();
subplot(1,2,1);
plot(w, abs(X));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response (N=40)');
grid on;

subplot(1,2,2);
plot(n, angle(x));
xlabel('Little Omega');
ylabel('Phase');
title('Phase Response (N=40)');
grid on;


% 0.2pi*N = 2pi*l => N = 2pi*l/0.2pi = 10l
% minimum N = 10 (l=1)

%% Spectrogram
% Report Item 7
% song1
load song1.mat
Fs = 44100;
sound(song1, Fs)

N = 4096;
w_function = zeros(1,4096);

for i = 1:4096
    w_function(i) = 0.54-0.46*cos(2*pi*i/N);
end

[s, w, t] = spectrogram(song1, w_function ,2048, 4096);
imagesc(t,w,log(abs(s)));

%% song2
load song2.mat
Fs = 44100;
sound(song1, Fs)

N = 4096;
w_function = zeros(1,4096);

for i = 1:4096
    w_function(i) = 0.54-0.46*cos(2*pi*i/N);
end

[s, w, t] = spectrogram(song2, w_function ,2048, 4096);
imagesc(t,w,log(abs(s)));
xlabel('Time Bloc')
ylabel('Frequency')
%% song3
load song3.mat
Fs = 44100;
sound(song1, Fs)

N = 4096;
w_function = zeros(1,4096);

for i = 1:4096
    w_function(i) = 0.54-0.46*cos(2*pi*i/N);
end

[s, w, t] = spectrogram(song3, w_function ,2048, 4096);
imagesc(t,w,log(abs(s)));

