%%EEET 425 LAB 08 q3a

ws1 = 0.3*pi; %q1 lower stopband edge
wp1 = 0.4*pi; %q1 lower passband edge
wp2 = 0.5*pi; %q1 upper passband edge
ws2 = 0.6*pi; %q1 upper stopband edge

M1 = 67; %q1 filter length from part 1

n1 = 0:M1-1; %q1 time index
wc1 = (ws1 + wp1) / 2; %q1 lower cutoff
wc2 = (wp2 + ws2) / 2; %q1 upper cutoff
hd1 = ideal_lp(wc2, M1) - ideal_lp(wc1, M1); %q1 ideal bandpass filter
h1 = hamming(M1)' .* hd1; %q1 my hamming filter
h1_fir = fir1(M1-1, [wc1 wc2]/pi, 'bandpass', hamming(M1)); %q1 fir1 filter, order is M-1
[H1, w] = freqz(h1, 1, 8192); %q1 my frequency response
[H1f, w] = freqz(h1_fir, 1, 8192); %q1 fir1 frequency response
mag1 = 20 * log10(abs(H1) + eps); %q1 my magnitude in dB
mag1f = 20 * log10(abs(H1f) + eps); %q1 fir1 magnitude in dB
pb = (w >= wp1) & (w <= wp2); %q1 passband indices
sb = (w <= ws1) | (w >= ws2); %q1 stopband indices

Rp1 = max(mag1(pb)) - min(mag1(pb)) %q1 my passband ripple
As1 = -max(mag1(sb)) %q1 my stopband attenuation
Rp1f = max(mag1f(pb)) - min(mag1f(pb)) %q1 fir1 passband ripple
As1f = -max(mag1f(sb)) %q1 fir1 stopband attenuation
diff1 = max(abs(h1 - h1_fir)) %q1 largest difference between the two impulse responses

figure;
subplot(2, 1, 1);
stem(n1, h1_fir, 'filled'); %q1 fir1 impulse response
title('Q1 fir1 Impulse Response'); xlabel('n'); ylabel('h[n]');

subplot(2, 1, 2);
plot(w/pi, mag1, w/pi, mag1f, '--'); %q1 compare both magnitude responses
title('Q1 Magnitude Response'); xlabel('\omega/\pi'); ylabel('|H(\omega)| (dB)');

ws1 = 0.25*pi; %q2 lower stopband edge
wp1 = 0.35*pi; %q2 lower passband edge
wp2 = 0.65*pi; %q2 upper passband edge
ws2 = 0.75*pi; %q2 upper stopband edge

M2 = 47; %q2 filter length from part 2
beta = 0.5842 * (40.42 - 21)^0.4 + 0.07886 * (40.42 - 21); %q2 kaiser beta for As = 40.42 dB
n2 = 0:M2-1; %q2 time index
wc1 = (ws1 + wp1) / 2; %q2 lower cutoff
wc2 = (wp2 + ws2) / 2; %q2 upper cutoff
hd2 = ideal_lp(wc2, M2) - ideal_lp(wc1, M2); %q2 ideal bandpass filter
h2 = kaiser(M2, beta)' .* hd2; %q2 my kaiser filter
h2_fir = fir1(M2-1, [wc1 wc2]/pi, 'bandpass', kaiser(M2, beta)); %q2 fir1 filter

[H2, w] = freqz(h2, 1, 8192); %q2 my frequency response
[H2f, w] = freqz(h2_fir, 1, 8192); %q2 fir1 frequency response

mag2 = 20 * log10(abs(H2) + eps); %q2 my magnitude in dB
mag2f = 20 * log10(abs(H2f) + eps); %q2 fir1 magnitude in dB
pb = (w >= wp1) & (w <= wp2); %q2 passband indices
sb = (w <= ws1) | (w >= ws2); %q2 stopband indices

Rp2 = max(mag2(pb)) - min(mag2(pb)) %q2 my passband ripple
As2 = -max(mag2(sb)) %q2 my stopband attenuation
Rp2f = max(mag2f(pb)) - min(mag2f(pb)) %q2 fir1 passband ripple
As2f = -max(mag2f(sb)) %q2 fir1 stopband attenuation
diff2 = max(abs(h2 - h2_fir)) %q2 largest difference between the two impulse responses

figure;
subplot(2, 1, 1);
stem(n2, h2_fir, 'filled'); %q2 fir1 impulse response

subplot(2, 1, 2);
plot(w/pi, mag2, w/pi, mag2f, '--'); %q2 compare both magnitude responses
title('Q2 Magnitude Response'); xlabel('\omega/\pi'); ylabel('|H(\omega)| (dB)');
