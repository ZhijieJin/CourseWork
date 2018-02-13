%% 1. Spectral Analysis
load song1.mat
song1 = sigp;
Fs = 44100;

N = length(song1);
sigp_fft = fft(song1);
sigp_fftshift = fftshift(sigp_fft);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;
Freq = Fs*w/(2*pi);

figure();
subplot(2,1,1);
plot(Freq, abs(sigp_fftshift));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response');
grid on;

subplot(2,1,2);
plot(Freq, angle(sigp_fftshift));
xlabel('Little Omega');
ylabel('Phase');
title('Phase Response');

% b) The contaminating pitch is at approximately 100 Hz, because there is an impulse at
% approximately 100 Hz.

% c) Yes, a low pass filter is reasonable to use to remover the pitch.
% Beyond 100 Hz, the magnitude response of the signal is almost 0. Most of
% the information is contained within -100Hz and 100Hz.

%% 2. Filter Design
%% 2.1
N = 100;
n = -N:N;
wc = 2/3*pi;

delta = zeros(1, length(n));
delta(N+1) = 1;
hn = delta - wc./pi.*sinc(wc./pi.*n);
figure();
stem(n, hn)
title('time-domain impulse response')
xlabel('n')
ylabel('h[n]')

N2 = length(hn);
hn_fft = fft(hn);
hn_fftshift = fftshift(hn_fft);
w = fftshift((0:N2-1)/N2*2*pi);
w(1:N2/2) = w(1:N2/2) - 2*pi;

figure();
plot(w, mag2db(abs(hn_fftshift)));
xlabel('Frequency(Hz)');
ylabel('Magnitude');
title('frequency-domain magnitude response');
grid on;
%% 2.2
fs = 18000;
fstop = 5600;
fpass = 6000;
rs= 45;
rp = 1;

d = designfilt('highpassfir','StopbandFrequency',fstop, ...
  'PassbandFrequency',fpass,'StopbandAttenuation',rs, ...
  'PassbandRipple',rp,'SampleRate',fs,'DesignMethod','equiripple');

figure()
freqz(d.Coefficients,1,1024,fs)
title('Frequency response of the Highpass Filter')
xlabel('frequency(Hz)')

% generate marked plot
[h,w] = freqz(d.Coefficients,1,1024,fs);
length = length(d.Coefficients);

% plot magnitude response
figure();
plot(w, mag2db(abs(h)))

% mark 50dBHigh pass filter design
fifty = -50;
fiftyline = refline([0, fifty]);
fiftyline.Color = 'r';
txt1 = '-50dB';
text(8000, -48, txt1)

% mark rp
rpl = -0.5;
fiftyline = refline([0, rpl]);
fiftyline.Color = 'r';
txt2 = '\uparrow';
text(8000, -3, txt2)

rph = 0.5;
fiftyline = refline([0, rph]);
fiftyline.Color = 'r';
y = get(gca, 'ylim');
txt3 = '\downarrow';
text(8000, 3, txt3)

txt4 = '1 dB';
text(8100, 6, txt4)

% mark fstop
hold on
plot([5600 5600], y, 'r')
txt5 = 'fstop = 5600 \rightarrow';
text(3200, -100, txt5)

% mark fpass
hold on 
plot([6000 6000], y, 'r')
txt6 = '\leftarrow fpass = 6000';
text(6000, -110, txt6)

grid on;
title('Magnitude response of the Highpass Filter')
xlabel('frequency(Hz)')
ylabel('Magnitude(dB)')

%% 3. Image Processing
% a) Using low pass filter, because it reduces the edge content in an
% image, which in return resulting a blur image.

% b)
I = imread('Grumpy-Cat.jpg');
Iblure = imgaussfilt(I(:,:,1), 16);
figure();
subplot(1,2,1);
imshow(I)
title('Original image')
subplot(1,2,2);
imshow(Iblure)
title('blured cat')

% imgaussfilt filters the image I with a 2-D Gaussian smoothing kernel 
% with the standard deviation of 16. Therefore, the gaussian filter
% resembles a low pass filter and can be used to blur pictures.
%%
% c) Using high pass filter, because it increases the edge content in an
% image, which in return identifies a coin. 

