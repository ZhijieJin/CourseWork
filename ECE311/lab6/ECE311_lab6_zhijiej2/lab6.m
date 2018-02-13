%% 1. Ideal Filters
%% Report Item 1
%% N = 20
% Low Pass filter
% Choose wc = pi/4 for low pass filter
N= 20;
n = -N:1:N;
wc = pi/4;
hl = wc./pi.*sinc(wc./pi.*n);
HL = fft(hl);
Hwl = fftshift(HL);
w = fftshift((0:length(n)-1)/length(n)*2*pi);
w(1:length(n)/2) = w(1:length(n)/2) - 2*pi;

figure();
subplot(2,1,1);
stem(n, hl);
xlabel('n');
ylabel('Impulse Response');
title('Impulse Response for LPF (N=20)');
grid on;

subplot(2,1,2);
plot(w, abs(Hwl));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response for LPF (N=20)');
grid on;

% High Pass filter
% Choose wc = pi/3
N= 20;
n = -N:1:N;
wc = pi/3;
delta = zeros(1, length(n));
delta(N+1) = 1;
hh = delta - wc./pi.*sinc(wc./pi.*n);
HH = fft(hh);
Hwh = fftshift(HH);
w = fftshift((0:length(n)-1)/length(n)*2*pi);
w(1:length(n)/2) = w(1:length(n)/2) - 2*pi;

figure();
subplot(2,1,1);
stem(n, hh);
xlabel('n');
ylabel('Impulse Response');
title('Impulse Response for HPF (N=20)');
grid on;

subplot(2,1,2);
plot(w, abs(Hwh));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response for HPF (N=20)');
grid on;

% Band Pass filter
% Choose wc = pi/3, wo = pi/2
N= 20;
n = -N:1:N;
wc = pi/4;
wo = pi/2;
hb = cos(wo.*n).* wc./pi.*sinc(wc./pi.*n);
HB = fft(hb);
Hwb = fftshift(HB);
w = fftshift((0:length(n)-1)/length(n)*2*pi);
w(1:length(n)/2) = w(1:length(n)/2) - 2*pi;

figure();
subplot(2,1,1);
stem(n, hb);
xlabel('n');
ylabel('Impulse Response');
title('Impulse Response for BPF (N=20)');
grid on;

subplot(2,1,2);
plot(w, abs(Hwb));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response for BPF (N=20)');
grid on;

%% N = 40
% Low Pass filter
% Choose wc = pi/4 for low pass filter
N= 40;
n = -N:1:N;
wc = pi/4;
hl = wc./pi.*sinc(wc./pi.*n);
HL = fft(hl);
Hwl = fftshift(HL);
w = fftshift((0:length(n)-1)/length(n)*2*pi);
w(1:length(n)/2) = w(1:length(n)/2) - 2*pi;

figure();
subplot(2,1,1);
stem(n, hl);
xlabel('n');
ylabel('Impulse Response');
title('Impulse Response for LPF (N=40)');
grid on;

subplot(2,1,2);
plot(w, abs(Hwl));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response for LPF (N=40)');
grid on;

% High Pass filter
% Choose wc = pi/3
N= 40;
n = -N:1:N;
wc = pi/3;
delta = zeros(1, length(n));
delta(N+1) = 1;
hh = delta - wc./pi.*sinc(wc./pi.*n);
HH = fft(hh);
Hwh = fftshift(HH);
w = fftshift((0:length(n)-1)/length(n)*2*pi);
w(1:length(n)/2) = w(1:length(n)/2) - 2*pi;

figure();
subplot(2,1,1);
stem(n, hh);
xlabel('n');
ylabel('Impulse Response');
title('Impulse Response for HPF (N=40)');
grid on;

subplot(2,1,2);
plot(w, abs(Hwh));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response for HPF (N=40)');
grid on;

% Band Pass filter
% Choose wc = pi/3, wo = pi/2
N= 40;
n = -N:1:N;
wc = pi/4;
wo = pi/2;
hb = cos(wo.*n).* wc./pi.*sinc(wc./pi.*n);
HB = fft(hb);
Hwb = fftshift(HB);
w = fftshift((0:length(n)-1)/length(n)*2*pi);
w(1:length(n)/2) = w(1:length(n)/2) - 2*pi;

figure();
subplot(2,1,1);
stem(n, hb);
xlabel('n');
ylabel('Impulse Response');
title('Impulse Response for BPF (N=40)');
grid on;

subplot(2,1,2);
plot(w, abs(Hwb));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response for BPF (N=40)');
grid on;
%% Report Item 2
load impulseresponse.mat
N = 512;
H_k = fft(h,N);
Hk = fftshift(H_k);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;

figure();
stem(h);
xlabel('n');
ylabel('Impulse response');
title('Impulse Response');

