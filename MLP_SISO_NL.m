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
%     iter = iter+1;
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
% wii = wih(1:na+1,nih);
% vii = wih(na+2:na+nb+1,nih);
% q1 = woh*wii';
% regressorInp = 0.25*sum(q1(:,1:size(wii,1)))
% q2 = woh*vii';
% regressorOut = 0.25*sum(q2(:,1:size(vii,1)))
% %Eigenvalues
% % A=eye(na,na)
% % for i = 1:na
% %     A(na,i) = regressorInp(i); 
% % end
% % B = zeros(na,1);
% % B(na,1)=1;
% % C = zeros(1,na);
% % D = 0;
wih 
woh
% %Applied to training 
% U_t = A(:,1);
% Y_t = A(:,4);
% m_row_t = size(Y_t,1); 
% L_t = TimeDelayBlock(m_row_t,na,nb,U_t,Y_t);
% L_t = L_t(1:m_row_t,:);
% k_t = forward(m_row,wih,L_t);
% a_t = forwardOut(m_row,woh,k_t);
% e_t = .5*((Y_t-a_t)'*(Y_t-a_t));
% %Applied to validation data 
% U_test = B(:,1);
% Y_test = B(:,2);
% m_row_test = size(Y_test,1);
% L_test = TimeDelayBlock(m_row_test,na,nb,U_test,Y_test);
% k_test = forward(1200,wih,L_test);
% a_test = forwardOut(1200,woh,k_test);
% a_test = normalize(a_test);
% time_elapsed = toc
% a_t = normalize(a_t);
% t_t = 1:1:m_row_t;
% t_t=t_t';
% subplot(211);
% plot(t_t,Y_t)
% hold on
% plot(t_t,a_t,'r')
% title('Training set')
% xlabel('time');
% ylabel('normalize concentration')
% legend('real data','estimated value')
% subplot(212);
% plot(t_t(1:m_row_test),a_test);
% hold on
% plot(t_t(1:m_row_test),Y_test,'r');
% title('Testing set')
% xlabel('time');
% ylabel('normalize concentration')
% legend('real data','estimated value')
% % [num,denum,Gz] = NN2TF(regressorInp,regressorOut,na,nb)