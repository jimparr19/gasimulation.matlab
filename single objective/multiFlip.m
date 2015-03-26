function operator = multiFlip(Prep, Pcr)
% Stochastic selection of operator to be used
a = rand;
if a < Prep
    operator = 1;
elseif a >= Prep && a < Prep+Pcr
    operator = 2;
else
    operator = 3;
end
return