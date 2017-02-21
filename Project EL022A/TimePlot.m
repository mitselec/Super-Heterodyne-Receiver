function TimePlot(y) %Plots out the time spectrum
Fs=6E6;                 %Sampling Frequency
N = length(y);          %Signal Length
sp=1/Fs;                %Sampling Period
t = linspace(0,sp*N,N); %Signal duration

%Amplitude plotting
plot(t,y);
xlabel('Time [s]');
ylabel('Voltage [V]');

end