%% 1.1 Compute the ourput sequence
% y[n] = a*y[n-1] + b*x[n-1], a = 0.5, b=0.5
% y[n] = 0.5y[n-1] + 0.5x([n-1]
% Y(z) = 0.5z^(-1)Y(z) + 0.5z^(-1)X(z)
% H(z) = Y(z)/X(z) = 0.5z^(-1)/(1-0.5z^(-1))
n = 0:1:16;
w = pi/2;
Hw = 0.5*exp(-1j*w)/(1-0.5*exp(-1j*w));
y1 = abs(Hw)*3*cos(pi*n/2 + angle(Hw));

w = pi/4;
Hw = 0.5*exp(-1j*w)/(1-0.5*exp(-1j*w)); 
y2 = abs(Hw)*3*sin(pi*n/4 + angle(Hw));

%% 1.2
figure()
subplot(211)
plot(n,y1)
xlabel('n')
ylabel('y1')
title('y1[n]=3cos(pi*n/2 -pi)')
subplot(212)
plot(n,y2)
xlabel('n')
ylabel('y2')
title('y2[n]=3sin(pi*n/4 -pi/2)')

%% 1.3 Obtain y[n] using filter function
% H(z) = Y(z)/X(z) = 0.5z^(-1)/(1-0.5z^(-1))
n = 0:1:16;
b = [0, 0.5];
a = [1, -0.5];
x1 = 3*cos(pi/2*n);
x2 = 3*sin(pi/4*n);
y1 = filter(b,a,x1);
y2 = filter(b,a,x2);
figure()
subplot(211)
plot(n,y1)
xlabel('n')
ylabel('y1')
title('y1[n]=3cos(pi*n/2 -pi)')
subplot(212)
plot(n,y2)
xlabel('n')
ylabel('y2')
title('y2[n]=3sin(pi*n/4 -pi/2)')


%% 1.4 Plot using freqz()
b = [0, 0.5];
a = [1, -0.5];
N=8;
[hh,ff] = freqz(b,a,N);

figure();
subplot(1,2,1);
plot(ff,abs(hh));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response');
grid on;

subplot(1,2,2);
plot(ff,phase(hh));
xlabel('Little Omega');
ylabel('Phase');
title('Phase Response');
grid on;

%% 1.5-1 a=0.8, b =0.2
% y[n] = a*y[n-1] + b*x[n-1], a = 0.8, b=0.2
% y[n] = 0.8y[n-1] + 0.2x([n-1]
% Y(z) = 0.8z^(-1)Y(z) + 0.2z^(-1)X(z)
% H(z) = Y(z)/X(z) = 0.2z^(-1)/(1-0.8z^(-1))
% Hd(w) = 0.2exp(-jw)/(1-0.8exp(-jw))
n = 0:1:16;
w = pi/2;
Hw = 0.2*exp(-1j*w)/(1-0.8*exp(-1j*w));
y1 = abs(Hw)*3*cos(pi*n/2 + angle(Hw));

w = pi/4;
Hw = 0.2*exp(-1j*w)/(1-0.8*exp(-1j*w)); 
y2 = abs(Hw)*3*sin(pi*n/4 + angle(Hw));


%% 1.5-2 a=0.8, b =0.2
figure()
subplot(211)
plot(n,y1)
xlabel('n')
ylabel('y1')
title('y1[n]=3cos(pi*n/2 -pi)')
subplot(212)
plot(n,y2)
xlabel('n')
ylabel('y2')
title('y2[n]=3sin(pi*n/4 -pi/2)')

%% 1.5-3 a=0.8, b =0.2
n = 0:1:16;
b = [0, 0.2];
a = [1, -0.8];
x1 = 3*cos(pi/2*n);
x2 = 3*sin(pi/4*n);
y1 = filter(b,a,x1);
y2 = filter(b,a,x2);
figure()
subplot(211)
plot(n,y1)
xlabel('n')
ylabel('y1')
title('y1[n]=3cos(pi*n/2 -pi)')
subplot(212)
plot(n,y2)
xlabel('n')
ylabel('y2')
title('y2[n]=3sin(pi*n/4 -pi/2)')

%% 1.5-4 a=0.8, b =0.2
b = [0, 0.2];
a = [1, -0.8];
N=8;
[hh,ff] = freqz(b,a,N);

figure();
subplot(1,2,1);
plot(ff,abs(hh));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response');
grid on;

subplot(1,2,2);
plot(ff,phase(hh));
xlabel('Little Omega');
ylabel('Phase');
title('Phase Response');
grid on;

%% 2.1 Compute Z-transform by hand
% H(z) = 1 - 2z^-1 + 3z^-2 -4z^-3
%      + 4z^-5 -3z^-6 + 2z^-7 - z^-8

%% 2.2 Evaluate result in (1)
w = linspace(-pi,pi,1000);
Hw = 1 - 2*exp(-1j*w) + 3*exp(-2j*w) -4*exp(-3j*w) + 4*exp(-5j*w) -3*exp(-6j*w) + 2*exp(-7j*w) - exp(-8j*w);

%% 2.3 Plot result in (2)
w = linspace(-pi,pi,1000);
Hw = 1 - 2*exp(-1j*w) + 3*exp(-2j*w) -4*exp(-3j*w) + 4*exp(-5j*w) -3*exp(-6j*w) + 2*exp(-7j*w) - exp(-8j*w);

figure();
subplot(1,2,1);
plot(w,abs(Hw));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response');
grid on;

subplot(1,2,2);
plot(w,angle(Hw));
xlabel('Little Omega');
ylabel('Phase');
title('Phase Response');
grid on;


%% 2.4 Plot result in (3) using freqz()
b = [1, -2, 3, -4, 0, 4, -3, 2, -1];
a = [1];
N=500;
[hh,ff] = freqz(b,a,N);

figure();
subplot(1,2,1);
plot(ff,abs(hh));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response');
grid on;

subplot(1,2,2);
plot(ff,phase(hh));
xlabel('Little Omega');
ylabel('Phase');
title('Phase Response');
grid on;

%% 3.1 Plot DTFT
% y[n] = 0.8y[n-1] + 0.2x[n]
% Y(z) = 0.8z^(-1)Y(z) + 0.2X(z)
% H(z) = Y(z)/X(z) = 0.2/(1-0.8z^(-1))

b = [0.2];
a = [1, -0.8];
N=8;
[hh,ff] = freqz(b,a,N);

figure();
subplot(1,2,1);
plot(ff,abs(hh));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response');
grid on;

subplot(1,2,2);
plot(ff,phase(hh));
xlabel('Little Omega');
ylabel('Phase');
title('Phase Response');
grid on;

%% 3.2
% H(z) = Y(z)/X(z) = 0.2/(1-0.8z^(-1))
% Hw = 0.2/(1-0.8*exp(-1j*w))
w = linspace(0,pi/5,1000);
Hw = 0.2./(1-0.8*exp(-1j*w));

figure();
subplot(1,2,1);
plot(w,abs(Hw));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response');
grid on;

subplot(1,2,2);
plot(w,angle(Hw));
xlabel('Little Omega');
ylabel('Phase');
title('Phase Response');
grid on;
%% 3.3
% N = 10 * Fs = 1000
B = 10;
Fs = 100;
N = 1000;
n = 0:1:1000;
x = cos((pi*B/100/1000)*n.^2);
figure()
plot(n, x)
%% 3.4
y = filter(b, a, x);
figure()
plot(n,y)
%% 3.5
w = linspace(0,pi/5,1000);
Hw = 0.2./(1-0.8*exp(-1j*w));

figure();
plot(abs(Hw));
xlabel('Little Omega');
ylabel('Magnitude');
title('Magnitude Response');
grid on;
hold on

y = filter(b, a, x);
plot(n,y)
%% 4.1 Plot the forward system
% y[n] = x[n] + 0.1x[n-5]
% Y(z) = X(z) + 0.1*Z^(-5)X(z)t_samp = 1/8192; %sampling period

% H(z) = 1 + 0.1*Z(-5)
b1 = [1, 0, 0, 0, 0, 0.1];
a1 = [1];
N = 20;

figure;
impz(b1, a1, N);
figure;
freqz(b1, a1, N);

%% 4.2 Plot thre inverse system
% H^(-1)(z) = 1/(1+0.1*Z(-5))
b2 = [1];
a2 = [1, 0, 0, 0, 0, 0.1];
N = 20;

figure;
impz(b2, a2, N);
figure;
freqz(b2, a2, N);

%% 4.3 
x = zeros(1,51);
for n = 0:50delta = zeros(1, length(n));
delta(N/2) = 1;
    sum = 0;
    for k = 1:10
        sum = sum + 1/k * sin(0.01*k^2*pi*n);
    end
    x(n+1) = sum;
end
n = 0:50;
figure()
plot(n, x)

%% 4.4
v = filter(b1,a1,x);
%% 4.5
y = filter(b2,a2,x);
%% 4.6
x = zeros(1,51);
for n = 0:50
    sum = 0;
    for k = 1:10
        sum = sum + 1/k * sin(0.01*k^2*pi*n);
    end
    x(n+1) = sum;
end
n = 0:50;
plot(n, x)

v = filter(b1,a1,x);

y = filter(b2,a2,x);

figure;
subplot(311);
plot(n,x)
xlabel('n')
ylabel('x')
subplot(312);
plot(n,v)
xlabel('n')
ylabel('v')
subplot(313);
plot(n,y)
xlabel('n')
ylabel('y')
% three plots are the same/similar


%% 5.1 Plot x[n]
t_init = 0; % start time in seconds
t_end = 1;%end time in seconds
t_samp = 1/8192; %sampling period

t_vect = t_init:t_samp:t_end; %obtain the time vector

xt = sin(2*pi*3000*t_vect + 0.5*2000*t_vect.^2);
figure();
plot(t_vect,xt);
title('Sampling at 8192 Hz');
xlabel('Time in s');
ylabel('Amplitude')

%% 5.2
soundsc(xt)

%% 5.3
% x[n] = x(nT)
n = 0:1:8192;
T = 1/8192;
xn = sin(2*pi*3000*n*T + 0.5*2000*(n*T).^2);
figure()
plot(n,xn)
%% 5.4
t = (8192-6000)/2000*pi

%% 5.5
% one second after aliasing which is n = (3.5*10^4)
n = 0:1:(t+1)*8192;
T = 1/(8192);
xn = sin(2*pi*3000*n*T + 0.5*2000*(n*T).^2);
figure()
plot(n,xn)
soundsc(xn)
