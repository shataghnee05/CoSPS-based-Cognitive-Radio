function [detected_freq, NC_table] = nc_fusion_center(SU_data,k,fs)
NC_data = [];
min_len = SU_data{1}.min_len;
SU_count = length(SU_data);
% === K-Max Selector Files === %
for i = 1:SU_count
    bins = SU_data{i}.bucket_index;
    mag = SU_data{i}.magnitude;

    [sorted_mag, idx] = sort(mag,'descend');
    sorted_bins = bins(idx);

    top_bins = sorted_bins(1:min(k,length(sorted_bins)));
    top_mags = sorted_mag(1:min(k,length(sorted_mag)));
    for j = 1:length(top_bins)
        NC_data = [NC_data; [i,top_bins(j),top_mags(j)]];
    end
disp(array2table(NC_data,'VariableNames',{'SU_ID','Bin_Index','Magnitude'}));
end

if isfield(SU_data{1},'min_len')
    min_len = SU_data{1}.min_len;
else
    error('Nfft not found');
end

% === Frequency Mapping === %
resolution = fs/min_len;
bin_index = NC_data(:,2);
freqHz = (bin_index-1)*resolution;
NC_data_frqs = [NC_data,freqHz];
NC_table = NC_data_frqs;
disp(array2table(NC_table, ...
    'VariableNames',{'SU_ID','Bin_Index','Magnitude','Frequency(in Hz)'}));

% === Voting Function === %
[counts, bins] = groupcounts(round(freqHz));
detected_freq = bins(counts >= ceil(SU_count/2));

end
