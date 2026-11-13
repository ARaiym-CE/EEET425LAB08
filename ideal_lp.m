function hd = ideal_lp(wc, M)

% Ideal lowpass filter
% --------------------------------------------------------
% hd = ideal_lp(wc, M)
% hd = ideal impulse response with index between 0 to M-1
% wc = cutoff frequency in radian
%  M = length of the ideal lowpass filter
% --------------------------------------------------------

alpha = (M-1)/2;
n = 0:(M-1);
m = n - alpha;

fc = wc/pi;
hd = fc.*sinc(fc*m);

