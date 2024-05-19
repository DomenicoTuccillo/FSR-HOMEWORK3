function K = coeff(r)
[~,c]=butter(r,1,"low","s"); %butterworth coefficient
c=c(r+1:-1:1);%putting in the first slot c_0 and in the last one c_r, which is always 1
K(r)=c(r); %k_r=c_{r-1}
for i=r-1:-1:1
    K(i)=c(i)/prod(K(i+1:r));
end
end