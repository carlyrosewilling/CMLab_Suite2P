function [smatrix]=shuffle(M)
num_cells=size(M,2);
half_col_len=round(size(M,1)/2);
smatrix=M;
for i=1:num_cells
    col = M(:,i);
    x = randi([-half_col_len,half_col_len],1);
    new_col = circshift(col,x);
    smatrix(:,i) = new_col;
end
end

