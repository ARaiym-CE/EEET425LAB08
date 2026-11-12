%%EEET 425 LAB 08 q2a

ws1 = 0.25*pi; %lower stopband edge
wp1 = 0.35*pi; %lower passband edge
wp2 = 0.65*pi; %upper passband edge
ws2 = 0.75*pi; %upper stopband edge
d1 = 0.05; %passband ripple, 0.95 to 1.05
d2 = 0.01; %stopband ripple
Rp_spec = -20 * log10((1 - d1) / (1 + d1)); %part a passband ripple in dB
As_spec = -20 * log10(d2 / (1 + d1)); %part a stopband attenuation in dB
dw = wp1 - ws1; %transition width
M = ceil((As_spec - 7.95) / (2.285 * dw) + 1); %part b window length
if mod(M, 2) == 0
    M = M + 1; %make M odd
end
n = 0:M-1; %time index
if As_spec >= 50
    beta = 0.1102 * (As_spec - 8.7); %part c beta for As >= 50
elseif As_spec > 21
    beta = 0.5842 * (As_spec - 21)^0.4 + 0.07886 * (As_spec - 21); %part c beta for 21 < As < 50
else
    beta = 0; %part c beta for As <= 21
end
wc1 = (ws1 + wp1) / 2; %lower cutoff, middle of the transition band
wc2 = (wp2 + ws2) / 2; %upper cutoff, middle of the transition band
hd = ideal_lp(wc2, M) - ideal_lp(wc1, M); %part d ideal bandpass filter
w_kai = kaiser(M, beta)'; %part e kaiser window as a row vector
h = w_kai .* hd; %part f windowed bandpass filter
[H, w] = freqz(h, 1, 8192); %frequency response
magdB = 20 * log10(abs(H) + eps); %magnitude in dB
pb = (w >= wp1) & (w <= wp2); %passband indices
sb = (w <= ws1) | (w >= ws2); %stopband indices
Rp = max(magdB(pb)) - min(magdB(pb)) %part g passband ripple in dB
As = -max(magdB(sb)) %part g stopband attenuation in dB
figure;
stem(n, hd, 'filled'); %part h ideal bandpass impulse response
title('Ideal Bandpass Impulse Response'); xlabel('n'); ylabel('h_d[n]');
figure;
stem(n, w_kai, 'filled'); %part i kaiser window
title('Kaiser Window'); xlabel('n'); ylabel('w[n]');
figure;
subplot(2, 1, 1);
stem(n, h, 'filled'); %part j designed filter impulse response
title('Designed Filter Impulse Response'); xlabel('n'); ylabel('h[n]');
subplot(2, 1, 2);
plot(w/pi, magdB); %part j magnitude response in dB
title('Magnitude Response'); xlabel('\omega/\pi'); ylabel('|H(\omega)| (dB)');
axis([0 1 -120 10]); grid on;