function [Wx, Hx] = nmf(V, K, MAXITER)

F = size(V,1);
T = size(V,2);
Npop = 120;

rng(0)
W = rand(F, K, Npop);
% W = W./repmat(sum(W),F,1);
H = rand(K, T, Npop);

ONES = ones(F,T);
findcost;
Wold = Wx;
Hold = Hx;

for i=1:MAXITER
    for k=1:Npop 
        % update activations
        H(:,:,k) = H(:,:,k) .* (W(:,:,k)'*( V./(W(:,:,k)*H(:,:,k)+eps))) ./ (W(:,:,k)'*ONES);
        % update dictionaries
        W(:,:,k) = W(:,:,k) .* (( V./(W(:,:,k)*H(:,:,k)+eps))*H(:,:,k)') ./ (ONES*H(:,:,k)');
    end
    
    if (mod(i,5)==0)
        findcost
        if norm(Wold - Wx)<eps && norm(Hold-Hx)<eps
            break;
        else
            Wold = Wx; Hold = Hx;
        end
    end
end

% normalize W to sum to 1
for k=1:Npop
    sumW = sum(W(:,:,k));
    W(:,:,k) = W(:,:,k)*diag(1./sumW);
    H(:,:,k) = diag(sumW)*H(:,:,k);
end

findcost
sprintf("The minimum cost is %f", minJ)