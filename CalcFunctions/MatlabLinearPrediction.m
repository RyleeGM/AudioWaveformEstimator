function [FilterSignal,FilterSignalFFT] = MatlabLinearPrediction(NoiseySignal,p)

    b = lpc(NoiseySignal,p);
    FilterSignal = filter([0 -b(2:end)],1,NoiseySignal); 
    
    FilterSignalFFT = abs(fftshift(fft(FilterSignal)));
    FilterSignalFFT = FilterSignalFFT(round(length(FilterSignalFFT)/2):round(length(FilterSignalFFT)));

end

