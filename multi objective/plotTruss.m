function plotTruss(trussCoords)

figure('position',[222, 341, 1005, 253], 'color', [1, 1, 1])
hold on
plot(trussCoords(1:23), trussCoords(24:46), 'k.', 'MarkerSize', 10)
for i=1:11
    bottoms(i,:)=[trussCoords((i-1)*2+1) trussCoords((i-1)*2+24)];
    tops(i,:)=[trussCoords(i*2) trussCoords(i*2+23)];   
end

plot(trussCoords(2:23), trussCoords(25:46), 'k', 'LineWidth', 2)
plot(bottoms(:,1), bottoms(:,2), 'k', 'LineWidth', 2)
plot(tops(:,1),tops(:,2), 'k', 'LineWidth', 2)
plot([trussCoords(21); trussCoords(23)], [trussCoords(44); trussCoords(46)], 'k', 'LineWidth', 2)
axis equal
axis([0 11 -1 2])
axis off