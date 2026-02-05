function free_bands = free_band_detector(detected_freq,fs,freq_space)
Total_band = [0,fs/2];
if isempty(detected_freq)
    free_bands = Total_band/1e3;
    return;
end
f_sorted = sort(detected_freq(:));
clean_frqs = f_sorted([true; diff(f_sorted)>freq_space]); 
free_bands = []; 
if clean_frqs(1) > Total_band(1) 
    free_bands = [free_bands; [Total_band(1), clean_frqs(1)]]; 
end
for i = 1:length(clean_frqs)-1 
    start = clean_frqs(i); 
    end_gap = clean_frqs(i+1); 
    if end_gap - start > 0 
        free_bands = [free_bands;[start,end_gap]]; 
    end 
end
if clean_frqs(end) < Total_band(2)
    free_bands = [free_bands; [clean_frqs(end), Total_band(2)]];
end
free_bands = free_bands/1e3;
end