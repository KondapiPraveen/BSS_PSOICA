% PLOT BASIS Vectors
freq = linspace(0, fs/2, FFTSIZE/2+1);
time = linspace(0, length(x)/fs, T); 
% color = ['r','g','b',''];


figure;
for i=1:S
    plot((i-1)*max(max(W))+(1-W(:,i)),freq,'LineWidth', 3)
    hold on 
end
title('Basis Vectors')
ylabel('Frequency (Hz)')
xlabel('Basis')
set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);


%% PLOT ACTIVATIONS

figure;
for i=1:S
    plot(time, (i-1)*max(max(H))+(H(i,:)),'LineWidth', 3)
    hold on
end
ylabel('Activations')
xlabel('Time (seconds)')

set(gca, 'YTickLabelMode', 'manual', 'YTickLabel', []);

%% PLOT RECONSTRUCTION VS. ORIGINAL

figure;
subplot(2,1,1)
imagesc(db(V))
set(gca,'YDir','normal')
set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);
set(gca, 'YTickLabelMode', 'manual', 'YTickLabel', []);
title('Original')
ylabel('Frequency')
xlabel('Time')

subplot(2,1,2)
imagesc(db(W*H))
set(gca,'YDir','normal')
set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);
set(gca, 'YTickLabelMode', 'manual', 'YTickLabel', []);
title('Reconstruction')
ylabel('Frequency')
xlabel('Time')


%% PLOT LAYERS

figure;
CLIP = 100;
m = max(max(db(W*H)));
for i=1:S
    
    subplot(K,1,i)
    R = (max( db(W(:,i)*H(i,:)) - m, -CLIP) + CLIP)/CLIP;
    imagesc(R)
    set(gca,'YDir','normal')
    set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);
    set(gca, 'YTickLabelMode', 'manual', 'YTickLabel', []);
    set(gca, 'YTick', []);
    set(gca, 'XTick', []);
    ylabel('Frequency')
    xlabel('Time')
    title(['Layer from Basis Vector ' int2str(i) ])

end


%% PLOT MASKS

figure;
CLIP = 100;
m = max(max(db(W*H)));
for i=1:S
    
    subplot(K,1,i)
    R = (max( db(W(:,i)*H(i,:)./(W*H)) - m, -CLIP) + CLIP)/CLIP;
    imagesc(R)
    set(gca,'YDir','normal')
    set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);
    set(gca, 'YTickLabelMode', 'manual', 'YTickLabel', []);
    set(gca, 'YTick', []);
    set(gca, 'XTick', []);
    ylabel('Frequency')
    xlabel('Time')
    title(['Mask for Basis Vector ' int2str(i) ])

end