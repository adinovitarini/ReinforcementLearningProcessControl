function a = forward(m_row,w,L)
for i =1:m_row
    a(i,:) = logsig(L(i,:)*w);
end
% a = a';
