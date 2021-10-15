# Automatic Music Transcription System
This is a simple music transcription system I designed, which takes in a `.wav`
audio file as input and returns a transcription in MIDI format. Essentially, I
use the 1st difference of the short term energy of a signal (with some extra
tricks) to perform note onset/offset detection, and a combination of
autocorrelation and FFT to detect pitch. For the full report describing my
methods and results, see [report.pdf](report.pdf).

This project was done for the EN.520.445 Audio Signal Processing course I took at
Johns Hopkins during Fall 2020.

## Installation and Usage
- clone this repository
- run `git submodule init && git submodule update` to download `miditoolbox`
- open MATLAB and add `/miditoolbox` to the MATLAB path
- set input directory and filename in `main.m`, and run it!
