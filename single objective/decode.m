function x=decode(chromosome, LLIMIT, ULIMIT, GL)
% DECODE decodes a binary chromosome
% DECODE(C,L,U,G) is a vector with length(L) elements, containing
% the genes decoded from the chromosome binary string C, given the
% lower limits (array L) and upper limits (array U) of the respective
% variables. The array GL contains the lengths of the genes of the 
% variables. All three input arrays have the same length, equal to 
% the number of variables.
x = zeros(1,length(LLIMIT));
for i = 1:length(LLIMIT)
    x(i) = bin2dec(chromosome(sum(GL(1:i-1)) + 1:sum(GL(1:i))));
    x(i) = LLIMIT(i) + x(i)*(ULIMIT(i) - LLIMIT(i))/(2^GL(i) - 1);
end
return