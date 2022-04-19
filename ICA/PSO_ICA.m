% Modified PSO

close all; clc

% Initializing parameters and variables
npop=15; dim=sources; CFA=0.65; wmax=1.0; wmin=0.4; c1=1.5; c2=1.5;
epsilon = 1e-4;

b = 2*rand(dim,npop)-1; % Initialize random population
for l=1:npop
    b(:,l) = b(:,l)-B*B'*b(:,l);
    b(:,l) = b(:,l)/norm(b(:,l));
end
bpbest = b; % Each population personal best weights
% Cost of each population
U = b'*X;
C = icacost(U,N);
Cpbest = C;
Cgbest = zeros(maxcy,1);
[Cgbest(1), idx] = max(C); % best cost in generation
% Global best weight
bgbest = b(:,idx);
bgo = bgbest;

V = 0.01*ones(dim,npop);% Velocity initialization

for cy=2:maxcy
	w = wmax-((wmax-wmin)/maxcy)*cy;
	Vn = CFA*(w*V+c1*rand(dim,npop).*(bpbest-b)+c2*rand(dim,npop).*(bgbest-b));
	V = Vn;
	bn = b + V;
    %Wn(Wn>5)=5; Wn(Wn<-5) = -5; % Constraints
    for l=1:npop
        bn(:,l) = bn(:,l)-B*B'*bn(:,l);
        bn(:,l) = bn(:,l)/norm(bn(:,l));
    end
	b = bn;
    U = b'*X;
	C = icacost(U,N);
	[maxc, idx] = max(C);
    Cgbest(cy) = Cgbest(cy-1);
    if (maxc > Cgbest(cy-1))
        bgbest = b(:,idx);
        Cgbest(cy) = maxc;
    end
	idx = C > Cpbest;
	Cpbest(idx) = C(idx);
    bpbest(:,idx) = b(:,idx);
    if (mod(cy,5)==0)
        if ((norm(bgbest+bgo)<epsilon || norm(bgbest-bgo)<epsilon))
           break
        else
            bgo = bgbest;
        end
    end
end