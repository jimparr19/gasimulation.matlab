function mass = getMass(trussCoords)

for i=1:11
    bottoms(i,:)=[trussCoords((i-1)*2+1) trussCoords((i-1)*2+24)];
    tops(i,:)=[trussCoords(i*2) trussCoords(i*2+23)];   
end

%inside elements
xMid = trussCoords(2:23);
yMid = trussCoords(25:46);
for i = 1:21
    insideLength(i) = sqrt((xMid(i)-xMid(i+1))^2+(yMid(i)-yMid(i+1))^2);
end

%bottom elements
xBot = bottoms(:,1)';
yBot = bottoms(:,2)';
for i = 1:10
    bottomLength(i) = sqrt((xBot(i)-xBot(i+1))^2+(yBot(i)-yBot(i+1))^2);
end

%top elements
xTop = tops(:,1)';
yTop = tops(:,2)';
for i = 1:10
    topLength(i) = sqrt((xTop(i)-xTop(i+1))^2+(yTop(i)-yTop(i+1))^2);
end

%end element
endLength = sqrt((trussCoords(21)-trussCoords(23))^2+(trussCoords(44)-trussCoords(46))^2);

totalLength = sum(insideLength)+sum(bottomLength)+sum(topLength);

mass = totalLength*2.74;