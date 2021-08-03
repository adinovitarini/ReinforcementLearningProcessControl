function X = normalize(Y)
X = (((Y-min(Y))*(max(Y)-22))/(max(Y)-min(Y)))+22;
end