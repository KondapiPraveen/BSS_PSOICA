% Cost Functions

function C = cost(V,Vx)
    ft = V./Vx;
    ft(isnan(ft)) = 1;
    D = V.*log(ft) - V + Vx;
    C = sum(D, [1 2]);
end