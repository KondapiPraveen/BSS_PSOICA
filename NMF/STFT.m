%STFT

X = myspectrogram(x,FFTSIZE,fs,hann(WINDOWSIZE),-HOPSIZE, 1);
V = abs(X(1:(FFTSIZE/2+1),:));
F = size(V,1);
T = size(V,2);

imagesc(db(V))
set(gca,'YDir','normal')
set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);
set(gca, 'YTickLabelMode', 'manual', 'YTickLabel', []);
title('Spectrogram of Mary Had a Little Lamb')
ylabel('Frequency')
xlabel('Time')

%sound(x,fs) 