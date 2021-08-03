%Time Delay Block 
function L = TimeDelayBlock(m,na,nb,U,Y)
L = zeros(m,na+nb+1);
for i = 1:m
    a=1;
    for j = 1:na+1
%         if j==1
%             L(i,j) = U(i);
%         else
            L(i+a,j) = U(i);
            a = a+1;
%         end
    end    
    b=1;
    for j = na+2:na+nb+1
%         if j==1
%             L(i,j) = U(i);
%         else
            L(i+b,j) = Y(i);
            b = b+1;
%         end
    end    
end