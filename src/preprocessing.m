function [coset,f_bands] = preprocessing(N,fs,PS,channelType,SNR)
t = (0:N-1)/fs;
k = randi([3 6]); % No. of Active Bands
f_bands = sort(1e3*rand(1,k));
amp = 0.8 + 0.4*rand(1,k);          % Amplitude
% <<< Sparse Signal Generation >>> %
sparse_signal = zeros(1,N);
for i = 1:length(f_bands)
    sparse_signal = sparse_signal + amp(i) * cos(2*pi*f_bands(i)*t);

end

% <<< Wireless Channel Selection >>> %
switch channelType
    case "Ideal"
        rx_signal = sparse_signal;
    case "AWGN"
        rx_signal = awgn(sparse_signal,SNR,"measured");
    case "Rayleigh"
        rayChan = comm.RayleighChannel(...
            'SampleRate',fs,'PathDelays',0,...
            'AveragePathGains',0);
        rx_signal = rayChan(sparse_signal.');
        rx_signal = rx_signal.';
        rx_signal = awgn(rx_signal,SNR,"measured");
% <<< Multi-Coset Sampling >>> %
coset = cell(1,PS);
for j = 1:PS
    coset{j} = rx_signal(j:PS:end);
end
end
