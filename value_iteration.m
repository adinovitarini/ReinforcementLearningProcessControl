function [P,K] = value_iteration(Tbar,N,Bonebar,Q1,R,discount_fac)
%Policy Iteration Algorithm
K = ones(1,size(Tbar,1))
P = zeros(size(Tbar,1),size(Tbar,1));
for j = 1:N
%     if j~=1
    P_new = Q1 + K'*R*K
    +discount_fac*((Tbar-Bonebar*K)'*P*(Tbar-Bonebar*K))
    K_new = inv(R+Bonebar'*P_new*Bonebar)*Bonebar'*P_new*Tbar
%     Kv = inv(Bonebar'*P_new*Bonebar+R)*Bonebar';
    P = P_new;
    K = K_new;
%     end
end