% parameters:
%   notes: vector of [onset, duration, midi_note] values
% returns:
%   a miditoolbox notematrix
function nmat = notes2nmat(notes, fs, tempo)
    nmat = [];
    for i = 1:size(notes, 1)
        onset = notes(i, 1) / fs;
        onset_beats = (onset * tempo / 60);
        duration = notes(i, 2) / fs;
        duration_beats = duration * tempo / 60;
        midi_note = notes(i, 3);
        note_nmat = createnmat(midi_note);
        note_nmat = setvalues(note_nmat, 'onset', onset_beats);
        note_nmat = setvalues(note_nmat, 'dur', duration_beats);
        nmat = [nmat; note_nmat];
    end
    nmat = settempo(nmat, 120);
end