figure();
subplot(2,1,1);
plot(w, mag2db(abs(Hk)));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response');
grid on;

subplot(2,1,2);
plot(w, phase(Hk));
xlabel('Little Omega');
ylabel('Phase');
title('Phase Response');
grid on;

%% 2. Generalized Linear Phase FIR Filters
%% 3. Windowing Method
%% Report Item 3
N = 25;
k = (N-1)/2.0;
n = 0:N-1;
cutoff = pi/3;
% Hamming window
wn = hamming(N);

w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;
Dw = zeros(1,length(w));
Dw(9:17) = 1;
gn = real(ifft(ifftshift(Dw.*exp(-1i.*w.*k))));
hn = wn.*gn';

figure();
stem(gn)
xlabel('n');
ylabel('Impulse Response');
title('Impulse Response');

N2 = 128;
H_k = fft(hn,N2);
Hk = fftshift(H_k);
w2 = fftshift((0:N2-1)/N2*2*pi);
w2(1:N2/2) = w2(1:N2/2) - 2*pi;

figure();
subplot(2,1,1);
plot(w2, mag2db(abs(Hk)));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response');
grid on;

subplot(2,1,2);
plot(w2, phase(Hk));
xlabel('Little Omega');
ylabel('Phase');
title('Phase Response');
grid on;

%% 4. Frequency Sampling Method
%% 5. Parks-McClellan FIR Filter Design
%% Report Item 4
rp = 2;
a = [1, 0];
fs = 1;
f = [0.3/2, 0.36/2];
rs = 50;
dev = [(10^(rp/20)-1)/(10^(rp/20)+1) 10^(-rs/20)];
[n, fo, mo, w] = firpmord(f, a, dev, fs);
b = firpm(n, fo, mo, w);
figure();
impz(b, 1)
figure();
freqz(b, 1, 1024)
title('Frequency Response')

%% 6. Fourier De-noising
%% Report Item 5
[y,Fs] = audioread('sound1.wav');
%sound(y,Fs);

time = length(y)/Fs;
fprintf('The signal in sound1 lasts %f second\n', time);

N=length(y);
Yk = fftshift(fft(y));
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2)-2*pi;
W = Fs*(w/1000/(2*pi));

figure();
plot(W,abs(Yk))
xlabel('frequency(kHz)')
ylabel('X(f)')
title('Magnitude Spectrum of Sound1')
grid on

w_function = zeros(1,4096);
for i = 1:4096
    w_function(i) = 0.54-0.46*cos(2*pi*i/N);
end
[s, w, t] = spectrogram(y, w_function ,2048, 4086);
figure();
imagesc(t/2/pi/1000,w*10,(abs(s)));
xlabel('time(s)')
ylabel('frequency(kHz)')
title('Spectrum of Sound1 Before Denoising')

rp = 1;
a = [1, 0];
fs = Fs;
f = [10000, 11000];
rs = 50;
dev = [(10^(rp/20)-1)/(10^(rp/20)+1) 10^(-rs/20)];
[n, fo, mo, w] = firpmord(f, a, dev, fs);
filter = firpm(n, fo, mo, w);

Ynew = fftshift(fft(filter,N).*(fft(y))');
ynew = ifft(ifftshift(Ynew));
ynew = fliplr(ynew);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2)-2*pi;
W = Fs*(w/1000/(2*pi));
soundsc(ynew,Fs);

figure();
plot(W,abs(Ynew))
xlabel('frequency(kHz)')
ylabel('X(f)')
title('Magnitude Spectrum of Sound1')
grid on

w_function = zeros(1,4096);
for i = 1:4096
    w_function(i) = 0.54-0.46*cos(2*pi*i/N);
end
[s, w, t] = spectrogram(ynew, w_function ,2048, 4086);
figure();
imagesc(t/2/pi/1000,w*10,(abs(s)));
xlabel('time(s)')
ylabel('frequency(kHz)')
title('Spectrum of Sound1 After Denoising')

%% Report Item 6
[y,Fs] = audioread('sound2.wav');
%sound(y,Fs);

time = length(y)/Fs;
fprintf('The signal in sound1 lasts %f second\n', time);

N=length(y);
Yk = fftshift(fft(y));
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2)-2*pi;
W = Fs*(w/1000/(2*pi));

figure();
plot(W,abs(Yk))
xlabel('frequency(kHz)')
ylabel('X(f)')
title('Magnitude Spectrum of Sound2')
grid on

w_function = zeros(1,4096);
for i = 1:4096
    w_function(i) = 0.54-0.46*cos(2*pi*i/N);
