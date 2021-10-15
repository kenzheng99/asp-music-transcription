function p = detect_pitch(x, fs)
    N = length(x);
    ac = xcorr(x);
    ac = ac(1 + N:end);
    [~, locs] = findpeaks(ac);
    candidate_pitches = 1 ./ locs .* fs;

    ft = abs(fft(x));
    clip_idx = ft < max(ft) / 4;
    ft(clip_idx) = 0;
    [~, ft_peaks] = findpeaks(ft);
    if (~isempty(ft_peaks))
        f0_est = ft_peaks(1) * fs / N;
    else
        f0_est = 0;
    end
    [~, closest_loc] = min(abs(candidate_pitches - f0_est));
    p = candidate_pitches(closest_loc);
end
