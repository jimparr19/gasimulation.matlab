clear all
close all

load simulation.mat

baselineParams = ones(1,40)*0.5;
trussCoords = getCoordsFromParams(baselineParams);
baseLineIntensity = getIntensity(trussCoords);
baseLineMass = getMass(trussCoords);

figure('position',[100, 200, 1400, 700],'color',[1, 1, 1]);

%baseline design
subplot(3,6,4:6)
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
title('Minimum intensity','fontweight','bold','fontsize',14)

subplot(3,6,10:12)
hold on
for i=1:11
    bottoms(i,:)=[trussCoords((i-1)*2+1) trussCoords((i-1)*2+24)];
    tops(i,:)=[trussCoords(i*2) trussCoords(i*2+23)];
end
sp2(1) = plot(trussCoords(1:23), trussCoords(24:46), 'k.', 'MarkerSize', 10);
sp2(2) = plot(trussCoords(2:23), trussCoords(25:46), 'k', 'LineWidth', 2);
sp2(3) = plot(bottoms(:,1), bottoms(:,2), 'k', 'LineWidth', 2);
sp2(4) = plot(tops(:,1),tops(:,2), 'k', 'LineWidth', 2);
sp2(5) = plot([trussCoords(21); trussCoords(23)], [trussCoords(44); trussCoords(46)], 'k', 'LineWidth', 2);
axis equal
axis([0 11 -1 2])
axis off
title('Trade-off','fontweight','bold','fontsize',14)

subplot(3,6,16:18)
hold on
for i=1:11
    bottoms(i,:)=[trussCoords((i-1)*2+1) trussCoords((i-1)*2+24)];
    tops(i,:)=[trussCoords(i*2) trussCoords(i*2+23)];
end
sp3(1) = plot(trussCoords(1:23), trussCoords(24:46), 'k.', 'MarkerSize', 10);
sp3(2) = plot(trussCoords(2:23), trussCoords(25:46), 'k', 'LineWidth', 2);
sp3(3) = plot(bottoms(:,1), bottoms(:,2), 'k', 'LineWidth', 2);
sp3(4) = plot(tops(:,1),tops(:,2), 'k', 'LineWidth', 2);
sp3(5) = plot([trussCoords(21); trussCoords(23)], [trussCoords(44); trussCoords(46)], 'k', 'LineWidth', 2);
axis equal
axis([0 11 -1 2])
axis off
title('Minimum mass','fontweight','bold','fontsize',14)

subplot(3,6,[1,2,3,7,8,9,13,14,15])
hold on
sp4(1) = plot(log(baseLineIntensity), baseLineMass, 'og', 'markerfacecolor', 'g');
sp4(2) = plot(0, 0, 'ob', 'markerfacecolor', 'b');
sp4(3) = plot(0, 0, 'or', 'markerfacecolor', 'r');
axis([-14 -9 105 135])
title('Optimisation history','fontweight','bold','fontsize',14)
xlabel('(log) Intensity (100 - 200 Hz)','fontweight','bold','fontsize',14)
ylabel('Mass (kg)','fontweight','bold','fontsize',14)
legend('Baseline','Evaluations', 'Pareto front')
box on
set(gca, 'fontsize',14)

allEvaluations = [];
for iGen = 1:simulation.gen
    pause(0.5)
    chromosomes = simulation.history(iGen).chromosome;
    objVals = chromosomes(:,simulation.nVars+1:simulation.nVars+2);
    allEvaluations = [allEvaluations; objVals];
    paretoIndx = find(chromosomes(:,simulation.nVars+3) == 1);
    pareto = objVals(paretoIndx,:);
    [~, minIntensityIndx] = min(objVals(:,1));
    minIntensityDesign = chromosomes(minIntensityIndx,1:simulation.nVars);
    [~, minMassIndx] = min(objVals(:,2));
    minMassDesign = chromosomes(minMassIndx,1:simulation.nVars);
    
    [~,sortInd] = sort(pareto(:,1));
    tradeOffDesign = chromosomes(sortInd(floor(length(pareto(:,1))/2)),1:simulation.nVars);
    
    %sp1
    trussCoords = getCoordsFromParams(minIntensityDesign);
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
    trussCoords = getCoordsFromParams(tradeOffDesign);
    for i=1:11
        bottoms(i,:)=[trussCoords((i-1)*2+1) trussCoords((i-1)*2+24)];
        tops(i,:)=[trussCoords(i*2) trussCoords(i*2+23)];
    end
    set(sp2(1),'xdata',trussCoords(1:23),'ydata',trussCoords(24:46))
    set(sp2(2),'xdata',trussCoords(2:23),'ydata',trussCoords(25:46))
    set(sp2(3),'xdata',bottoms(:,1),'ydata',bottoms(:,2))
    set(sp2(4),'xdata',tops(:,1),'ydata',tops(:,2))
    set(sp2(5),'xdata',[trussCoords(21); trussCoords(23)],'ydata',[trussCoords(44); trussCoords(46)])
    
    %sp3
    trussCoords = getCoordsFromParams(minMassDesign);
    for i=1:11
        bottoms(i,:)=[trussCoords((i-1)*2+1) trussCoords((i-1)*2+24)];
        tops(i,:)=[trussCoords(i*2) trussCoords(i*2+23)];
    end
    set(sp3(1),'xdata',trussCoords(1:23),'ydata',trussCoords(24:46))
    set(sp3(2),'xdata',trussCoords(2:23),'ydata',trussCoords(25:46))
    set(sp3(3),'xdata',bottoms(:,1),'ydata',bottoms(:,2))
    set(sp3(4),'xdata',tops(:,1),'ydata',tops(:,2))
    set(sp3(5),'xdata',[trussCoords(21); trussCoords(23)],'ydata',[trussCoords(44); trussCoords(46)])
    
    %sp4
    set(sp4(2),'xdata' ,allEvaluations(:,1),'ydata', allEvaluations(:,2));
    set(sp4(3),'xdata',pareto(:,1), 'ydata', pareto(:,2));
    
end
