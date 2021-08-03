function p = forwardOut(m_row,w,k)
for i =1:m_row
    p(i) = purelin(w'*k);
%     a(i) = (sum(p(i)));
end
p = p';