% ICA Program
close all; clear; clc;
% Load the Source data X (global) dim*len matrix
folder = "../sounds/MultiChannel/"; sources = 2; %folder containing files & Number of sources
audioname = ["T1_S1.wav","T1_S2.wav"];
for k=1:sources
	[at,fs] = audioread(folder+audioname(k));
    % The length of 1st source is set as length for all sources
    % The first source should be of smallest length
	if k == 1
		len = numel(at(:,1));
		S = zeros(sources,len);
	end
	S(k,:) = at(1:len,1)';
end

%% Mixing of Sources
rng(0);
v = rand(1,sources)*0.4+0.6;
A = diag(v);
A = A + (A==0).*rand(sources).*0.4; % Mixing Matrix
M = A*S; % Mixed Signal
% ICA Preprocessing

% Centering
m = mean(M,2);
M = M-m;
% Whitening
covMatrix = cov(M',1);
[E, D] = eig(covMatrix);
whiteMatrix = sqrt(D)\E';
dewhiteMatrix = E*sqrt(D);
X = whiteMatrix*M; % Whitened Signal

%% FastICA Implementation

time2 = tic;
[icasig2, ~, W2] = fastica(X);
execution_time2 = toc(time2);
%% PSO Optimization to find DeMixing Matrix
time = tic;
maxcy=30;
B = zeros(sources,sources);
W = zeros(sources,sources);
Cost = zeros(maxcy,sources);
for IC=1:sources
    N = randn(1,size(X,2)); % Gaussian Random Variable
    PSO_ICA
    Cost(:,IC) = Cgbest;
    B(:,IC) = bgbest;
    W(IC,:) = bgbest'*whiteMatrix;
end

for IC=1:sources
    W(IC,:) = W(IC,:)/norm(W(IC,:));
end
icasig = W*M + W*m;

execution_time = toc(time);
%% Save the data
st = "ICA_";
en = "_E.wav";
for i=1:sources
    file = char(audioname(i));
    audiowrite(folder+st+string(file(1:end-4))+en,icasig(i,:),fs);
end
%% ICA Performance
% Demixing and Mixing Matrix product
I = W*A; % A diagnoal matrix with +/- 1 value is ideal
I2 = W2*A;

% Source to Distortion Ratio
SDR = zeros(2,sources);

sig = icasig - mean(icasig,2);
Ms = S - mean(S,2);

SDR(1,:) = performance(sig, Ms);
sig = icasig2 - mean(icasig2,2);
SDR(2,:) = performance(sig, Ms);