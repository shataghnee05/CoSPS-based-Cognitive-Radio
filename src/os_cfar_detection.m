function [active_bins, thres] = os_cfar_detection(spec_avg)
numTrain = 8;
numGuard = 2;
rank = 12;
alpha = 2.2;

n = length(spec_avg);
thres = zeros(1,n);
detections = false(1,n);
offset = numTrain + numGuard;
for i = offset+1 : n-offset
    left = spec_avg(i-numGuard-numTrain:i-numGuard-1);
    right = spec_avg(i+numGuard+1:i+numGuard+numTrain);
    train = [left right];
    train = sort(train);

    rankIndex = min(rank,length(train));
    noiseEst = train(rankIndex);

    thres(i) = alpha * noiseEst;
    if spec_avg(i) > thres(i)
        detections(i) = true;
    end
end
thres(1:offset) = thres(offset+1);
thres(n-offset+1:n) = thres(n-offset);
active_bins = find(detections);
for i = active_bins(end:-1:1)
    left = max(i-1,1);
    right = min(i+1,n);
    if spec_avg(i) ~= max(spec_avg(left:right))
        detections(i) = false;
    end
end
active_bins = find(detections);
end