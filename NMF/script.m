%% INIT
clear; close all; clc;

% Read in audio file
dir = "../sounds/SingleChannel/";
file = "T1_S0.wav";
%file1 = 'test.wav';
[x fs] = audioread(dir+file);

%% STFT
FFTSIZE = 16384;
HOPSIZE = 8191;
WINDOWSIZE = 16382;

STFT

%% NMF
SOURCES = 2; eps = 1e-4;
K = 6; % number of basis vectors
S=K;
MAXITER = 100; % total number of iterations to run
Stage2 = 0; % Stage 2 of NMF

%% TODO: NMF
[W, H] = nmf(V, K, MAXITER);

%% ISTFT
ISTFT
%% Save the data
st = sprintf("NMF_");
if Stage2
    mid = "";
else
    mid = "_E";
end

fnames = cell(K,1);
filec = char(file);
for i=1:K
    ed = sprintf("%d.wav",i);
    fnames{i} = st+filec(1:end-4)+mid+ed; 
    audiowrite(dir+fnames{i},xhat2(:,i),fs);
end

%% PLOT
PLOT

%%
if Stage2
    clear i xhat1 xhat2
    S=SOURCES;
    Es = [];
    for k=1:K
        [x, fs] = audioread(dir+fnames{k});
        STFT
        [W, H] = nmf(V,SOURCES,MAXITER);
        ISTFT
        PLOT
        for j=1:SOURCES
            Es(:,k,j) = xhat2(:,j);
        end
    end
end