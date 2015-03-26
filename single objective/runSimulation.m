clear all
close all

load simulation3.mat
baselineParams = ones(1,40)*0.5;
trussCoords = getCoordsFromParams(baselineParams);
[baseLineIntensity, baselineFreq] = getIntensity(trussCoords);

figure('position',[50, 50, 1400, 1000],'color',[1, 1, 1]);

%baseline design
subplot(2,5,1:3)
hold on
for i=1:11
    bottoms(i,:)=[trussCoords((i-1)*2+1) trussCoords((i-1)*2+24)];
    tops(i,:)=[trussCoords(i*2) trussCoords(i*2+23)];
end
sp1(1) = plot(trussCoords(1:23), trussCoords(24:46), 'k.', 'MarkerSize', 10);
sp1(2) = plot(trussCoords(2:23), trussCoords(25:46), 'k', 'LineWidth', 2);
sp1(3) = plot(bottoms(:,1), bottoms(:,2), 'k', 'LineWidth', 2);
sp1(4) = plot(tops(:,1),tops(:,2), 'k', 'LineWidth', 2);
sp1(5) = plot([trussCoords(21); trussCoords(23)], [trussCoords(44); trussCoords(46)], 'k', 'LineWidth', 2);
axis equal
axis([0 11 -1 2])
axis off
title('Phenotype','fontweight','bold','fontsize',14)

subplot(2,5,6:8)
sp2(1) = plot(0,log(baseLineIntensity), '-b', 'linewidth', 3);
axis([0 numel(simulation.history) -14 -8])
title('Optimisation history','fontweight','bold','fontsize',14)
ylabel('(log) Intensity (100 - 200 Hz)','fontweight','bold','fontsize',14)
xlabel('Generations','fontweight','bold','fontsize',14)
set(gca, 'fontsize',14)

subplot(2,5,4:5)
baselineGenotype = encode(baselineParams, zeros(1, simulation.nVars), ones(1, simulation.nVars), ones(1, simulation.nVars)*simulation.encoding);
binVec = zeros(1,length(baselineGenotype));
for iBin = 1:length(baselineGenotype)
    binVec(iBin) = str2num(baselineGenotype(iBin));
end
sp3(1) = imagesc(reshape(binVec, simulation.encoding, simulation.nVars)');
colormap([1 1 1;0 0 0])
axis equal
axis off
title('Genotype','fontweight','bold','fontsize',14)

subplot(2,5,9:10)
hold on
sp4(1) = plot(baselineFreq, 'linewidth', 2);
sp4(2) = plot(0, 0, 'r', 'linewidth', 2);
box on
title('Frequency response','fontweight','bold','fontsize',14)
ylabel('PSD','fontweight','bold','fontsize',14)
xlabel('Frequency (Hz)','fontweight','bold','fontsize',14)
legend('Baseline','Current best')
set(gca, 'fontsize',14)

for iGen = 1:numel(simulation.history)
    pause(0.5)
    %sp1
    trussCoords = getCoordsFromParams(simulation.historyPhenotype(iGen,:));
    for i=1:11
        bottoms(i,:)=[trussCoords((i-1)*2+1) trussCoords((i-1)*2+24)];
        tops(i,:)=[trussCoords(i*2) trussCoords(i*2+23)];
    end
    set(sp1(1),'xdata',trussCoords(1:23),'ydata',trussCoords(24:46))
    set(sp1(2),'xdata',trussCoords(2:23),'ydata',trussCoords(25:46))
    set(sp1(3),'xdata',bottoms(:,1),'ydata',bottoms(:,2))
    set(sp1(4),'xdata',tops(:,1),'ydata',tops(:,2))
    set(sp1(5),'xdata',[trussCoords(21); trussCoords(23)],'ydata',[trussCoords(44); trussCoords(46)])
    %sp2
    set(sp2(1),'xdata',[0,1:iGen],'ydata',[log(baseLineIntensity),simulation.history(1:iGen)])
    %sp3
    binVec = zeros(1,length(baselineGenotype));
    genotype = simulation.historyGenotype{iGen};
    for iBin = 1:length(baselineGenotype)
        binVec(iBin) = str2num(genotype(iBin));
    end
    set(sp3(1),'cdata',reshape(binVec, simulation.encoding, simulation.nVars)')
    %sp4
    [~, freq] = getIntensity(trussCoords);
    set(sp4(2),'xdata',1:200,'ydata',freq)
    drawnow
end

