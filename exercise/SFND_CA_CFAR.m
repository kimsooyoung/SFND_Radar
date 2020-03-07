% Implement 1D CFAR using lagging cells on the given noise and target scenario.

% Close and delete all currently open figures
close all;

% Data_points
Ns = 1000;

% Generate random noise
s=abs(randn(Ns,1));
% s=(randn(Ns,1));

%Targets location. Assigning bin 100, 200, 300 and 700 as Targets with the amplitudes of 8, 9, 4, 11.
s([100 ,200, 300, 700])=[8 9 4 11];

%plot the output
plot(s);

% TODO: Apply CFAR to detect the targets by filtering the noise.

% 1. Define the following:
% 1a. Training Cells
% 1b. Guard Cells 

T = 10;
G = 1;

% Offset : Adding room above noise threshold for desired SNR 
% multiply the offset to threshold value -> Since working with linear
% values... why??

offset=5;

% Vector to hold threshold values 
threshold_cfar = [];

%Vector to hold final signal after thresholding
signal_cfar = [];

% 2. Slide window across the signal length
for i = 1:(Ns-(G+T+1))     

    % 2. - 5. Determine the noise threshold by measuring it within the training cells
    noise_level = sum(s(i:i+T-1));
    
    th = (noise_level/T)*offset;
    threshold_cfar = [ threshold_cfar, {th} ];
    
    signal = s(i+T+G);
    
    if (signal < th)
        signal= 0;
    end

    % 6. Measuring the signal within the CUT

    % 8. Filter the signal above the threshold

    signal_cfar = [signal_cfar, {signal}];
end




% plot the filtered signal
plot (cell2mat(signal_cfar),'g--');

% plot original sig, threshold and filtered signal within the same figure.
figure,plot(s);
hold on,plot(cell2mat(circshift(threshold_cfar,G)),'r--','LineWidth',2)
hold on, plot (cell2mat(circshift(signal_cfar,(T+G))),'g--','LineWidth',4);
legend('Signal','CFAR Threshold','detection')