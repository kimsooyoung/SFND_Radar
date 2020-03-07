%Operating frequency (Hz)
fc = 77.0e9;

%Transmitted power (W)
Pt = 3e-3;

%Antenna Gain (linear)
G =  10000;

%Minimum Detectable Power
Ps = 1e-10;

%RCS of a car
RCS = 100;

%Speed of light
c = 3*10^8;

%TODO: Calculate the wavelength

wavelength = c / fc;
fprintf('%f \n', wavelength);

%TODO : Measure the Maximum Range a Radar can see.
R = nthroot((Pt * power(G, 2) * power(wavelength, 2) * RCS ) / ( Ps * power(4 * pi, 4) ) , 4);
fprintf('%f \n', R );

disp(R);