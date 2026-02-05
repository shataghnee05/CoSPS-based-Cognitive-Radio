clc;
clear all;
close all;

addpath(genpath('src'));

% ==== Input Parameters ==== %
N = 4096;         % Number of samples
fs = 1e6;         % Sampling Frequency
SU_count = 4;     % Number of Secondary Users
PS = 5;           % Number of parallel streams
r = 60;           %Sidelobe attenuation for Chebyshev Window
SU_demand = [];
for i = 1:SU_count
    SU_demand(i) = input("Enter the demand: ");
end
cap = 6;          %Guard Band(kHz);
% ==== Secondary Users Side(SU) ==== %
SU_data = cell(1,SU_count);
for i = 1:SU_count
    [coset,true_freq] = preprocessing(N,fs,PS);
    SU_data{i} = cosps_main_algorithm(coset,r,PS,i);
    SU_data{i}.true_freq = true_freq;
end
% ==== Network Coordinator Side(NC) ==== %
k_sel = 4;
[detected_freq,NC_table] = nc_fusion_center(SU_data,k_sel,fs);
disp(detected_freq/1e3);
% ==== Free Band Detection ==== %
freq_space = 1e3;
free_bands = free_band_detector(detected_freq,fs,freq_space);
disp("Free Bands Available: ");
disp(free_bands);
% ==== Bandwidth Allocation ==== %
if length(SU_demand) ~= SU_count
    error('Demand Vector Length must match number of SU');
end
allocation_table = demand_aware_allocation( ...
    free_bands, SU_demand, cap);

if isempty(allocation_table)
    disp('No spectrum could be allocated.');
else
    disp('Demand-Aware Round Robin Allocation:');
    disp(array2table(allocation_table, ...
        'VariableNames', {'SU_ID','Start_kHz','End_kHz','Allocated_kHz'}));
end
