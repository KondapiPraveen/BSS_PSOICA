% Cost Functions

function C = icacost(U,N)
    a1 = 1;
    gU = g(a1,U); gN = g(a1,N);
    C = (mean(gU,2)-mean(gN,2)).^2;
end

function rs = g(a,x)
    rs = log10(cosh(a*x))./a;
end