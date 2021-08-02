function [result] = shape_adapt_sw(img, iter)

    [m,n,c]=size(img);
    max_r = 9;
%     direction = zeros(1,max_r-min_r+1);
    m = size(img,1); n = size(img,2); total = m*n;
    [row, col]=ndgrid(1:m,1:n); 
    offset = row + m*(col-1) - total;
    result = img; 
    d = zeros(m,n,8,'single'); 
%     w_dim = mapping.lambda.*mapping.lambda;
%     w_dim = mapping.lambda;
%     w_dim = w_dim/sum(w_dim);
    r_box = [1 2 3 5 7 9 12];
        
    for k = 1:c
        U = img(:,:,k); 
        for it = 1:iter
            adapt_r = shape_adapt(U);
            for i = 1:m
                for j = 1:n
                    r = r_box(adapt_r(i,j))-1;
                    min_x = max(1,i-r);
                    max_x = min(m,i+r);
                    min_y = max(1,j-r);
                    max_y = min(n,j);
                    temp = U(min_x:max_x,min_y:max_y);
                    d(i,j,1) = mean(temp(:))-U(i,j);
                    % ???????每?
                    min_x = max(1,i-r);
                    max_x = min(m,i+r);
                    min_y = max(1,j);
                    max_y = min(n,j+r);
                    temp = U(min_x:max_x,min_y:max_y);
                    d(i,j,2) = mean(temp(:))-U(i,j);
                    % ???????每?
                    min_x = max(1,i-r);
                    max_x = min(m,i);
                    min_y = max(1,j-r);
                    max_y = min(n,j+r);
                    temp = U(min_x:max_x,min_y:max_y);
                    d(i,j,3) = mean(temp(:))-U(i,j);
                    % ???????每?
                    min_x = max(1,i);
                    max_x = min(m,i+r);
                    min_y = max(1,j-r);
                    max_y = min(n,j+r);
                    temp = U(min_x:max_x,min_y:max_y);
                    d(i,j,4) = mean(temp(:))-U(i,j);
                    % ?﹞?????每?
                    min_x = max(1,i-r);
                    max_x = min(m,i);
                    min_y = max(1,j-r);
                    max_y = min(n,j);
                    temp = U(min_x:max_x,min_y:max_y);
                    d(i,j,5) = mean(temp(:))-U(i,j);
                    % ???????每?
                    min_x = max(1,i-r);
                    max_x = min(m,i);
                    min_y = max(1,j);
                    max_y = min(n,j+r);
                    temp = U(min_x:max_x,min_y:max_y);
                    d(i,j,6) = mean(temp(:))-U(i,j);
                    % ?﹞?????每?
                    min_x = max(1,i);
                    max_x = min(m,i+r);
                    min_y = max(1,j-r);
                    max_y = min(n,j);
                    temp = U(min_x:max_x,min_y:max_y);
                    d(i,j,7) = mean(temp(:))-U(i,j);
                    % ???????每?
                    min_x = max(1,i);
                    max_x = min(m,i+r);
                    min_y = max(1,j);
                    max_y = min(n,j+r);
                    temp = U(min_x:max_x,min_y:max_y);
                    d(i,j,8) = mean(temp(:))-U(i,j);
                end
            end
            tmp = abs(d); 
            [~,ind] = min(tmp,[],3); 
            index = offset+total*ind;
            dm = d(index); %signed minimal distance
            %update
            U = U + dm; 
        end
        result(:,:,k) = U;
    end
end