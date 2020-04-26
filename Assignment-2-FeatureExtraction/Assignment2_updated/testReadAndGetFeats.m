clear;

[Y, FS] = audioread('Songs/melody_1.wav');

%plot(Y) % plots audio waveform

frIseqT = GetMusicFeatures(Y,FS,0.03); % extract all fourier data

%size(frIseqT(1,:));
figure('Name', 'Plots')
subplot(2,2,1)
%plot(normalize(frIseqT(1,:),'range'))
plot(log(frIseqT(1,:)))
title('Frequency')
hold on
frIseqT(1,:);

%figure('Name', 'Correlation')
subplot(2,2,2)
plot(normalize(frIseqT(2,:),'range'))
title('Correlation')

subplot(2,2,3)
%figure('Name', 'Intensity')
plot(normalize(frIseqT(3,:),'range'))
title('Intensity')
hold off
%basing your featureson the logarithm of the pitch track

%distinctsemitones allows devising a discrete representation of the sound, if you like.

%feature extractor where the output remains largely unchanged ifthe entire 
%input is transposed up or down by an arbitrary amount