end
[s, w, t] = spectrogram(y, w_function ,2048, 4096);
figure();
imagesc(t/2/pi/1000,w*10,(abs(s)));
xlabel('time(s)')
ylabel('frequency(kHz)')
title('Spectrum of Sound2 Before Denoising')

rp = 1;
a = [1, 0];
fs = Fs;
f = [5000, 7000];
rs = 50;
dev = [(10^(rp/20)-1)/(10^(rp/20)+1) 10^(-rs/20)];
[n, fo, mo, w] = firpmord(f, a, dev, fs);
filter = firpm(n, fo, mo, w);

Ynew = fftshift(fft(filter,N).*(fft(y))');
ynew = ifft(ifftshift(Ynew));
ynew = fliplr(ynew);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2)-2*pi;
W = Fs*(w/1000/(2*pi));
soundsc(ynew,Fs);

figure();
plot(W,abs(Ynew))
xlabel('frequency(kHz)')
ylabel('X(f)')
title('Magnitude Spectrum of Sound2')
grid on

w_function = zeros(1,4096);
for i = 1:4096
    w_function(i) = 0.54-0.46*cos(2*pi*i/N);
end
[s, w, t] = spectrogram(ynew, w_function ,2048, 4096);
figure();
imagesc(t/2/pi/1000,w*10,(abs(s)));
xlabel('time(s)')
ylabel('frequency(kHz)')
title('Spectrum of Sound2 After Denoising')
%% 7. Fast Convolution
%% Report Item 7
% N = 50
% 1.)
load sig1.mat
N = 50;
x = zeros(1, N);
for i = 1:N
    x(i) = sig1(i);
end

% 2.)
M = 24;
h = ones(1, M);
h = 1/24.*h;

% 3.)
z1 = zeros(1, M-1);
xz = [x z1];
z2 = zeros(1, N-1);
hz = [h z2];

% 4.)
fprintf('(N=50)\n')
fprintf('Using FFhn = wn*gn;T\n')
tic
y1 = ifft(fft(xz).*fft(hz));
toc

% 5.)
C = convmtx(h, N);

% 6.)
fprintf('Using matrix C\n')
tic
y2 = C * xz';
toc

% N = 100
% 1.)
load sig1.mat
N = 100;
x = zeros(1, N);
for i = 1:N
    x(i) = sig1(i);
end

% 2.)
M = 24;
h = ones(1, M);
h = 1/24.*h;

% 3.)
z1 = zeros(1, M-1);
xz = [x z1];
z2 = zeros(1, N-1);
hz = [h z2];

% 4.)
fprintf('\n(N=100)\n')
fprintf('Using FFT\n')
tic
y1 = ifft(fft(xz).*fft(hz));
toc

% 5.)
fprintf('Using matrix C\n')
C = convmtx(h, N);

% 6.)
tic
y2 = C * xz';
toc

% N = 500
% 1.)
load sig1.mat
N = 500;
x = zeros(1, N);
for i = 1:N
    x(i) = sig1(i);
end

% 2.)
M = 24;
h = ones(1, M);
h = 1/24.*h;

% 3.)
z1 = zeros(1, M-1);
xz = [x z1];
z2 = zeros(1, N-1);
hz = [h z2];

% 4.)
fprintf('\n(N=500)\n')
fprintf('Using FFT\n')
tic
y1 = ifft(fft(xz).*fft(hz));
toc

% 5.)
fprintf('Using matrix C\n')
C = convmtx(h, N);

% 6.)
tic
y2 = C * xz';
toc

% N = 1000
% 1.)
load sig1.mat
N = 1000;
x = zeros(1, N);
for i = 1:N
    x(i) = sig1(i);
end

% 2.)
M = 24;
h = ones(1, M);
h = 1/24.*h;

% 3.)
z1 = zeros(1, M-1);
xz = [x z1];
z2 = zeros(1, N-1);
hz = [h z2];

% 4.)
fprintf('\n(N=1000)\n')
fprintf('Using FFT\n')
tic
y1 = ifft(fft(xz).*fft(hz));
toc

% 5.)
fprintf('Using matrix C\n')
C = convmtx(h, N);

% 6.)
tic
y2 = C * xz';
toc

% N = 10000
% 1.)
load sig1.mat
N = 10000;
x = zeros(1, N);
for i = 1:N
    x(i) = sig1(i);
end

% 2.)
M = 24;
h = ones(1, M);
h = 1/24.*h;

% 3.)
z1 = zeros(1, M-1);
xz = [x z1];
z2 = zeros(1, N-1);
hz = [h z2];

% 4.)
fprintf('\n(N=10000)\n')
fprintf('Using FFT\n')
tic
y1 = ifft(fft(xz).*fft(hz));
toc

% 5.)
fprintf('Using matrix C\n')
C = convmtx(h, N);

% 6.)
tic
y2 = C * xz';
toc