clear all;clc
a0 = 3.4608;a1=3.0267;a2=1.4898;a3=1.8796;
b1=1.5989;b2=3.2095;b3=3.0386;b4=1.7805;b5=2.8709;
num = [a0 a1 a2 a3];
denum = [1 b1 b2 b3 b4 b5];
z = tf('z');
G = tf(num,denum,0.01,'Variable','z^-1')
%State Space digital controllable canonical form 
A =[0 1 0 0 0;
    0 0 1 0 0;
    0 0 0 1 0;
    0 0 0 0 1;
    -b5 -b4 -b3 -b2 -b1]
B = [0;0;0;0;1]
C = [-b5*a0 -b4*a0 a3-b3*a0 a2-b2*a0 a1-b1*a0]
D = a0

Gss = ss(A,B,C,D,0.1)
CC = ctrb(A,B);

rankCC = rank(CC);
if rankCC == size(B,1)
    disp("System is controllable");
else
    disp("System is uncontrollable!!! Check its stability");
end
discount_fac=0.1;
%Augmented Matrix 
F= -1;
Aaug = [A zeros(5,1);zeros(1,5) F]
T = Aaug;
Tbar = sqrt(discount_fac)*T
% Bone = [B;0.1];
Bone = [B A*B A^2*B A^3*B A^4*B A^5*B;0 0 0 0 0 0]
Bonebar = sqrt(discount_fac)*Bone;
Caug = [C*A^5;C*A^4;C*A^3;C*A^2;C*A;C];
% % % %Riccati Equation 
Q = 1.025;
R = 1;
Q1= [C'*Q*C -C'*Q;-Q*C Q];
N = 100;
% [P,K] = value_iteration(Tbar,N,Bonebar,Q1,R,discount_fac);
[PP,EE,KK] = dare(A,B,eye(5),R)
% [PP,EE,KK] = dare(T,Bone,Q1,R);
Kvv = inv(B'*PP*B+R)*B';
stateVec = [0;0;0;0;0];
refVec = 1;
X=[stateVec;refVec];
%Value Iteration 
AA = sqrt(discount_fac)*A
BB = sqrt(discount_fac)*B
[P,K] = value_iteration(AA,N,BB,Q,R,discount_fac);
Kv = inv(sqrt(discount_fac)*B'*P*sqrt(discount_fac)*B+R)*sqrt(discount_fac)*B';


% [PA,KA] = value_iteration(Tbar,N,Bonebar,Q1,R,discount_fac);
% Kva = inv(Bonebar'*PA*Bonebar+R)*Bonebar';





