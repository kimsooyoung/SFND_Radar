% Using the following MATLAB code sample, 
% complete the TODOs to calculate the range in meters of four targets 
% with respective measured beat frequencies [0 MHz, 1.1 MHz, 13 MHz, 24 MHz].
% 
% You can use the following parameter values:
% 
% The radar maximum range = 300m
% The range resolution = 1m
% The speed of light c = 3*10^8


c = 3 * 10 ^ 8;

% TODO : Find the Bsweep of chirp for 1 m resolution
% time of each Chrip
r = 1;
Bsweep = c / 2 * r;


% TODO : Calculate the chirp time based on the Radar's Max Range
C_t = 5.5 * (2 * 300 / c);

% TODO : define the frequency shifts 
freqs = [ 0 1.1e6 13e6 24e6 ];
calculated_range = c * C_t * freqs / ( 2 * Bsweep );


% Display the calculated range
% Unit: meter(m)
disp(calculated_range);