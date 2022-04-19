function SDR = performance(icasig, S)
    Rs = icasig*icasig';
    [~,ind] = max(Rs,[],2);
    sources = size(icasig,1);
    SDR = zeros(sources,1);
    norms = S;

    for i=1:sources
        norms(i,:) = S(i,:)/(norm(S(i,:))^2);
    end

    for i=1:sources
        Es = (Rs(i,:)').*norms;
        SDR(i) = norm(Es(ind(i),:))^2/(norm((sum(Es) - Es(ind(i),:)))^2);
    end
    SDR = 10*log10(SDR);
end