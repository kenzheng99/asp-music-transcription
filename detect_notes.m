function notes = detect_notes(x, fs, onsets, offsets)
    notes = zeros(length(onsets), 3);
    for i = 1:length(onsets)
        pitch = detect_pitch(x(onsets(i):offsets(i)), fs);
        midi_val = round(hz2midi(pitch));
        notes(i, :) = [onsets(i), offsets(i) - onsets(i), midi_val];
    end
end

