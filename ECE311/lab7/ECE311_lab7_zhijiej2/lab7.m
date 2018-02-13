%% 1. Discussion
%% 2. Upsampling and Downsampling
%% Report Item 1
% U = 2, D = 3
[audio, Fs] = audioread('audioclip.wav');
% sound(audio, Fs)
N = length(audio);
audio_fft = fft(audio);
audio_fftshift = fftshift(audio_fft);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;
Freq = Fs*w/(2*pi);
maxf = max(Freq);

figure();
plot(Freq, mag2db(abs(audio_fftshift)));
xlabel('Frequency(Hz)');
ylabel('Magnitude');
title('Magnitude Response of the audio');
grid on;

U = 2;
audioup = upsample(audio, U);
N = length(audioup);
audioup_fft = fft(audioup);
audioup_fftshift = fftshift(audioup_fft);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;
Freq = 2*Fs*w/(2*pi);

figure();
plot(Freq, mag2db(abs(audioup_fftshift)));
xlabel('Frequency(Hz)');
ylabel('Magnitude');
title('Magnitude Response of the upsampled audio before filtering');
grid on;

% apply low pass filter
% d) low pass filter
LPF = zeros(length(Freq),1);
for i = length(Freq)/4 : length(Freq)*3/4
    LPF(i) = 1;
end


audioupLPF(:,1) = audioup_fftshift(:,1).*LPF;
audioupLPF(:,2) = audioup_fftshift(:,2).*LPF;

%audioupLPF_fft = fft(audioupsamples);
%audioupLPF_fftshift = fftshift(audioupLPF_fft);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;
Freq = Fs*w/(2*pi);

figure();
plot(Freq, mag2db(abs(audioupLPF)));
xlabel('Frequency(Hz)');
ylabel('Magnitude');
title('Magnitude Response of the upsampled audio after filtering');
grid on;

% goes back to time domain and apply lpf
audioupsamples = real(ifft(ifftshift(audioupLPF)));

% down sampling
D = 3;
audiodown = downsample(audioupsamples, D);
N = length(audiodown);
audiodown_fft = fft(audiodown);
audiodown_fftshift = fftshift(audiodown_fft);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;
Freq = 2/3*Fs*w/(2*pi);

figure();
plot(Freq, mag2db(abs(audiodown_fftshift)));
xlabel('Frequency(Hz)');
ylabel('Magnitude');
title('Magnitude Response of the downsampled audio');
grid on;

% sound(audiodownsamples, 2/3*Fs)
%% Report Item 2
% a)
clear;
load('song1_corrupt.mat');
Fs = 44100;
N = length(song1_corrupt);
corrupt_fft = fft(song1_corrupt);
corrupt_fftshift = fftshift(corrupt_fft);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;
Freq = Fs*w/(2*pi);

figure();
plot(Freq, mag2db(abs(corrupt_fftshift)));
xlabel('Frequency(Hz)');
ylabel('Magnitude');
title('Magnitude Response of the audio');
grid on;
%sound(song1_corrupt, Fs)

% b) Cannot hear the bat.
% c)
U = 2;
corruptup = upsample(song1_corrupt, U);
%sound(corruptup, Fs)
N = length(corruptup);
corruptup_fft = fft(corruptup);
corruptup_fftshift = fftshift(corruptup_fft);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;
Freq = U*Fs*w/(2*pi);

figure();
plot(Freq, mag2db(abs(corruptup_fftshift)));
xlabel('Frequency(Hz)');
ylabel('Magnitude');
title('Magnitude Response of the upsampled audio before filtering');
grid on;

% d) low pass filter
LPF = zeros(length(Freq),1);
for i = length(Freq)/4 : length(Freq)*3/4
    LPF(i) = 1;
end
figure()
plot(Freq, LPF)
title('Low pass filter')

% e) apply low pass filter

% goes back to time domain and apply lpf
corruptupLPF = corruptup_fftshift.'.*LPF;
corruptsamples = real(ifft(ifftshift(corruptupLPF)));
D = 2;
corruptdownsamples = downsample(corruptupsamples, D);
sound(corruptdownsamples, Fs)
N = length(corruptdownsamples);
corruptdownLPF_fft = fft(corruptdownsamples);
corruptdownLPF_fftshift = fftshift(corruptdownLPF_fft);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;
Freq = Fs*w/(2*pi);

figure();
plot(Freq, mag2db(abs(corruptdownLPF_fftshift)));
xlabel('Frequency(Hz)');
ylabel('Magnitude');
title('Magnitude Response of the upsampled audio after filtering');
grid on;

%% 3. Sporify Data Transfer Issue
%% Report Item 3
clear;
load('songz.mat')
%sound(good_news, 48000)
Fs = 48000;
audio = good_news;
N = length(audio);
audio_fft = fft(audio);
audio_fftshift = fftshift(audio_fft);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;
Freq = Fs*w/(2*pi);
maxf = max(Freq);

figure();
plot(Freq, mag2db(abs(audio_fftshift)));
xlabel('Frequency(Hz)');
ylabel('Magnitude');
title('Magnitude Response of the audio');
grid on;

U = 2;
audioup = upsample(audio, U);
N = length(audioup);
audioup_fft = fft(audioup);
audioup_fftshift = fftshift(audioup_fft);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;
Freq = U*Fs*w/(2*pi);

figure();
plot(Freq, mag2db(abs(audioup_fftshift)));
xlabel('Frequency(Hz)');
ylabel('Magnitude');
title('Magnitude Response of the upsampled audio before filtering');
grid on;

