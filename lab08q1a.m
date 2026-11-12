%%EEET 425 LAB 08 Q1

ws1 = 0.3*pi; %lower stopband edge
wp1 = 0.4*pi; %lower passband edge
wp2 = 0.5*pi; %upper passband edge
ws2 = 0.6*pi; %upper stopband edge

dw = wp1 - ws1; %transition width
M = ceil(6.6*pi / dw); %part a filter length

if mod(M, 2) == 0
    M = M + 1; %make M odd
end

n = 0:M-1; %time index
wc1 = (ws1 + wp1) / 2; %lower cutoff, middle of the transition band
wc2 = (wp2 + ws2) / 2; %upper cutoff, middle of the transition band
hd = ideal_lp(wc2, M) - ideal_lp(wc1, M); %part b ideal bandpass filter

w_ham = hamming(M)'; %part c hamming window as a row vector

h = w_ham .* hd; %part d windowed bandpass filter

[H, w] = freqz(h, 1, 8192); %frequency response

magdB = 20 * log10(abs(H) + eps); %magnitude in dB
pb = (w >= wp1) & (w <= wp2); %passband indices
sb = (w <= ws1) | (w >= ws2); %stopband indices
Rp = max(magdB(pb)) - min(magdB(pb)) %part e passband ripple in dB
As = -max(magdB(sb)) %part e stopband attenuation in dB

figure;
stem(n, hd, 'filled'); %part f ideal bandpass impulse response
title('Ideal Bandpass Impulse Response'); xlabel('n'); ylabel('h_d[n]');

figure;
stem(n, w_ham, 'filled'); %part g hamming window
title('Hamming Window'); xlabel('n'); ylabel('w[n]');

figure;
subplot(2, 1, 1);
stem(n, h, 'filled'); %part h designed filter impulse response
title('Designed Filter Impulse Response'); xlabel('n'); ylabel('h[n]');

subplot(2, 1, 2);
plot(w/pi, magdB); %part h magnitude response in dB
title('Magnitude Response'); xlabel('\omega/\pi'); ylabel('|H(\omega)| (dB)');
axis([0 1 -120 10]); grid on;