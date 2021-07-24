clc
%%LQT konvensiona using Digital Algebraic Riccati Equation 
a0 = -0.3935;a1=0.6689;a2=-0.4765;
b1=0.1146;b2=0.0508;b3=0.0645;
num = [a0 a1 a2];
denum = [1 b1 b2 b3];
z = tf('z');
G = tf(num,denum,0.01,'Variable','z^-1');
%State Space digital controllable canonical form 
A =[0 1 0;
    0 0 1;
    -b3 -b2 -b1];
B = [0;0;1];
C = [-b3*a0 a2-b2*a0 a1-b1*a0];
D = a0;
%Q and R matrix 
Q = eye(3);
R = 1;
[P_dare,eig_dare,K_dare] = dare(A,B,Q,R);
Kv = inv(B'*P_dare*B+R)*B';
