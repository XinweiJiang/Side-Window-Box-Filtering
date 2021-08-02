function [pca_img] = img_pca(img, dimen)
        
    [m,n,c]=size(img);
    img = reshape(img,m*n,c);

    % PCA��ά
    [mappedX, mapping] = pca1(img,dimen);
    pca_img = reshape(mappedX,m,n,dimen);
end
    