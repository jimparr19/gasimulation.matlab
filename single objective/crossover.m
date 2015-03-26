function [o1, o2] = crossover(p1, p2)
% CROSSOVER(P1,P2,type) crossover operator
% p1, p2: parents

% Simple one-point crossover
crossPoint = floor(rand*length(p1)-1) + 1;
o1 = [p1(1:crossPoint),p2(crossPoint+1:length(p2))];
o2 = [p2(1:crossPoint),p1(crossPoint+1:length(p2))];

return