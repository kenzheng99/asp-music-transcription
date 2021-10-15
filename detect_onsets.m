function [onsets, offsets] = detect_onsets(x, fs, N, clip_thresh, plot_signal)
    x = [zeros(N/2, 1); x];
    L = length(x);
    frames = buffer(x.^2, N, N/2);
    for i = 1:size(frames, 2)
        frames(:, i) = frames(:,i) .* hann(N);
    end
    E_n = sum(frames);
    E_n = log(E_n);
    diffs = diff(E_n);
    clipped = zeros(size(diffs));
    i1 = diffs > clip_thresh;
    i2 = diffs < - 0.5 * clip_thresh;
    clipped(i1) = diffs(i1) - clip_thresh;
    clipped(i2) = diffs(i2) + 0.5 * clip_thresh;

    [~, locs] = findpeaks(clipped);
    locs = locs * N/2;
    locs = locs - N/2 + 1;
    onsets = locs;
    [~, locs] = findpeaks(-clipped);
    locs = locs * N/2;
    locs = locs - N/2 + 1;
    offsets = locs;
    
    length_diff = length(onsets) - length(offsets);
    offsets = [offsets (zeros(1, length_diff) + L - N/2)];
    
    if (plot_signal)
        figure;
        subplot(6,1,1);
        plot(x);
        subplot(6,1,2);
        plot(E_n);
        subplot(6,1,3);
        plot(diffs);
        subplot(6,1,4);
        plot(clipped);
        subplot(6,1,5);
        out = zeros(size(x));
        out(onsets) = 1;
        plot(out);
        subplot(6,1,6);
        out = zeros(size(x));
        out(offsets) = 1;
        plot(out);
    end
end