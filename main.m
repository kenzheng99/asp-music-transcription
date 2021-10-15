% input parameters
data_path = 'audio/';
file = '1';
instrument = 'synth';
noise_power = 0.001;
onset_window_length = 2000;
onset_threshold = 1;

% load signal
tempo = 120;
[x, fs] = audioread([data_path file '_' instrument '.wav']);
x = x(:,1);
noise = noise_power * randn(size(x));
x = x + noise;
SNR = snr(x, noise);
fprintf("input params: \n\tfile: %s \n\tinst: %s \n\tsnr:  %.02fdB\n", file, instrument, SNR); 
soundsc(x, fs);

% perform transcription
[onsets, offsets] = detect_onsets(x, fs, onset_window_length, onset_threshold, true);
notes = detect_notes(x, fs, onsets, offsets);

% evaluate performance
pred_nmat = notes2nmat(notes, fs, tempo);
ref_nmat = readmidi([data_path '1_midi.mid']);
ref_nmat = shift(ref_nmat, 'onset', -1);

pianoroll(pred_nmat);
pianoroll(shift(ref_nmat, 'pitch', 1), 'b', 'hold');

% output MIDI file
writemidi(pred_nmat, 'out.mid', 120);