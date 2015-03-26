function indm = mutate(chromosome, bits)
% MUTATE mutates a desired number of bits in a chromosome
% MUTATE(C,B) mutates a number B of bits in the string C
% Note: the mutation loci are randomly generated and it may
% happen that not all loci are distinct.

l = length(chromosome);
positions = floor(rand(bits,1)*l) + 1;
for i = 1:bits
    if chromosome(positions(i))=='1'
        chromosome(positions(i))='0';
    else
        chromosome(positions(i))='1';
    end
end
indm=chromosome;
return