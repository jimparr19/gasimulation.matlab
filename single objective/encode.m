function chromosome = encode(x,LLIMIT,ULIMIT,GL)
%Encodes a vector into a binary chromosome

for i=1:length(x)
  if x(i)>ULIMIT(i)-0.01
	x(i) = ULIMIT(i)-0.01;
  end
end

chromosome = [];

for i=1:length(LLIMIT)
   unit = (ULIMIT(i)-LLIMIT(i))/(2^GL(i));
   xx = round((x(i)-LLIMIT(i))/unit);
   chromosome = [chromosome,dec2bin(xx,GL(i))];   
end

return