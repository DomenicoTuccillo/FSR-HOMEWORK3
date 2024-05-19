function S = skew(in)
if (numel(in)~=1)
S=[0 -in(3) in(2);
   in(3) 0 -in(1);
   -in(2) in(1) 0];
else
    S=zeros(3);
end
end