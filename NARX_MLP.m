clearvars -except dataCampur p 
clc
clf
tic
U = p(:,2);
Y = p(:,1); 
m_row = size(Y,1);
na = 2;
nb = 3;
L = TimeDelayBlock(m_row,na,nb,U,Y);
n_col = size(L,2);
L = L(1:m_row,:);
nih = 3; %jumlah neuron hidden layer
alfa = 0.25;
wih = rand(n_col,nih);
woh = rand(nih,1);
b = ones(m_row,1);
k = forward(m_row,wih,L);
a = forwardOut(m_row,woh,k);
e = (Y-a)'*(Y-a);
iter = 0;
e_tol=1;
for iter = 1:0.1:11
for i=1:m_row
%  while iter <= 3000
%delta output matrix 
a_dot(i) = dpurelin(a(i));
delta_output(i,:) = (Y(i)-a(i)).*a_dot(i);
e(i) = .5*((Y(i)-a(i))'*(Y(i)-a(i)));
%delta of hidden layer 
delta_woh(i,:) = woh*delta_output(i,:);
transfer = dlogsig(wih,logsig(wih));
delta_hidden = [];
delta_hidden(i,:) = delta_woh(i,:)*transfer';
% 
% update weight output  
woh_new = woh + alfa*(k(i,:)'*delta_output(i,:));
woh = woh_new;
% 
% update weight hidden 
wih_new = wih + alfa*L(i,:)*delta_hidden(i,:)';
wih = wih_new;
k_new = forward(m_row,wih,L);
a_new = forwardOut(m_row,woh,k_new);
a = a_new;
    end
end
mse_e = mse(Y,a);
rmse_e = sqrt(mse_e);
fprintf('MSE : %f \n',mse_e);
fprintf('RMSE : %f \n',rmse_e);
% a = normalize(a);+1
t = 1:m_row;
t=t';
plot(t,Y)
hold on
plot(t,a,'r')
% %%%Combine ARX and MLP 
wii = wih(1:na+1,nih);
vii = wih(na+2:na+nb+1,nih);
q1 = woh*wii';
regressorInp = 0.25*sum(q1(:,1:size(wii,1)))
q2 = woh*vii';
regressorOut = 0.25*sum(q2(:,1:size(vii,1)))
[num,denum,Gz] = NN2TF(regressorInp,regressorOut,na,nb)
