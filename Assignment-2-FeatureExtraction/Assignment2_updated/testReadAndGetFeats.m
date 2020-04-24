clear;

[Y, FS] = audioread('Songs/melody_1.wav');

frIseqT = GetMusicFeatures(Y,FS,0.03);