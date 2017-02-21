%% Project on Digital Filter Design %%
%====== Mid Sweden University ========
%=== Author :Dimopoulos Dimitirios ===
%======== Fall Semester 2016 =========


%% Clearing Everything Before Initialization
clear;
close all;
clc;

%Creating a figure that will host all the plots
figure('Name','EL022A Project Plots')
subplot(2,3,1)
imshow('logo.jpg')

%% File Loading Script
% Here the user shall be given the choice to
% load one of the two different files given

radio_file = menu('Choose the radio signal you want to load','radioA','radioB');
if radio_file == 1
    load('radioA.mat');
end
if radio_file == 2
    load('radioB.mat');
end



subplot(2,3,2)
TimePlot(radio);    %Plotting Time Spectrum Of Input
title('Raw Radio Input');

%% Amplification
radio = 3*radio; %Simple Amplification

%% Spectrum analysing script
subplot(2,3,3)
SpectrumPlot(radio); %Plotting the Frequency Response of the Input
title('Input Radio Frequency Spectrum');

%% Mixer modeling

%       Local Oscillator Parameters
%-----------------------------------------------

%Setting the Frequency of the Oscillator in Hz
freq_option = menu('Choose the channel you want to hear','Channel 1','Channel 2','Channel 3');
if freq_option == 1
    sigF1 =550000; % First channel sinewave (550kHz)
end
if freq_option == 2
    sigF1 =750000; % Second channel sinewave (750kHz)
end
if freq_option == 3
    sigF1 =950000; % Third channel sinewave (950kHz)
end

Fs = 6E6;                  % 6 MHz of sampling frequency
sigA1 = 1;                 % Amplitude of Local Osc Signal
nos = length(radio);       % Number of Samples used for simulation
sp = 1/Fs;                 % Sampling period
t = linspace(0,sp*nos,nos);% Signal duration
 
osc_signal = sigA1*sin(2*pi*sigF1*t); % Creation of sine wave
mix_out = osc_signal.*radio;          % Element-wise multiplication

subplot(2,3,4)
SpectrumPlot(mix_out); %Plotting the Frequency Response of the Modulated Signal
title('Modulated Radio Frequency Spectrum');

%% Intermediate Frequency Filtering
%Implement a band pass filter

load('BandPassIF.mat');                     %Loading the filter parameters
IF_signal = filterIIR2t(mix_out,Num,Den);   %Applying the filter on the signal

subplot(2,3,5)
SpectrumPlot(IF_signal); %Plotting the Frequency Response of the IF BPF
title('Bandpass Filtered Frequency Spectrum');


%% Demodulation
load('LowPass2.mat');               %Load LPF Parameters
Abs_IF = abs(IF_signal);            %Implement peak detection
lf = filterIIR2t(Abs_IF,Num2,Den2); %Low pass filtering

subplot(2,3,6)
TimePlot(lf);                       %Plotting Time Spectrum
title('Low Pass Filtered Output');

%% Resampling and result

sf = resample(lf,44100,Fs)'; % Resampling our result to 44.1kHz 
sf = sf - mean(sf);          %Removing the mean value
P =  audioplayer(sf, 44100); 
%play(P);                    %Play the resulting audio clip

%Depending on the channel, we save the result to a different file
if freq_option == 1
    audiowrite('decoded1.wav',sf,44100);
end
if freq_option == 2
    audiowrite('decoded2.wav',sf,44100);
end
if freq_option == 3
    audiowrite('decoded3.wav',sf,44100);
end

%% Ending of the project

%Thank you for your time!
%The end
