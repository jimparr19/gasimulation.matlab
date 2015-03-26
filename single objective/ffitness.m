function f = ffitness(bitstring, ObjFun, LB, UB, encoding)

for i=1:length(LB)
   GL(i) = encoding;
end

x = decode(bitstring, LB, UB, GL);
f = feval(ObjFun, x);

return