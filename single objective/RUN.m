clear all
close all
tic
% ga params
popSize = 50;
genSize = 80;
nVars = 40;

encoding = 40; % bits per variable

LB = zeros(1, nVars);
UB = ones(1, nVars);
GL = ones(1, nVars)*encoding;

objFun = @objectiveFunction;
evalCount = 0;
history = [];
historyPhenotype = [];
historyGenotype = {};
evalHist =[];

% initial population
popIteration = 0;
while popIteration < popSize
    candidate = randBin(nVars*encoding);
    candFitness = ffitness(candidate, objFun, LB, UB, encoding);
    evalCount = evalCount + 1;
    
    popIteration = popIteration + 1;
    POPfit(popIteration) = candFitness;
    POP{popIteration} = candidate;
    
end

evalHist = [evalHist, evalCount];
[~, ind] = min(POPfit);
history = [history, POPfit(ind)];
historyPhenotype = [historyPhenotype; decode(POP{ind}, LB, UB, GL)];
historGenotype = [historyGenotype; POP{ind}];

% operator probabilities
pReproduction = 0.1;
pCrossover = 0.5;
pMutate = 0.4;
pMutateDash = 0.1;
nbits = round(pMutateDash*encoding/pMutate); %bits to mutate
tournamentSize = 5;

for iGen = 1:genSize
    iGen
    NEWPOP = {};
    NEWPOPfit = [];
    
    % preserve best solution
    [~, ind] = min(POPfit);
    
    NEWPOP = [NEWPOP, POP{ind}];
    NEWPOPfit = [NEWPOPfit, POPfit(ind)];
    bestSaved = NEWPOPfit(1);
    
    while length(NEWPOP) < popSize
        % randomly select an operator
        operator = multiFlip(pReproduction, pCrossover);
        switch operator
            case 1
                % Reproduction
                ind = tournament(POPfit, tournamentSize);
                NEWPOP = [NEWPOP, POP{ind}];
                NEWPOPfit = [NEWPOPfit, POPfit(ind)];
            case 2
                % Crossover
                ind1 = tournament(POPfit, tournamentSize);
                ind2 = tournament(POPfit, tournamentSize);
                [off1, off2] = crossover(POP{ind1}, POP{ind2});
                
                obj1 = ffitness(off1, objFun, LB, UB, encoding);
                obj2 = ffitness(off2, objFun, LB, UB, encoding);
                
                % Test for evaluation failure
                NEWPOP = [NEWPOP, off1];
                NEWPOPfit = [NEWPOPfit, obj1];
                
                NEWPOP = [NEWPOP, off2];
                NEWPOPfit = [NEWPOPfit, obj2];
                
                evalCount = evalCount + 2;
                
            case 3
                % Mutation
                ind = tournament(POPfit, tournamentSize);
                off = mutate(POP{ind}, nbits);
                obj = ffitness(off, objFun, LB, UB, encoding);
                
                % Test for evaluation failure
                NEWPOP = [NEWPOP, off];
                NEWPOPfit = [NEWPOPfit, obj];
                
                evalCount = evalCount + 1;
        end
        
    end
    
    % Should there be extra individuals (one or two)...
    if length(NEWPOP) > popSize
        NEWPOP = NEWPOP(1:popSize);
        NEWPOPfit = NEWPOPfit(1:popSize);
    end
    POP = NEWPOP;
    POPfit = NEWPOPfit;
    evalHist = [evalHist, evalCount];
    [~, ind] = min(POPfit);
    history = [history, POPfit(ind)];
    historyPhenotype = [historyPhenotype; decode(POP{ind}, LB, UB, GL)];
    historyGenotype = [historyGenotype; POP{ind}];
end

ind = tournament(POPfit, popSize);
bestvar = historyPhenotype(end,:);
bestobj = history(end);

figure
plot(history)

trussCoords = getCoordsFromParams(bestvar);
plotTruss(trussCoords)

[~, freqBaseline] = getIntensity(getCoordsFromParams(ones(1,nVars)*0.5));
[~, freq] = getIntensity(trussCoords);
figure
hold on
plot(freqBaseline)
plot(freq,'r')
toc

simulation.historyGenotype = historyGenotype;
simulation.historyPhenotype = historyPhenotype;
simulation.history = history;
simulation.nVars = nVars;
simulation.encoding = encoding;