% apply low pass filter
% d) low pass filter
LPF = zeros(length(Freq),1);
for i = round(length(Freq)/4) : round(length(Freq)*3/4)
    LPF(i) = 1;
end


audioupLPF = audioup_fftshift.*LPF;

%audioupLPF_fft = fft(audioupsamples);
%audioupLPF_fftshift = fftshift(audioupLPF_fft);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;
Freq = Fs*w/(2*pi);

figure();
plot(Freq, mag2db(abs(audioupLPF)));
xlabel('Frequency(Hz)');
ylabel('Magnitude');
title('Magnitude Response of the upsampled audio after filtering');
grid on;

% goes back to time domain and apply lpf
audioupsamples = real(ifft(ifftshift(audioupLPF)));

% down sampling
D = 3;
audiodown = downsample(audioupsamples, D);
N = length(audiodown);
audiodown_fft = fft(audiodown);
audiodown_fftshift = fftshift(audiodown_fft);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;
Freq = 2/3*Fs*w/(2*pi);

figure();
plot(Freq, mag2db(abs(audiodown_fftshift)));
xlabel('Frequency(Hz)');
ylabel('Magnitude');
title('Magnitude Response of the downsampled audio');
grid on;

sound(audiodown, U/D*Fs)

%% 4. 2_D DFT
%% Report Item 4
M = 1:50;
N = 1:50;
[m, n] = meshgrid(M, N);
kx = pi/4;
ky = 0;
z = cos(ky*m + kx*n);
figure();
subplot(3, 1, 1)
imagesc(z)
title('Data(m,n)')

Z1 = myDFT2(z);
subplot(3, 1, 2)
imagesc(abs(Z1))
title('DFT of Data(m,n) from myDFT2 function')

Z2 = fft2(z);
subplot(3, 1, 3)
imagesc(abs(Z2))
title('DFT of Data(m,n) from fft2 function')

% (kx, ky ) = (0, π/4)
kx = pi/4;
ky = 0;

z = cos(ky*m + kx*n);
figure();
subplot(1, 2, 1)
imagesc(z)
title('(kx, ky ) = (0, π/4)')
xlabel('n')
ylabel('m')

Z1 = myDFT2(z);
subplot(1, 2, 2)
imagesc(abs(Z1))
title('DFT2 of f for (kx, ky ) = (0, π/4)')
xlabel('kx')
ylabel('ky')

% (kx, ky ) = (π/4, 0)
kx = 0;
ky = pi/4;

z = cos(ky*m + kx*n);
figure();
subplot(1, 2, 1)
imagesc(z)
title('(kx, ky ) = (π/4, 0)')
xlabel('n')
ylabel('m')

Z1 = myDFT2(z);
subplot(1, 2, 2)
imagesc(abs(Z1))
title('DFT2 of f for (kx, ky ) = (π/4, 0)')
xlabel('kx')
ylabel('ky')

% (kx, ky ) = (π/4, π/4)
kx = pi/4;
ky = pi/4;

z = cos(ky*m + kx*n);
figure();
subplot(1, 2, 1)
imagesc(z)
title('(kx, ky ) = (π/4, π/4)')
xlabel('n')
ylabel('m')

Z1 = myDFT2(z);
subplot(1, 2, 2)
imagesc(abs(Z1))
title('DFT2 of f for (kx, ky ) = (π/4, π/4)')
xlabel('kx')
ylabel('ky')

% (kx, ky ) = (π/4, -π/4)
kx = pi/4;
ky = -pi/4;

z = cos(ky*m + kx*n);
figure();
subplot(1, 2, 1)
imagesc(z)
title('(kx, ky ) = (π/4, -π/4)')
xlabel('n')
ylabel('m')

Z1 = myDFT2(z);
subplot(1, 2, 2)
imagesc(abs(Z1))
title('DFT2 of f for (kx, ky ) = (π/4, -π/4)')
xlabel('kx')
ylabel('ky')
%% 5. Image Filtering
%% Report Item 5
y = imread('image1.jpg');
figure();
imagesc(y)
title('Image1 Before Filtering')
h = [1/8, 1/16, 1/8; 1/16, 1/4, 1/16; 1/8, 1/16, 1/8];
y2 = conv2(double(h), double(y));
figure();
imagesc(y2)
title('Image1 After Filtering')

%% Report Item 6
y = imread('image2.jpg');
figure();
imagesc(y)
colormap('gray')
title('Image2 Before Filtering')
h = [-1, -1, -1; -1, 8, -1; -1, -1, -1];
y2 = conv2(double(h), double(y));
figure();
imagesc(y2)
colormap('gray')
title('Image2 After Filtering')

%% 6. Listening to a Picture, Looking at Sound
%% Report Item 7
% 1) 100*100 DFT matrix\
clear;
D = dftmtx(100);
DR = real(D);
DI = imag(D);

% 2) Convolution matrix
v = [1,2,3,4,5,6];
C = convmtx(v, 50);

% 3) 'motion' filter
h = fspecial('motion', 50, 30);

% 4) plot four matrix
figure();
subplot(2, 2, 1)
imagesc(DR)

subplot(2, 2, 2)
imagesc(DI)

subplot(2, 2, 3)
imagesc(C)

subplot(2, 2, 4)
imagesc(h)

% 5)
vectorDR = reshape(DR, [100*100, 1]);
vectorDI = reshape(DI, [100*100, 1]);
vectorC = reshape(C, [50*55, 1]);
vectorh = reshape(h, [27*45, 1]);
%sound(vectorDR, 44100)
%sound(vectorDI, 44100)
sound(vectorC, 44100)
sound(vectorh, 44100)




