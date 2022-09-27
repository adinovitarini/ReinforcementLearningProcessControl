function p = forwardOut(m_row,w,k)
for i =1:m_row
    p(i) = purelin(k(i,:)*w);
end
p = p';
