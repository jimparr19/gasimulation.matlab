function rStr = randBin(length)
% RAND_BIN returns a random binary string of specified length
% RAND_BIN(L) returns a random binary string of length L.
rStr = '';
rn = rand(1,length);
for poz = 1:length
    if rn(poz) < 0.5
        rStr = [rStr,'0'];
    else
        rStr = [rStr,'1'];
    end
end
return