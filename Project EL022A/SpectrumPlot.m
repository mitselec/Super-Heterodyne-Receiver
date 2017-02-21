function SpectrumPlot(y) %Plots out the filter respose
Fs=6E6;                                     %Sampling Frequency
N = length(y);                              %Signal Length
spectrum_magnitude = 20*log10(abs(fft(y))); %FFT Implementation
freq_ax_bins = (0:N-1);                     %Frequency axis in bins
freq_ax_Hz = freq_ax_bins*Fs/N;             %Frequency axis in Hz
N_2=ceil(N/2);                              %Nyquist Rate

%Amplitude plotting
plot(freq_ax_Hz(1:N_2),spectrum_magnitude(1:N_2));
title('Amplitude Response');
xlabel('Frequency [Hz]');
ylabel('Amplitude [dB]');

end