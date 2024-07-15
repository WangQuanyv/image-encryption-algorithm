function T1 = GF2p8Table()

a = zeros(1,8);
b = zeros(1,8);
AM = zeros(256,256);


for i = 0:pow2(8)-1
    for j = 1:8
        a(j) = mod(floor(i/pow2(8-j)),2);
    end
    for j = 0:pow2(8)-1
        for k = 1:8
            b(k) = mod(floor(j/pow2(8-k)),2);
        end
        t = mod(a+b,2);
        r = mod(t,2);
        v = sum(r.*pow2(7:-1:0));
        AM(i+1,j+1) = v;
    end    
end

T1 = AM;

end