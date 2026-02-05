function [coset,f_bands] = preprocessing(N,fs,PS)
t = (0:N-1)/fs;
k = randi([3 6]); % No. of Active Bands
f_bands = sort(1e3*rand(1,k));
amp = 5;          % Amplitude
% <<< Sparse Signal Generation >>> %
sparse_signal = zeros(1,N);
for i = 1:length(f_bands)
    sparse_signal = sparse_signal + amp * cos(2*pi*f_bands(i)*t);

end
% <<< Multi-Coset Sampling >>> %
coset = cell(1,PS);
for j = 1:PS
    coset{j} = sparse_signal(j:PS:end);
end
end
