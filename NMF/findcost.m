% find cost

Vx = zeros(F,T,Npop);
for k=1:Npop
    Vx(:,:,k) = W(:,:,k)*H(:,:,k);
end

C = cost(V, Vx);
[minJ, idx] = min(C);
Wx = W(:,:,idx);
Hx = H(:,:,idx);