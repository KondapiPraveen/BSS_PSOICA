%% ISTFT / RECONSTRUCTION METHOD 1 (SYNTHESIS)

% get the mixture phase
%{
phi = angle(X);

for i=1:K
    
    XmagHat = W(:,i)*H(i,:);
    
    % create upper half of frequency before istft
    XmagHat = [XmagHat; conj( XmagHat(end-1:-1:2,:))];
   
    % Multiply with phase
    XHat = XmagHat.*exp(1i*phi);
    
    xhat1(:,i) = real(invmyspectrogram(XHat,HOPSIZE))';
    
end
% sound(xhat1(:,1),fs) 
% sound(xhat1(:,2),fs) 
% sound(xhat1(:,3),fs) 
%}
%% ISTFT / RECONSTRUCTION METHOD 2 (FILTERING)


% get the mixture phase
phi = angle(X);

for i=1:S
    
    % create masking filter
    Mask =  (W(:,i)*H(i,:)./(W*H));
    
    % filter
    XmagHat = V.*Mask; 
    
    % create upper half of frequency before istft
    XmagHat = [XmagHat; conj( XmagHat(end-1:-1:2,:))];
   
    % Multiply with phase
    XHat = XmagHat.*exp(1i*phi);
    
    % create upper half of frequency before istft
    xhat2(:,i) = real(invmyspectrogram(XmagHat.*exp(1i*phi),HOPSIZE))';
    
end
% sound(xhat1(:,1),fs) 
% sound(xhat1(:,2),fs) 
% sound(xhat1(:,3),fs) 
