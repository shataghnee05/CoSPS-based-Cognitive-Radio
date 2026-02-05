% === Core Algorithm Main Function === %
function SU_packet = cosps_main_algorithm(coset,r,PS,su)
[IMP_coset,IMP_vector] = imp(coset,PS);
windowed_signal = window_func(IMP_coset,r);
[spec_avg,active_bins,min_len] = sparse_fft(windowed_signal,PS);
SU_packet = struct(...
    'SU_ID',su,...
    'bucket_index',active_bins,...
    'magnitude',spec_avg(active_bins),...
    'IMP_vector',IMP_vector,...
    'PS',PS,...
    'min_len',min_len...
    );
end

% === Invertible Modulo Permutation === %
function [IMP_coset, IMP_val] = imp(coset,PS)
sigma = [1 3 5 7 9 11 13];
IMP_val = sigma(randperm(length(sigma),PS));
IMP_coset = cell(1,PS);
for k = 1:PS
    n = 0:length(coset{k})-1;
    idx = mod(IMP_val(k)*n,length(coset{k}))+1;
    IMP_coset{k} = coset{k}(idx);
end
end

% === Dolph-Chebyshev Window Function === %
function windowed_signal = window_func(IMP_coset,r)
l = length(IMP_coset);
windowed_signal = cell(1,l);
for p = 1:l
    L = length(IMP_coset{p});
    windowed_signal{p} = IMP_coset{p}.*chebwin(L,r).';
end
end

% === Sparse FFT Processing === %
function [spec_avg, active_bins, min_len] = sparse_fft(windowed_signal,PS)
min_len = min(cellfun(@length,windowed_signal));
fft_len = floor(min_len/2)+1;
spec_avg = zeros(1,fft_len);
for i = 1:PS
    X = fft(windowed_signal{i}(1:min_len),min_len);
    spec_avg = spec_avg + abs(X(1:fft_len));
end
spec_avg = spec_avg/PS;
threshold = 0.5*max(spec_avg);
active_bins = find(spec_avg>threshold);
end