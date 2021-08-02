function [data] = box(img,r,iter)
    [m,n,c] = size(img);
    data = zeros(m,n,c);

    
    for it = 1:iter
        temp = padarray(img,[r,r],'replicate');
        for i = 1+r:m+r
            for j = 1+r:n+r
                for k = 1:c
                    data(i-r,j-r,k) = sum(sum(temp(i-r:i+r,j-r:j+r,k)))/(2*r+1)^2;
                end
            end
        end
        img = data;
    end
    
end