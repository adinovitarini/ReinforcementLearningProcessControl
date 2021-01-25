function [P,K] = policy_iteration(A,N,B,Q1,R,discount_fac)
%Policy Iteration Algorithm 
K = rand(1,size(A,1));
P = zeros(size(A,1),size(A,1));
for j = 1:N
%     if j~=1
    P = Q1 + K'*R*K+discount_fac*((A-B*K)'*P*(A-B*K));
    K_new = inv(R+discount_fac*B'*P*B)*discount_fac*B'*P*A;
%     Kv = inv(Bone'*P*Bone+R)*Bone';
%     end
end