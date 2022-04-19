function C = findcost(W,X,npop,dim,costfn,N)
    % X (global) is observed data and find the cost of each weight matrix
    % W (global) weight population matrix
    C = zeros(npop,dim);
    for k=1:npop
        U = W(:,:,k)*X;
        C(k,:) = costfn(U,N);
    end
end