function [num,denum,Gz] = NN2TF(regressorInp,regressorOut,na,nb)
%%NN2TF
a = regressorInp;
b = regressorOut;
z=tf('z',0.1);
for i = 1:na+1
   num(1,1) = a(1);
    if i~=1
    num(1,i) = a(i);
    end
end
for j = 1:nb+1
    denum(1,1) = 1;
    if j~=1
    denum(1,j) = -b(j-1);
    end
end
Gz = tf(num,denum,0.1);
%Cek Stability 
poles = roots([denum])
for i = 1:size(poles,2)
    if poles(i)<=1 && poles(i)>=-1
        disp('System is stable');
        %Cek Controlability 
        [A,B,C,D] = tf2ss(num,denum);
        CM = ctrb(A,B);
        if rank(CM) ~= size(B,1)
            disp("System is uncontrollable");
        else
            disp("System is controlable")
        end
        %Cek Observability 
        OM = (obsv(A,C));
        if rank(OM) ~= size(B,1)
            disp("System is unobservable");
        else
            disp("System is observable")
        end

    else
        disp('System is unstable')
        %Cek Controlability 
        [A,B,C,D] = tf2ss(num,denum);
        CM = det(ctrb(A,B));
        if CM > 0
            disp("System is stabilizable");
        else
            disp("System is uncontrollable and unstable")
        end
          %Cek Observability 
        OM = (obsv(A,C));
        if rank(OM) ~= size(B,1)
            disp("System is unonbservable");
        else
            disp("System is detectable")
        end
    end
end