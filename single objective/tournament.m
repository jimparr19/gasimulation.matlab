function ind = tournament(POPfit, tournamentSize)
pool = zeros(1,tournamentSize);
for i = 1:tournamentSize
    wrn = floor(rand*length(POPfit))+1;
    pool(i) = wrn;
end

[~, b] = min(POPfit(pool));

ind = pool(b);
return