% d)
y = imread('coins.png');
figure();
imagesc(y)
colormap('gray')
title('Image2 Before Filtering')
h = [-1, -1, -1; -1, 8, -1; -1, -1, -1];
y2 = conv2(double(h), double(y(:,:,1)));
figure();
imagesc(y2)
colormap('gray')
title('Image2 After Filtering')
% h is a high pass filter. By applying the high pass filter, we shows the
% deges in the picture and elinimates other effects.
%% 4. Multi-rate DSP
% 1
[audio, Fs] = audioread('Radiohead_chopped.wav');
% sound(audio, Fs)
N = length(audio);

audio_fft = fft(audio);
audio_fftshift = fftshift(audio_fft);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;
Freq = Fs*w/(2*pi);

figure();
plot(Freq, mag2db(abs(audio_fftshift)));
xlabel('Frequency(Hz)');
ylabel('Magnitude');
title('Magnitude Response of the audio');
grid on;

% 2
N= length(audio);
n = -N/2:1:N/2-1;
wc = pi/3;
hl = wc./pi.*sinc(wc./pi.*n);
HL = fft(hl);
Hwl = fftshift(HL);
w = fftshift((0:length(n)-1)/length(n)*2*pi);
w(1:length(n)/2) = w(1:length(n)/2) - 2*pi;


figure();
subplot(2,1,1);
plot(w, abs(Hwl));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response for LPF');
grid on;

subplot(2,1,2);
plot(w, angle(Hwl));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response for LPF');
grid on;

% 3
%LPF = zeros(length(audio),1);
%for i = round(length(audio)/4) : round(length(Freq)*3/4)
%    LPF(i) = 1;
%end

audioLPF = audio_fftshift(:,1).*(Hwl.');
audiodownsamples = real(ifft(ifftshift(audioLPF)));

figure();
plot(Freq, mag2db(abs(audioLPF)));
xlabel('Frequency(Hz)');
ylabel('Magnitude');
title('Magnitude Response of the filtered audio');
grid on;

% down sampling
D = 3;
audiodown = downsample(audiodownsamples, D);
N = length(audiodown);
audiodown_fft = fft(audiodown);
audiodown_fftshift = fftshift(audiodown_fft);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;
Freq = 1/D*Fs*w/(2*pi);

figure();
plot(Freq, mag2db(abs(audiodown_fftshift)));
xlabel('Frequency(Hz)');
ylabel('Magnitude');
title('Magnitude Response of the downsampled audio');
grid on;

% 4
U = 3;
audioup = upsample(audiodown, U);
N = length(audioup);
audioup_fft = fft(audioup);
audioup_fftshift = fftshift(audioup_fft);
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;
Freq = U/D*Fs*w/(2*pi);

figure();
plot(Freq, mag2db(abs(audioup_fftshift)));
xlabel('Frequency(Hz)');
ylabel('Magnitude');
title('Magnitude Response of the upsampled audio before filtering');
grid on;

Hwl = [Hwl 0];
audioupLPF2 = audioup_fftshift(:,1).*(Hwl.');

N = length(audio)+1;
w = fftshift((0:N-1)/N*2*pi);
w(1:N/2) = w(1:N/2) - 2*pi;
Freq = Fs*w/(2*pi);

figure();
plot(Freq, mag2db(abs(audioupLPF2)));
xlabel('Frequency(Hz)');
ylabel('Magnitude');
title('Magnitude Response of the upsampled audio after filtering');
grid on;

%% 5. Spectrograms and chirps
% a) 8192*pi = inst = 4000t, t = 6.43s
% Therefore, the aliasing appears at 6.43s
% At aliasing, the sound is distorted and does not sound smoothly.

load('waveform1.mat')
Fs = 8192;
sound(sig, Fs)

N = 500;
w_function = hamming(500);

[s, w, t] = spectrogram(sig, w_function ,250, 512);
figure()
imagesc(t,w,log(abs(s)));
xlabel('Time Block')
ylabel('Frequency')

% c) There is a zig-zag. It represents the pitch of the signal. When listen
% to the signal, the pitch first decreases and then increases and then
% decreases again. Then after a short time of increases in pitch, the
% signal ends. Therefore, the zig-zag shape represents the pithch that I
% heard by playing the siganl.